local fn               = vim.fn
local cmd              = vim.cmd
local install_path     = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    print("[ installing packer... ]")
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

cmd [[packadd packer.nvim]]

require('packer').init({
    compile_path = fn.stdpath("data") .. "/site/plugin/packer_compiled.lua",
})

return require('packer').startup({function(use)
    use 'wbthomason/packer.nvim'

    use {
        'morhetz/gruvbox',
        config = [[
            vim.cmd('colorscheme gruvbox')
            vim.cmd('hi FloatermBorder guibg=synIDattr(hlID("Normal"), "bg")')
            ]]
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
        'L3MON4D3/LuaSnip',
        config = function() require('plugins.luasnip').conf() end,
        requires = 'rafamadriz/friendly-snippets'
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
            {'hrsh7th/cmp-path', after = 'cmp-nvim-lua'},
            {'f3fora/cmp-spell', after = 'cmp-path'}
        }
    }

    use {
        'folke/trouble.nvim',
        opt = true,
        cmd = {"Trouble", "TroubleToggle", "TroubleRefresh"},
        config = function() require('plugins.trouble').conf() end
    }

    use {
        'terrortylor/nvim-comment',
        opt = false,
        config = function()
            require('nvim_comment').setup({
                line_mapping = "<leader>cl",
                operator_mapping = "<leader>c",
            })
        end
    }


    use { 'voldikss/vim-floaterm' }

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
        event = "BufWinEnter"
    }

    use { 'tpope/vim-fugitive' }
    use {
        'RishabhRD/nvim-lsputils',
        requires = {
            { 'RishabhRD/popfix' }
        },
        config = function() require('plugins.nvim_lsputils').conf() end
    }

    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {}
        end
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})
