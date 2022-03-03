local utils        = require "custom_plugins.nvim-go.go.utils"
local fn           = vim.fn
local o            = vim.o
local gomodifytags = {}

local transform = _NVIM_GO_CFG_.goaddtags.transform
local skip_unexported = _NVIM_GO_CFG_.goaddtags.skip_unexported

local function write_out(out)
    if #out == 0 or fn.type(out) ~= fn.type("") then
        return
    end
    local result = fn.json_decode(out)
    if fn.type(result) ~= 4 then -- Dictionary: 4 (v:t_dict)
        utils.Error(string.format("malformed output from gomodifytags: %s", out))
        return
    end
    local lines = result['lines']
    local start_lines = result['start']
    local end_lines = result['end']

    local idx = 1
    for line = start_lines, end_lines, 1 do
        fn.setline(line, lines[idx])
        idx = idx + 1
    end
end

local function run(st, en, offset, mode, fname, args)
    local bin_path = utils.CheckBinPath('gomodifytags')
    if #bin_path < 1 then
        utils.Error("nvim-go: could not find 'gomodifytags'. Run :GoInstallBinaries to fix it")
        return
    end
    local cmd = { bin_path, "-format", "json", "-file", fname }
    if transform then
        table.insert(cmd, "-transform")
        table.insert(cmd, transform)
    end
    if skip_unexported then
        table.insert(cmd, "-skip-unexported")
    end
    if o.modified == true then
        table.insert(cmd, "-modified")
    end
    if offset ~= 0 then
        table.insert(cmd, "-offset")
        table.insert(cmd, offset)
    else
        table.insert(cmd, "-line")
        table.insert(cmd, st .. "," .. en)
    end
    if mode == "add" then
        local tags = {}
        local options = {}
        if #args > 0 then
            for _, arg in pairs(args) do
                local splitted = utils.StringSplit(arg, ',')
                if #splitted == 1 then
                    table.insert(tags, splitted[1])
                end
                if #splitted == 2 then
                    table.insert(tags, splitted[1])
                    table.insert(options, splitted[1].."="..splitted[2])
                end
            end
        end
        if #tags == 0 then
            tags = {"json"}
        end
        table.insert(cmd, "-add-tags")
        table.insert(cmd, fn.join(tags, ","))
        if #options ~= 0 then
            table.insert(cmd, "-add-options")
            table.insert(cmd, fn.join(options, ","))
        end
    elseif mode == "remove" then
        if #args == 0 then
           table.insert(cmd, "-clear-tags")
        else
            local tags = {}
            local options = {}
            for _, arg in pairs(args) do
                local splitted = utils.StringSplit(arg, ',')
                if #splitted == 1 then
                    table.insert(tags, splitted[1])
                end
                if #splitted == 2 then
                    table.insert(tags, splitted[1])
                    table.insert(options, splitted[1].."="..splitted[2])
                end
            end
            if #tags ~= 0 then
                table.insert(cmd, "-remove-tags")
                table.insert(cmd, fn.join(tags, ","))
            end
            if #options ~= 0 then
                table.insert(cmd, "-remove-options")
                table.insert(cmd, fn.join(options, ","))
            end
        end
    else
        utils.Error("nvim-go: unknown mode "..mode)
        return
    end
    local out, err = utils.Exec(cmd)
    if err ~= 0 then
       utils.Error(out)
       return
    end
    write_out(out)
end

function gomodifytags.add(st, en ,cnt, args)
    local fname = fn.fnamemodify(fn.expand("%"), ':p:gs?\\?/?')
    local offset = 0
    if cnt == -1 then
       offset = utils.OffsetCursor()
    end
    run(st, en, offset, "add", fname, args)
end

function gomodifytags.remove(st, en, cnt, args)
    local fname = fn.fnamemodify(fn.expand("%"), ':p:gs?\\?/?')
    local offset = 0
    if cnt == -1 then
       offset = utils.OffsetCursor()
    end
    run(st, en, offset, "remove", fname, args)
end

return gomodifytags
