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

" 所在行高亮
" set cursorcolumn
set cursorline

" 使用鼠标
" set mouse=a

" 显示TAB键
" set list

" 自动保存
" set autowrite

" 设置n个字自动换行
" set textwidth=n

set foldmethod=syntax

set nofoldenable

" 设置leader键
let mapleader="\<space>"

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
    Plug 'vim-airline/vim-airline-themes'             " 主题
    Plug 'tpope/vim-fugitive'                         " 显示git分支
    Plug 'rhysd/vim-clang-format'                     " 格式化代码
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' } " 全局搜索
    Plug 'Valloric/YouCompleteMe'                     " 代码补全
    Plug 'fatih/vim-go'                               " vim-go
    Plug 'yianwillis/vimcdoc'                         " 中文文档
call plug#end()

" lsp {

" if executable('cquery')
    " au User lsp_setup call lsp#register_server({
        " \ 'name': 'cxx',
        " \ 'cmd': {server_info->['cquery']},
        " \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp'],
        " \ })
" endif

" }

" Colorscheme {

" 语法高亮
syntax  on

" 文件类型带上颜色
syntax  enable

" 文件类型探测 使用缩进文件
filetype plugin indent on

" 设置背景色
" set  background=dark

" 设置主题
colorscheme onedark

" Set the vertical split character to  a space (there is a single space after '\ ')
set fillchars+=vert:\ 
highlight VertSplit ctermbg=236 ctermfg=236

" }

" vim-go {

let g:go_fmt_command="goimports" " 格式化将默认的 gofmt 替换
let g:go_info_mode='gopls'
let g:go_def_mode='gopls'
let g:go_rename_command='gopls'  " 重命名变量
let g:go_referrers_mode='gopls'

let g:go_autodetect_gopath=1
let g:go_list_type="quickfix"
let g:go_version_warning=1
let g:go_highlight_types=1
let g:go_highlight_fields=1
let g:go_highlight_functions=1
let g:go_highlight_function_calls=1
let g:go_highlight_operators=1
let g:go_highlight_extra_types=1
let g:go_highlight_methods=1
let g:go_highlight_generate_tags=1
let g:godef_split=2

" push quickfix window always to the bottom
autocmd FileType qf wincmd J

" }

" YoucompleteMe {

let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'

" 展示错误诊断
let g:ycm_show_diagnostics_ui=0
" error符号
" let g:ycm_error_symbol=''
" warning符号
" let g:ycm_warning_symbol=''
" 最少按2个字符补全
let g:ycm_min_num_identifier_candidate_chars=2
" 显示错误原因
" let g:ycm_echo_current_diagnostic=1
" 补全预览
" let g:ycm_add_preview_to_completeopt=1
" let g:ycm_autoclose_preview_window_after_completion=1
" log等级
let g:ycm_server_log_level='info'

let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion='<c-z>'
set completeopt=menu,menuone

noremap <c-z> <NOP>

let g:ycm_semantic_triggers= {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }

highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black

" }

" LeaderF {

let g:Lf_ShortcutF='<C-P>'
let g:Lf_ShowDevIcons=0
nmap <C-f> :LeaderfFunction<CR>

" }

" taglist {

" nmap <F3> :TagbarToggle<CR>

" }

" NERDTree {

nmap <leader>n :NERDTreeToggle<CR>
" map <F4> :NERDTreeToggle<CR>

"设置NERDTree的宽度
let NERDTreeWinSize=30
let g:NERDTreeWinPos='right'

let g:NERDTreeShowIgnoredStatus=1

let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
"  *        

" }

" vim-airline {

if !exists('g:airline_symbols')
    let g:airline_symbols={}
endif

let airline#extensions#tabline#ignore_bufadd_pat =
            \ '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree'
let g:airline#extensions#tabline#keymap_ignored_filetypes =
            \ ['vimfiler', 'nerdtree']

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''


let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

let g:airline_theme='jellybeans'
let g:airline#extensions#tabline#formatter = 'unique_tail'

" tabline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
nmap <leader>q :bdelete<CR>
nmap <tab> :bn<CR>

" }

" nerdcommenter {

let g:NERDSpaceDelims=1 " 注释后加空格

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
autocmd FileType go,bash,python,java,html,javascipt,vim,sh,dot exec ":call SetCommonFileConfig()"

func SetCppFileConfig()
    " 设置tab为2个空格
    set tabstop=2

    " 设置缩进为2个空格
    set shiftwidth=2

    " 用space替代tab的输入
    set expandtab  

    " 谷歌C++代码风格检测
    let g:clang_format#command='clang-format'
    nmap <F7> :ClangFormat<cr>
    " 自动format
    " autocmd FileType c ClangFormatAutoEnable
    let g:clang_format#detect_style_file=1

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
