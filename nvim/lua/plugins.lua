local fn           = vim.fn
local cmd          = vim.cmd
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap

if fn.empty(fn.glob(install_path)) > 0 then
    print("[ installing packer... ]")
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

cmd [[packadd packer.nvim]]
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

    use {
        'neovim/nvim-lspconfig',
        opt = true,
        event = 'BufReadPre',
        config = function() require('plugins.nvim_lspconfig').conf() end
    }

    use {
        'williamboman/nvim-lsp-installer',
        opt = true,
        after = 'nvim-lspconfig'
    }

    use {
        'ray-x/lsp_signature.nvim',
        opt = true,
        after = 'nvim-lspconfig'
    }

    use {
        'hrsh7th/nvim-cmp',
        opt = true,
        event = 'InsertEnter',
        config = function() require('plugins.nvim_cmp').conf() end,
        requires = {
            {'saadparwaiz1/cmp_luasnip', after = 'LuaSnip'},
            {'hrsh7th/cmp-buffer', after = 'cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp', after = 'cmp-buffer'},
            {'hrsh7th/cmp-nvim-lua', after = 'cmp-nvim-lsp'},
            {'andersevenrud/compe-tmux', branch = 'cmp', after = 'cmp-nvim-lua'},
            {'hrsh7th/cmp-path', after = 'compe-tmux'},
            {'f3fora/cmp-spell', after = 'cmp-path'}
        }
    }

    use {
        'L3MON4D3/LuaSnip',
        after = 'nvim-cmp',
        config = function() require('plugins.luasnip').conf() end,
        requires = 'rafamadriz/friendly-snippets'
    }

    use {
        'folke/trouble.nvim',
        opt = true,
        cmd = {"Trouble", "TroubleToggle", "TroubleRefresh"},
        config = function() require('plugins.trouble').conf() end
    }

    use { 'scrooloose/nerdcommenter' }

    use {
        'voldikss/vim-floaterm',
        config = function() require('plugins.vim_floaterm').conf() end
    }

    use {
        'hoob3rt/lualine.nvim',
        config = function() require('plugins.lualine').conf() end
    }

    use {
        'akinsho/bufferline.nvim',
        event = 'BufRead',
        config = function() require('plugins.bufferline').conf() end
    }

    use {
        'simrat39/symbols-outline.nvim',
        opt = true,
        cmd = {'SymbolsOutline', 'SymbolsOulineOpen'},
        config = function() require('plugins.symbols_outline').conf() end
    }

    use {'nvim-lua/plenary.nvim' }

    use {
        'nvim-telescope/telescope.nvim',
        after = 'plenary.nvim',
        config = require('plugins.telescope').conf
    }

    use {
        'lewis6991/gitsigns.nvim',
        opt = true,
        event = {'BufRead', 'BufNewFile'},
        config = require('plugins.gitsigns').conf
    }

    use {
        'glepnir/dashboard-nvim',
        opt = true,
        event = "BufWinEnter",
        config = function() require('plugins.dashboard').conf() end
    }

    use {
        'lukas-reineke/format.nvim',
        opt = true,
        cmd = {"Format", "FormatWrite"},
        config = function() require('plugins.format').conf() end
    }

    use { 'tpope/vim-fugitive' }

    if packer_bootstrap then
        packer.sync()
    end
end)
