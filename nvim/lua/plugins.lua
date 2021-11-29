local fn = vim.fn
local cmd = vim.cmd

local load_plugins = function (data_dir)
    local install_path = data_dir .. '/site/pack/packer/start/packer.nvim'
    local packer_bootstrap

    if fn.empty(fn.glob(install_path)) > 0 then
        print("[ installing packer... ]")
        packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    end

    local packer = require('packer')
    packer.init({
        compile_path = data_dir .. "/site/plugin/packer_compiled.lua",
    })
    return packer.startup(function(use)
        -- packer
        use 'wbthomason/packer.nvim'

        -- editer
        use {
            'neoclide/coc.nvim',
            branch = 'release',
            config = function()
                require('config').coc_nvim()
            end
        }                                                     -- LSP
        use 'tpope/vim-fugitive'                              -- commit信息
        use {
            'fatih/vim-go',
            config = function() cmd [[GoUpdateBinaries ]] end
        }                                                     -- vim-go
        use 'scrooloose/nerdcommenter'                        -- 注释
        use 'rust-lang/rust.vim'                              -- rust
        use {
            'voldikss/vim-floaterm',
            config = function()
                require('config').vim_floaterm()
            end
        }                                                     -- popup 终端

        -- ui
        use 'morhetz/gruvbox'                                 -- 主题
        use {
            'nvim-lualine/lualine.nvim',
            config = function()
                require('config').lualine()
            end
        }                                                     -- 底部statusline
        use {
            'akinsho/bufferline.nvim',
            config = function()
                require('config').bufferline()
            end
        }                                                     -- 顶部bufferline
        use 'kyazdani42/nvim-web-devicons'                    -- 图标
        use {
            'simrat39/symbols-outline.nvim',
            config = function()
                require('config').symbols_outline()
            end
        }                                                     -- 函数树
        use {
            'kyazdani42/nvim-tree.lua',
            config = function()
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
                require('config').nvim_tree()
            end
        }                                                     --  文件树
        use 'nvim-lua/plenary.nvim'                           --  搜索
        use {
            'nvim-telescope/telescope.nvim',
            config = function()
                require('config').telescope()
            end
        }                                                     --  模糊搜索
        use 'dstein64/vim-startuptime'                        --  启动时间
        use {
            'glepnir/dashboard-nvim',
            config = function()
                require('config').dashboard_nvim()
            end                                               --  面板
        }

        if packer_bootstrap then
            packer.sync()
        end
    end)
end
