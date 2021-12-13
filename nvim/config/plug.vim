call plug#begin(stdpath('config').'/plugins')
    " editer
    Plug 'neoclide/coc.nvim', {'branch': 'release'}                 " LSP
    Plug 'tpope/vim-fugitive'                                       " commit信息
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }              " vim-go
    Plug 'scrooloose/nerdcommenter'                                 " 注释
    Plug 'rust-lang/rust.vim'                                       " rust
    Plug 'voldikss/vim-floaterm'                                    " popup 终端

    " ui
    Plug 'morhetz/gruvbox'                                          " 主题
    "Plug 'arcticicestudio/nord-vim'                                 " 主题
    Plug 'nvim-lualine/lualine.nvim'                                " 底部statusline
    Plug 'akinsho/bufferline.nvim'                                  " 顶部bufferline
    Plug 'kyazdani42/nvim-web-devicons'                             " 图标
    Plug 'simrat39/symbols-outline.nvim'                            " 函数树
    Plug 'kyazdani42/nvim-tree.lua'                                 " 文件树
    Plug 'nvim-lua/plenary.nvim'                                    " 搜索
    Plug 'nvim-telescope/telescope.nvim'                            " 模糊搜索
    Plug 'dstein64/vim-startuptime'                                 " 启动时间
    Plug 'glepnir/dashboard-nvim'                                   " 面板
    Plug 'lewis6991/gitsigns.nvim'
call plug#end()

" 设置python workspace root
autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']

if g:bootstrap == 1
    PlugInstall
endif

colorscheme gruvbox

exec 'source' stdpath('config').'/config/plugins/coc-nvim.vim'
exec 'source' stdpath('config').'/config/plugins/vim-go.vim'
exec 'source' stdpath('config').'/config/plugins/nvim-tree.vim'
exec 'source' stdpath('config').'/config/plugins/telescope.vim'
exec 'source' stdpath('config').'/config/plugins/vim-floaterm.vim'
exec 'source' stdpath('config').'/config/plugins/lualine.vim'
exec 'source' stdpath('config').'/config/plugins/bufferline.vim'
exec 'source' stdpath('config').'/config/plugins/dashboard.vim'
exec 'source' stdpath('config').'/config/plugins/symbols-outline.vim'
exec 'source' stdpath('config').'/config/plugins/gitsigns.vim'
