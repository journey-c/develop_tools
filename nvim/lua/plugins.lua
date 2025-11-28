local fn           = vim.fn
local cmd          = vim.cmd
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    print("[ installing packer... ]")
    Packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
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
            "ellisonleao/gruvbox.nvim",
            config = [[
            vim.cmd('colorscheme gruvbox')
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
                { "williamboman/mason-lspconfig.nvim" },
            },
            opts = { lsp = { auto_attach = true } },
            config = function() require('plugins.lspconfig').conf() end
        }

        use {
            "hedyhli/outline.nvim",
            config = function()
                -- Example mapping to toggle outline
                vim.keymap.set("n", "<leader>so", "<cmd>Outline<CR>",
                    { desc = "Toggle Outline" })

                require("outline").setup {
                    -- Your setup opts here (leave empty to use defaults)
                }
            end,
        }

        use {
            'ray-x/lsp_signature.nvim',
            after = 'nvim-lspconfig',
            config = function() require('plugins.lsp_signature').conf() end
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

        use { 'nvim-lua/plenary.nvim' }

        use {
            'nvim-telescope/telescope.nvim',
            after = 'plenary.nvim',
            config = require('plugins.telescope').conf
        }

        use {
            'lewis6991/gitsigns.nvim',
            config = function()
                require("gitsigns").setup {
                    signs = {
                        add          = { text = '▋' },
                        change       = { text = '▋' },
                        delete       = { text = '▋' },
                        topdelete    = { text = '▔' },
                        changedelete = { text = '▎' },
                        untracked    = { text = '┆' },
                    },
                }
            end
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

        if Packer_bootstrap then
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
