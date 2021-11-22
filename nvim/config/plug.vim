call plug#begin('~/.config/nvim/plugins')
    Plug 'morhetz/gruvbox'                                          " 主题
    Plug 'neoclide/coc.nvim', {'branch': 'release'}                 " LSP
    Plug 'vim-airline/vim-airline'                                  " 状态栏
    Plug 'Yggdroot/LeaderF', {'do': 'LeaderfInstallCExtension' }    " 全局搜索
    Plug 'tpope/vim-fugitive'                                       " commit信息
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }              " vim-go
    Plug 'kyazdani42/nvim-web-devicons' " for file icons
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'scrooloose/nerdcommenter'                                 " 注释
    Plug 'mhinz/vim-startify'                                       " 启动界面
    Plug 'rust-lang/rust.vim'                                       " rust
    Plug 'voldikss/vim-floaterm'                                    " popup 终端
    Plug 'nvim-lua/plenary.nvim'                                    " 搜索
    Plug 'nvim-telescope/telescope.nvim'
call plug#end()

" 设置python workspace root
autocmd FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyproject.toml', 'pyrightconfig.json']

exec 'source' '~/.config/nvim/config/plugins/coc-nvim.vim'
exec 'source' '~/.config/nvim/config/plugins/vim-go.vim'
exec 'source' '~/.config/nvim/config/plugins/nvim-tree.vim'
exec 'source' '~/.config/nvim/config/plugins/telescope.vim'
exec 'source' '~/.config/nvim/config/plugins/vim-floaterm.vim'
