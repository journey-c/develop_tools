local fn           = vim.fn
local cmd          = vim.cmd
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    print("[ installing packer... ]")
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
end

cmd [[packadd packer.nvim]]

require('packer').init({
    compile_path = fn.stdpath("data") .. "/site/plugin/packer_compiled.lua",
})

return require('packer').startup({
    function(use)
        use 'wbthomason/packer.nvim'

        use {
            'mhartington/oceanic-next',
            config = [[
            vim.cmd('colorscheme OceanicNext')
            vim.cmd('hi VertSplit ctermfg=235 guifg=#212026 cterm=None gui=None guibg=NONE ctermbg=NONE')
            ]]
        }

        use {
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons',
            config   = function()
                require('plugins.nvim_tree').conf()
            end
        }

        use {
            "neovim/nvim-lspconfig",
            event = 'BufReadPre',
            requires = {
                { "williamboman/mason.nvim" },
                { "williamboman/mason-lspconfig.nvim" }
            },
            dependencies = {
                {
                    "SmiteshP/nvim-navbuddy",
                    dependencies = {
                        "SmiteshP/nvim-navic",
                        "MunifTanjim/nui.nvim"
                    },
                    opts = { lsp = { auto_attach = true } }
                }
            },
            config = function() require('plugins.lspconfig').conf() end
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
                { 'saadparwaiz1/cmp_luasnip', after = 'LuaSnip' },
                { 'hrsh7th/cmp-buffer',       after = 'cmp_luasnip' },
                { 'hrsh7th/cmp-nvim-lsp',     after = 'cmp-buffer' },
                { 'hrsh7th/cmp-nvim-lua',     after = 'cmp-nvim-lsp' },
                { 'hrsh7th/cmp-path',         after = 'cmp-nvim-lua' },
                { 'f3fora/cmp-spell',         after = 'cmp-path' }
            }
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

        use {
            'linrongbin16/lsp-progress.nvim',
            config = function() require('plugins.lualine-lsp-progress').conf() end,
        }

        use {
            'hoob3rt/lualine.nvim',
            event = { 'VimEnter' },
            dependencies = {
                'nvim-tree/nvim-web-devicons',
                'linrongbin16/lsp-progress.nvim',
            },
            config = function() require('plugins.lualine').conf() end,
        }

        use { 'nvim-lua/plenary.nvim' }

        use {
            'nvim-telescope/telescope.nvim',
            after = 'plenary.nvim',
            config = require('plugins.telescope').conf
        }

        use {
            'lewis6991/gitsigns.nvim',
            opt = true,
            event = { 'BufRead', 'BufNewFile' },
            config = require('plugins.gitsigns').conf
        }

        use { 'tpope/vim-fugitive' }

        use {
            "folke/which-key.nvim",
            config = function()
                require("which-key").setup {}
            end
        }

        use {
            "onsails/diaglist.nvim",
            config = function()
                require("diaglist").init({
                    debug = false,
                    debounce_ms = 150,
                })
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
    }
})
