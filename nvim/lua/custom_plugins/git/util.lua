local util = {}
local fn   = vim.fn
local v    = vim.v

function util.run(args)
    local cmd = { "git" }
    for _, a in ipairs(args) do table.insert(cmd, a) end
    return fn.systemlist(cmd), v.shell_error
end

function util.root()
    local out, code = util.run({ "rev-parse", "--show-toplevel" })
    if code ~= 0 or #out == 0 then return nil end
    return out[1]
end

function util.in_repo()
    return util.root() ~= nil
end

-- 读 ref 下某文件的内容。ref 为空字符串/nil 表示工作区。
function util.file_content(ref, path)
    if ref == nil or ref == "" then
        local full = util.root() .. "/" .. path
        if fn.filereadable(full) == 0 then return {} end
        return fn.readfile(full)
    end
    local out, code = util.run({ "show", ref .. ":" .. path })
    if code ~= 0 then return {} end
    return out
end

local status_text = {
    A = "A", M = "M", D = "D", R = "R", C = "C", T = "T", U = "U",
}

-- 变更文件列表，附带每文件 +N / -N 行数。
-- base/target 任一为 "" / nil 时视为工作区。
function util.changed_files(base, target)
    local args = { "diff", "--name-status", "--no-renames" }
    if base and base ~= "" then table.insert(args, base) end
    if target and target ~= "" then table.insert(args, target) end
    local out, code = util.run(args)
    if code ~= 0 then return {} end

    local nargs = { "diff", "--numstat", "--no-renames" }
    if base and base ~= "" then table.insert(nargs, base) end
    if target and target ~= "" then table.insert(nargs, target) end
    local nout = util.run(nargs)
    local stats = {}
    for _, line in ipairs(nout) do
        local parts = fn.split(line, "\t")
        if #parts >= 3 then
            stats[parts[#parts]] = {
                added   = tonumber(parts[1]) or 0,
                removed = tonumber(parts[2]) or 0,
            }
        end
    end

    local files = {}
    for _, line in ipairs(out) do
        local parts = fn.split(line, "\t")
        if #parts >= 2 then
            local st = parts[1]:sub(1, 1)
            local path = parts[#parts]
            local stat = stats[path] or { added = 0, removed = 0 }
            files[#files + 1] = {
                status  = st,
                label   = status_text[st] or st,
                path    = path,
                added   = stat.added,
                removed = stat.removed,
            }
        end
    end
    return files
end

function util.log_entries(limit)
    limit = limit or 500
    local sep = "\31"
    local fmt = "%H" .. sep .. "%h" .. sep .. "%an" .. sep .. "%ar" .. sep .. "%s"
    local out, code = util.run({
        "log", "--pretty=format:" .. fmt, "-n", tostring(limit),
    })
    if code ~= 0 then return {} end
    local entries = {}
    for _, line in ipairs(out) do
        local f = fn.split(line, sep)
        if #f >= 5 then
            entries[#entries + 1] = {
                hash    = f[1], short = f[2], author = f[3],
                date    = f[4], subject = f[5],
            }
        end
    end
    return entries
end

return util
