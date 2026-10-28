local util = require "custom_plugins.git.util"
local diff = require "custom_plugins.git.diff"
local log  = {}
local api  = vim.api

local state = nil
local ns = api.nvim_create_namespace("gitlog")

local SAVE_OPTS = {
    "number", "relativenumber", "wrap", "cursorline",
    "winbar", "signcolumn", "foldcolumn", "fillchars",
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

-- 用 "hide"：log buffer 在打开 diff 时不会被销毁，保证 q 映射能活到回来
local function scratch_buf(name)
    local buf = api.nvim_create_buf(false, true)
    api.nvim_set_option_value("buftype", "nofile", { buf = buf })
    api.nvim_set_option_value("bufhidden", "hide", { buf = buf })
    api.nvim_set_option_value("swapfile", false, { buf = buf })
    if name then pcall(api.nvim_buf_set_name, buf, name) end
    return buf
end

-- 一次性渲染。颜色全部复用主题高亮：
--   hash    -> Identifier (黄 in gruvbox)
--   subject -> Normal
--   作者    -> Comment
--   日期    -> NonText (更暗)
local function render(buf, entries)
    local lines = {}
    for _, e in ipairs(entries) do
        lines[#lines + 1] = string.format(" %s  %s", e.short, e.subject)
    end
    if #lines == 0 then lines = { "(无提交记录)" } end
    api.nvim_set_option_value("modifiable", true, { buf = buf })
    api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    api.nvim_set_option_value("modifiable", false, { buf = buf })

    api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    for i, e in ipairs(entries) do
        local row = i - 1
        api.nvim_buf_set_extmark(buf, ns, row, 1, {
            end_col = 1 + #e.short, hl_group = "Identifier",
        })
        api.nvim_buf_set_extmark(buf, ns, row, 0, {
            virt_text = {
                { e.author .. " ", "Comment" },
                { e.date .. "  ",  "NonText" },
            },
            virt_text_pos = "right_align",
        })
    end
end

local function show_diff()
    local s = state
    if not s then return end
    local row = api.nvim_win_get_cursor(s.win)[1]
    local entry = s.entries[row]
    if not entry then return end
    diff.open({
        base   = entry.hash .. "^",
        target = entry.hash,
    })
end

local function close()
    local s = state
    state = nil
    if not s then return end
    if api.nvim_win_is_valid(s.win) then
        if api.nvim_buf_is_valid(s.orig_buf) then
            api.nvim_win_set_buf(s.win, s.orig_buf)
        end
        restore_win_opts(s.win, s.saved_opts)
    end
    if api.nvim_buf_is_valid(s.buf) then
        pcall(api.nvim_buf_delete, s.buf, { force = true })
    end
end

-- 每次进入 log buffer 都重装一次 q 映射（防止从 diff 回来时失效），
-- 并保证窗口选项是 log 期望的状态。
local function arm(s)
    local function install()
        local map_opts = { buffer = s.buf, silent = true, nowait = true }
        vim.keymap.set("n", "<CR>", show_diff, map_opts)
        vim.keymap.set("n", "q",    close,     map_opts)
    end
    install()
    api.nvim_create_autocmd("BufEnter", {
        buffer = s.buf,
        callback = function()
            install()
            if api.nvim_win_is_valid(s.win) then
                api.nvim_set_option_value("number", false,         { win = s.win })
                api.nvim_set_option_value("relativenumber", false, { win = s.win })
                api.nvim_set_option_value("cursorline", true,      { win = s.win })
                api.nvim_set_option_value("signcolumn", "no",      { win = s.win })
                api.nvim_set_option_value("foldcolumn", "0",       { win = s.win })
                api.nvim_set_option_value("wrap", false,           { win = s.win })
            end
        end,
    })
end

function log.open()
    if not util.in_repo() then
        vim.notify("当前目录不是 git 仓库", vim.log.levels.WARN)
        return
    end
    local entries = util.log_entries(500)
    if #entries == 0 then
        vim.notify("没有发现提交记录", vim.log.levels.INFO)
        return
    end

    local win = api.nvim_get_current_win()
    local orig_buf = api.nvim_win_get_buf(win)
    local saved_opts = save_win_opts(win)

    local buf = scratch_buf("git-log://main")
    api.nvim_win_set_buf(win, buf)
    api.nvim_set_option_value("filetype", "gitlog", { buf = buf })
    api.nvim_set_option_value("number", false,         { win = win })
    api.nvim_set_option_value("relativenumber", false, { win = win })
    api.nvim_set_option_value("cursorline", true,      { win = win })
    api.nvim_set_option_value("signcolumn", "no",      { win = win })
    api.nvim_set_option_value("foldcolumn", "0",       { win = win })
    api.nvim_set_option_value("wrap", false,           { win = win })

    state = {
        win        = win,
        buf        = buf,
        orig_buf   = orig_buf,
        saved_opts = saved_opts,
        entries    = entries,
    }

    render(buf, entries)
    arm(state)
    api.nvim_win_set_cursor(win, { 1, 0 })
end

return log
