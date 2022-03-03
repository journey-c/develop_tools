local utils = require "custom_plugins.nvim-go.go.utils"
local fillstruct = {}
local fn         = vim.fn
local o          = vim.o
local api        = vim.api

local function write_out(out)
    if #out == 0 or fn.type(out) ~= fn.type("") then
        return
    end
    local result = fn.json_decode(out)
    if fn.type(result) ~= 3 then -- List:       3 (v:t_list)
        utils.Error(string.format("malformed output from fillstruct: %s", out))
        return
    end
    for _, struct in pairs(result) do
        local code = fn.split(struct['code'], "\n")

        api.nvim_exec(struct['start']..'go',false)
        code[1] = string.sub(fn.getline('.'), 1, fn.col('.') - 1) .. " " .. code[1]
        api.nvim_exec(struct['end']..'go',false)
        code[#code] = code[#code]..string.sub(fn.getline('.'), fn.col('.') + 1, #fn.getline('.'))

        local indent = ""
        for _ = 1, fn.indent('.') / o.tabstop, 1 do
            indent = indent .. "\t"
        end
        for idx = 2, #code, 1 do
            code[idx] = indent .. code[idx]
        end
        api.nvim_exec('normal! ' .. struct['start'] .. 'gov' .. struct['end'] .. 'gox', false)
        fn.setline('.', code[1])
        fn.append('.', utils.SubTable(code, 2, #code))
    end
end

function fillstruct.FillStruct()
    local bin_path = utils.CheckBinPath('fillstruct')
    if #bin_path < 1 then
        utils.Error("nvim-go: could not find 'fillstruct'. Run :GoInstallBinaries to fix it")
        return
    end

    local out, err
    local cmd = {bin_path, '-file', fn.bufname(''), '-offset', utils.OffsetCursor(),  '-line', fn.line('.') }
    if o.modified == true then
        table.insert(cmd, '-modified')
        out, err = utils.Exec(cmd)
    else
        out, err = utils.Exec(cmd)
    end

    if err ~= 0 then
        utils.Error(out)
        return
    end
    write_out(out)
end

return fillstruct
