local fn           = vim.fn
local cmd          = vim.cmd
local api          = vim.api
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    print("[ installing packer... ]")
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local packer = require('packer')

packer.init({
    compile_path = fn.stdpath("data") .. "/site/plugin/packer_compiled.lua",
})

return packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    
    use { 
        'morhetz/gruvbox',
	    config = function() require('modules.ui').colorscheme() end
    }
    
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config   = function() 
            require('nvim-tree').setup {
                filters = {
                    dotfiles = true,
                },
            }
            require('modules.ui').nvim_tree()
        end
    }
    
    use { 
        'neovim/nvim-lspconfig',
        config = function() require('modules.editor').nvim_lspconfig() end
    }

    use {
        'fatih/vim-go',
        config = function() require('modules.editor').vim_go() end
    }

--   use {
--       'hrsh7th/nvim-cmp'
--   }
--   use {
--       'hrsh7th/cmp-nvim-lsp'
--   }
--   use {
--       'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
--   }
--   use {
--       'L3MON4D3/LuaSnip' -- Snippets plugin
--   }

    if packer_bootstrap then
        packer.sync()
    end
end)
