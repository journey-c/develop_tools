local util = require "custom_plugins.git.util"
local diff = {}
local api  = vim.api
local fn   = vim.fn

-- 当前 diff 会话的状态
local state = nil

-- 文件列表高亮命名空间
local ns = api.nvim_create_namespace("gitdiff_files")

-- 需要在打开/关闭时保存/还原的窗口 local 选项
local SAVE_OPTS = {
    "number", "relativenumber", "wrap", "cursorline",
    "winbar", "signcolumn", "foldcolumn", "fillchars", "list",
}

local function save_win_opts(win)
    local saved = {}
    for _, name in ipairs(SAVE_OPTS) do
        local ok, v = pcall(api.nvim_get_option_value, name, { win = win })
        if ok then saved[name] = v end
    end
    return saved
end

local function restore_win_opts(win, saved)
    if not saved or not api.nvim_win_is_valid(win) then return end
    for _, name in ipairs(SAVE_OPTS) do
        if saved[name] ~= nil then
            pcall(api.nvim_set_option_value, name, saved[name], { win = win })
        end
    end
end

local function scratch_buf(name)
    local buf = api.nvim_create_buf(false, true)
    api.nvim_set_option_value("buftype", "nofile", { buf = buf })
    api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
    api.nvim_set_option_value("swapfile", false, { buf = buf })
    if name then
        pcall(api.nvim_buf_set_name, buf, name .. "-" .. api.nvim_get_current_buf())
    end
    return buf
end

local function set_lines(buf, lines)
    api.nvim_set_option_value("modifiable", true, { buf = buf })
    api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    api.nvim_set_option_value("modifiable", false, { buf = buf })
end

local function apply_ft(buf, path)
    local ft = vim.filetype.match({ filename = path })
    if ft then api.nvim_set_option_value("filetype", ft, { buf = buf }) end
end

local function compose(chunks)
    local text, hls, col = "", {}, 0
    for _, c in ipairs(chunks) do
        local seg = c[1]
        if c[2] then hls[#hls + 1] = { col, col + #seg, c[2] } end
        text = text .. seg
        col = col + #seg
    end
    return text, hls
end

--------------------------------------------------------------------------
-- 目录树
--------------------------------------------------------------------------

local function build_tree(files)
    local root = { name = "", path = "", dirs = {}, dir_order = {}, files = {} }
    for _, f in ipairs(files) do
        local parts = vim.split(f.path, "/", { plain = true })
        local node = root
        for i = 1, #parts - 1 do
            local seg = parts[i]
            if not node.dirs[seg] then
                local child = {
                    name = seg,
                    path = (node.path == "" and seg or node.path .. "/" .. seg),
                    dirs = {}, dir_order = {}, files = {},
                }
                node.dirs[seg] = child
                table.insert(node.dir_order, seg)
            end
            node = node.dirs[seg]
        end
        f.name = parts[#parts]
        table.insert(node.files, f)
    end
    return root
end

local function compress(node)
    for _, seg in ipairs(node.dir_order) do compress(node.dirs[seg]) end
    while node.name ~= "" and #node.dir_order == 1 and #node.files == 0 do
        local only = node.dirs[node.dir_order[1]]
        node.name = node.name .. "/" .. only.name
        node.path = only.path
        node.dirs = only.dirs
        node.dir_order = only.dir_order
        node.files = only.files
    end
end

-- 复用主题高亮：目录用 Directory，文件默认色不加 hl（取 Normal），
-- 当前文件用 Title（粗体同色），指引线用 Comment（灰）。
local function render_node(node, prefix, lines, line_map, hls, cur_path, row_of)
    local dirs = {}
    for _, seg in ipairs(node.dir_order) do dirs[#dirs + 1] = node.dirs[seg] end
    table.sort(dirs, function(a, b) return a.name < b.name end)

    local files = {}
    for _, f in ipairs(node.files) do files[#files + 1] = f end
    table.sort(files, function(a, b) return a.name < b.name end)

    local total = #dirs + #files
    local idx = 0

    for _, child in ipairs(dirs) do
        idx = idx + 1
        local last = (idx == total)
        local branch = last and "└ " or "├ "
        local arrow  = child.collapsed and "› " or "⌄ "
        local text, line_hls = compose({
            { prefix, "Comment" },
            { branch, "Comment" },
            { arrow,  "Directory" },
            { child.name .. "/", "Directory" },
        })
        lines[#lines + 1] = text
        local row = #lines
        line_map[row] = { kind = "dir", node = child }
        for _, h in ipairs(line_hls) do hls[#hls + 1] = { row - 1, h[1], h[2], h[3] } end
        if not child.collapsed then
            local child_prefix = prefix .. (last and "  " or "│ ")
            render_node(child, child_prefix, lines, line_map, hls, cur_path, row_of)
        end
    end

    for _, f in ipairs(files) do
        idx = idx + 1
        local last = (idx == total)
        local is_cur = (f.path == cur_path)
        local branch = last and "└ " or "├ "
        local name_hl = is_cur and "Title" or nil
        local text, line_hls = compose({
            { prefix, "Comment" },
            { branch, "Comment" },
            { f.name, name_hl },
        })
        lines[#lines + 1] = text
        local row = #lines
        line_map[row] = { kind = "file", file = f }
        row_of[f.path] = row
        for _, h in ipairs(line_hls) do hls[#hls + 1] = { row - 1, h[1], h[2], h[3] } end
        -- 右对齐统计：+N 绿 / -N 红，用 gitsigns 高亮（主题已定义）
        hls[#hls + 1] = {
            row - 1, 0, 0, nil,
            virt = {
                { "+" .. (f.added or 0),   "GitSignsAdd" },
                { " ",                     nil },
                { "-" .. (f.removed or 0), "GitSignsDelete" },
                { "  ",                    nil },
            },
        }
    end
end

function diff.render_list()
    local s = state
    if not s then return end
    local lines, line_map, hls = {}, {}, {}
    s.row_of = {}
    render_node(s.tree, "", lines, line_map, hls, s.current_path, s.row_of)
    if #lines == 0 then lines = { "(无变更文件)" } end
    set_lines(s.list_buf, lines)
    s.line_map = line_map

    api.nvim_buf_clear_namespace(s.list_buf, ns, 0, -1)
    for _, h in ipairs(hls) do
        if h.virt then
            api.nvim_buf_set_extmark(s.list_buf, ns, h[1], 0, {
                virt_text = h.virt, virt_text_pos = "right_align",
            })
        elseif h[4] then
            pcall(api.nvim_buf_set_extmark, s.list_buf, ns, h[1], h[2], {
                end_col = h[3], hl_group = h[4],
            })
        end
    end
end

--------------------------------------------------------------------------
-- 加载 / 关闭 / 交互
--------------------------------------------------------------------------

local function load_file(file)
    local s = state
    if not s or not file then return end
    s.current_path = file.path

    if api.nvim_win_is_valid(s.left_win) then
        api.nvim_win_call(s.left_win, function() vim.cmd("diffoff") end)
    end
    if api.nvim_win_is_valid(s.right_win) then
        api.nvim_win_call(s.right_win, function() vim.cmd("diffoff") end)
    end

    local old_lines = util.file_content(s.base, file.path)
    local new_lines = util.file_content(s.target, file.path)

    set_lines(s.left_buf, old_lines)
    set_lines(s.right_buf, new_lines)
    apply_ft(s.left_buf, file.path)
    apply_ft(s.right_buf, file.path)

    api.nvim_win_call(s.left_win, function() vim.cmd("diffthis") end)
    api.nvim_win_call(s.right_win, function() vim.cmd("diffthis") end)

    diff.render_list()
    local row = s.row_of and s.row_of[file.path]
    if row then pcall(api.nvim_win_set_cursor, s.list_win, { row, 0 }) end
end

function diff.close()
    local s = state
    state = nil
    if not s then return end

    if api.nvim_win_is_valid(s.right_win) then
        pcall(api.nvim_win_call, s.right_win, function() vim.cmd("diffoff") end)
        pcall(api.nvim_win_close, s.right_win, true)
    end
    if api.nvim_win_is_valid(s.list_win) then
        pcall(api.nvim_win_close, s.list_win, true)
    end
    if api.nvim_win_is_valid(s.left_win) then
        pcall(api.nvim_win_call, s.left_win, function() vim.cmd("diffoff") end)
        if api.nvim_buf_is_valid(s.orig_buf) then
            api.nvim_win_set_buf(s.left_win, s.orig_buf)
        end
        restore_win_opts(s.left_win, s.saved_opts)
        api.nvim_set_current_win(s.left_win)
    end
end

local function select_current()
    local s = state
    if not s then return end
    local row = api.nvim_win_get_cursor(s.list_win)[1]
    local item = s.line_map and s.line_map[row]
    if not item then return end
    if item.kind == "dir" then
        item.node.collapsed = not item.node.collapsed
        diff.render_list()
        pcall(api.nvim_win_set_cursor, s.list_win, { row, 0 })
    elseif item.kind == "file" then
        load_file(item.file)
    end
end

-- opts = { base, target }
function diff.open(opts)
    opts = opts or {}
    if not util.in_repo() then
        vim.notify("当前目录不是 git 仓库", vim.log.levels.WARN)
        return
    end
    if state then diff.close() end

    local base   = opts.base or "HEAD"
    local target = opts.target or ""

    local files = util.changed_files(base, target)
    if #files == 0 then
        vim.notify("没有发现变更文件", vim.log.levels.INFO)
        return
    end

    local tree = build_tree(files)
    compress(tree)

    local orig_win = api.nvim_get_current_win()
    local orig_buf = api.nvim_win_get_buf(orig_win)
    local saved_opts = save_win_opts(orig_win)

    -- 左窗口：直接用原窗口
    local left_win = orig_win
    local left_buf = scratch_buf("git-diff://old")
    api.nvim_win_set_buf(left_win, left_buf)

    -- 右窗口：左的右侧
    vim.cmd("rightbelow vsplit")
    local right_win = api.nvim_get_current_win()
    local right_buf = scratch_buf("git-diff://new")
    api.nvim_win_set_buf(right_win, right_buf)

    -- 底部文件列表
    vim.cmd("botright split")
    local list_win = api.nvim_get_current_win()
    local list_buf = scratch_buf("git-diff://files")
    api.nvim_win_set_buf(list_win, list_buf)
    api.nvim_win_set_height(list_win, math.max(8, math.floor(vim.o.lines * 0.28)))

    api.nvim_set_option_value("filetype",  "gitdiff_files", { buf = list_buf })
    api.nvim_set_option_value("cursorline", true,  { win = list_win })
    api.nvim_set_option_value("number",         false, { win = list_win })
    api.nvim_set_option_value("relativenumber", false, { win = list_win })
    api.nvim_set_option_value("signcolumn",    "no", { win = list_win })
    api.nvim_set_option_value("foldcolumn",    "0",  { win = list_win })
    api.nvim_set_option_value("winfixheight",  true, { win = list_win })
    api.nvim_set_option_value("wrap",          false,{ win = list_win })

    state = {
        orig_buf     = orig_buf,
        saved_opts   = saved_opts,
        left_win     = left_win,
        right_win    = right_win,
        list_win     = list_win,
        left_buf     = left_buf,
        right_buf    = right_buf,
        list_buf     = list_buf,
        tree         = tree,
        files        = files,
        base         = base,
        target       = target,
        current_path = nil,
    }

    local map_opts = { buffer = list_buf, silent = true, nowait = true }
    vim.keymap.set("n", "<CR>", select_current, map_opts)
    vim.keymap.set("n", "q",    diff.close,     map_opts)
    vim.keymap.set("n", "q", diff.close, { buffer = left_buf, silent = true })
    vim.keymap.set("n", "q", diff.close, { buffer = right_buf, silent = true })

    diff.render_list()
    load_file(files[1])
    api.nvim_set_current_win(list_win)
end

return diff
