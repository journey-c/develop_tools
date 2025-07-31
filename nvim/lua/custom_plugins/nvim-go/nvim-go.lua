local utils   = require "custom_plugins.nvim-go.go.utils"
local nvim_go = {}
local api     = vim.api

_NVIM_GO_CFG_ = {
    goaddtags = {
        transform = false,
        skip_unexported = false,
    },
}

function nvim_go.setup(cfg)
    if utils.IsWin() ~= 0 then
        utils.Error("sorry, windows platform is not supported at the moment")
        return
    end
    if cfg == nil then
        cfg = {}
    end
    _NVIM_GO_CFG_ = vim.tbl_extend("force", _NVIM_GO_CFG_, cfg)

    api.nvim_command [[ command! -nargs=* GoInstallBinaries lua require('custom_plugins.nvim-go.go.install').install_all(0) ]]
    api.nvim_command [[ command! -nargs=* GoUpdateBinaries lua require('custom_plugins.nvim-go.go.install').install_all(1) ]]
    api.nvim_command [[ command! -nargs=? GoPath lua require('custom_plugins.nvim-go.go.gopath').GoPath({<f-args>}) ]]
    api.nvim_command [[ command! -nargs=* -range GoAddTags lua require('custom_plugins.nvim-go.go.gomodifytags').add(<line1>, <line2>, <count>, {<f-args>}) ]]
    api.nvim_command [[ command! -nargs=* -range GoRemoveTags lua require('custom_plugins.nvim-go.go.gomodifytags').remove(<line1>, <line2>, <count>, {<f-args>}) ]]
end

return nvim_go
