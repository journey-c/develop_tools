local g      = vim.g
local fn     = vim.fn
local opt    = vim.opt
local cmd    = vim.cmd
local exec   = vim.api.nvim_exec

local global = {}

function global:load_variables()
    self.vim_path = fn.stdpath("config")
    self.modules_dir = self.vim_path .. "/modules"
    self.data_dir = string.format("%s/site/", fn.stdpath("data"))
end

global:load_variables()

return global
