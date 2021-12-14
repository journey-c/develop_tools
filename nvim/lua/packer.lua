local fn           = vim.fn
local cmd          = vim.cmd
local api          = vim.api
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    print("[ installing packer... ]")
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    api.nvim_command("packadd packer.nvim")
end

local packer = require('packer')

packer.init({
    compile_path = fn.stdpath("data") .. "/site/plugin/packer_compiled.lua",
})

return packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    
    use { 
        'morhetz/gruvbox',
	    config = function() require('plugins.theme').conf() end
    }
    
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config   = function() 
            require('nvim-tree').setup {
                filters = {
                    dotfiles = true,
                },
                git = {
                    enable = false,
                    ignore = true,
                    timeout = 500,
                },
            }
            require('plugins.nvim_tree').conf()
        end
    }
    
-- use { 
--     'neovim/nvim-lspconfig',
--     requires = {
--         { 'hrsh7th/nvim-cmp'         },
--         { 'hrsh7th/cmp-nvim-lsp'     },
--         { 'saadparwaiz1/cmp_luasnip' },
--         { 'L3MON4D3/LuaSnip'         },
--         { 'hrsh7th/cmp-vsnip'        },
--         { 'hrsh7th/vim-vsnip'        },
--     },
--     config = function() require('modules.editor').nvim_lspconfig() end
-- }

    if packer_bootstrap then
        packer.sync()
    end
end)
