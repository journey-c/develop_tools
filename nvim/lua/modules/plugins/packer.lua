local cmd  = vim.cmd
local api  = vim.api
local loop = vim.loop

local global  = require('core.global')

local packer_dir = global.data_dir .. "pack/packer/start/packer.nvim"
local state = loop.fs_stat(packer_dir)
if not state then
    local cmd = "!git clone https://github.com/wbthomason/packer.nvim " .. packer_dir
    api.nvim_command(cmd)
end

cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use { 'morhetz/gruvbox' }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end
  }
end)
