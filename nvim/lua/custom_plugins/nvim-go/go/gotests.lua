local gotests = {}
local utils   = require('custom_plugins.nvim-go.go.utils')
local fn      = vim.fn
local api     = vim.api

function gotests.AddTest(st, en)
    local bin_path = utils.CheckBinPath('gotests')
    if #bin_path < 1 then
        utils.Error("nvim-go: could not find 'gotests'. Run :GoInstallBinaries to fix it")
        return
    end

    local func_match = ''
    for lineno = st, en, 1 do
        local func_name = fn.matchstr(fn.getline(lineno), [[^func\s*\(([^)]\+)\)\=\s*\zs\w\+\ze(]])
        if #func_name > 0 then
            func_match = func_match .. '|' .. func_name
        end
    end
    if #func_match > 0 then
        func_match = string.sub(func_match, 2, #func_match)
    else
        utils.Error("nvim-go: No function selected!")
        return
    end

    local file = fn.expand('%')
    local cmd = {bin_path, "-w", "-only", func_match, file}
    if #_NVIM_GO_CFG_.gotests.template_dir > 0 then
        table.insert(cmd, '-template_dir')
        table.insert(cmd, fn.shellescape(_NVIM_GO_CFG_.gotests.template_dir))
    end
    local out, err = utils.Exec(cmd)
    if err ~= 0 then
        utils.Error("nvim-go: " .. out)
        return
    end
    utils.Info(out)
end

function gotests.AddAllTest()
    local bin_path = utils.CheckBinPath('gotests')
    if #bin_path < 1 then
        utils.Error("nvim-go: could not find 'gotests'. Run :GoInstallBinaries to fix it")
        return
    end

    local file = fn.expand('%')
    local cmd = {bin_path, "-w", "-all", file}
    if #_NVIM_GO_CFG_.gotests.template_dir > 0 then
        table.insert(cmd, '-template_dir')
        table.insert(cmd, fn.shellescape(_NVIM_GO_CFG_.gotests.template_dir))
    end
    local out, err = utils.Exec(cmd)
    if err ~= 0 then
        utils.Error("nvim-go: " .. out)
        return
    end
    utils.Info(out)
end

return gotests
