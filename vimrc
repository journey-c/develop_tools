" Common config {

" 设置行号
set number

" 不生成备份文件
set nobackup 

" 不创建临时交换文件
set noswapfile     

" 右下角显示光标位置
set ruler

" 查找不区分大小写
set ignorecase

" 查找高亮
set hlsearch

" 启用256色
set t_Co=256

" 不兼容VI
set nocompatible

" 设置保存历史(命令, 查找模式的历史
set history=1024

" 右下角显示未完成的命令 
set showcmd

" 再输入部分查找模式时显示相应的匹配点 
set incsearch

" 使用UTF-8编码
set encoding=utf-8

" 使用鼠标
" set mouse=a

" 显示TAB键
" set list

" 自动保存
" set autowrite

" 设置n个字自动换行
" set textwidth=n

" 恢复光标位置
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" }

" Plugin Management {

filetype off
call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree'                        " 目录树
    Plug 'scrooloose/nerdcommenter'                   " 注释
    Plug 'vim-airline/vim-airline'                    " Vim状态栏插件，包括显示行号，列号，文件类型，文件名，以及Git状态
    Plug 'rhysd/vim-clang-format'                     " 格式化代码
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' } " 全局搜索
    Plug 'Valloric/YouCompleteMe'                     " 代码补全
    Plug 'fatih/vim-go'                               " vim-go
    Plug 'yianwillis/vimcdoc'                         " 中文文档
call plug#end()

" Colorscheme {

" 语法高亮
syntax  on

" 文件类型带上颜色
syntax  enable

" 文件类型探测 使用缩进文件
filetype plugin indent on

" 设置背景色
set  background=dark

" 设置主题
colorscheme onedark

" }

" vim-go {

let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
let g:go_def_mode = 'gopls'
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1
let g:godef_split=2

" push quickfix window always to the bottom
autocmd FileType qf wincmd J

" }

" YoucompleteMe {

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }

highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black

" }

" LeaderF {

let g:Lf_ShortcutF = '<C-P>'

" }
" NERDTree {

map <F4> :NERDTreeToggle<CR>

"设置NERDTree的宽度
let NERDTreeWinSize=25
" }

" nerdcommenter {

" 注释的时候自动加个空格, 强迫症必配
let mapleader=","
let g:NERDSpaceDelims=1
map <C-m> ,c<space>

" }

" Compile {

map <F6> :call CR()<CR>
func! CR()
    exec "w"
    exec "!g++ % -std=c++11 -o %<"
    exec "! ./%<"
endfunc

" }

" Code Style {

autocmd FileType cpp,c,yaml exec ":call SetCppFileConfig()" 
autocmd FileType go,bash,python,java,html,javascipt,vim,sh exec ":call SetCommonFileConfig()"

func SetCppFileConfig()
    " 设置tab为2个空格
    set tabstop=2

    " 设置缩进为2个空格
    set shiftwidth=2

    " 用space替代tab的输入
    set expandtab  

    " 谷歌C++代码风格检测
    let g:clang_format#command = 'clang-format'
    nmap <F7> :ClangFormat<cr>
    autocmd FileType c ClangFormatAutoEnable
    let g:clang_format#detect_style_file = 1

    " ctags补全结构体
    " set completeopt=longest,menu

endfunc

func SetCommonFileConfig()
    " 设置tab为4个空格
    set tabstop=4

    " 设置缩进为4个空格
    set shiftwidth=4

    " 用space替代tab的输入
    set expandtab  

endfunc

" }


nmap <F8> :!dot % -T png -Gsize=4,6\! -Gdpi=350 -o %<.png && open %<.png <CR>
