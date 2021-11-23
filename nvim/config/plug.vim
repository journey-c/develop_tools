call plug#begin(stdpath('config') . '/plugins')
    Plug 'morhetz/gruvbox'                                          " 主题
    Plug 'neoclide/coc.nvim', {'branch': 'release'}                 " LSP
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'akinsho/bufferline.nvim'
    Plug 'Yggdroot/LeaderF', {'do': 'LeaderfInstallCExtension' }    " 全局搜索
    Plug 'tpope/vim-fugitive'                                       " commit信息
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }              " vim-go
    Plug 'kyazdani42/nvim-web-devicons' " for file icons
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'scrooloose/nerdcommenter'                                 " 注释
    Plug 'rust-lang/rust.vim'                                       " rust
    Plug 'voldikss/vim-floaterm'                                    " popup 终端
    Plug 'nvim-lua/plenary.nvim'                                    " 搜索
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'dstein64/vim-startuptime'
    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'SmiteshP/nvim-gps'
call plug#end()

" 设置python workspace root
autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']

if g:bootstrap == 1
    PlugInstall
endif

exec 'source' stdpath('config') . '/config/plugins/coc-nvim.vim'
exec 'source' stdpath('config') . '/config/plugins/vim-go.vim'
exec 'source' stdpath('config') . '/config/plugins/nvim-tree.vim'
exec 'source' stdpath('config') . '/config/plugins/telescope.vim'
exec 'source' stdpath('config') . '/config/plugins/vim-floaterm.vim'
exec 'source' stdpath('config') . '/config/plugins/lualine.vim'
exec 'source' stdpath('config') . '/config/plugins/bufferline.vim'
