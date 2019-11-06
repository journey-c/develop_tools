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

" 开启24bit的颜色
set termguicolors

" 显示括号匹配
" set showmatch

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

" }

" Plugin Management {

filetype off
call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe'         " 自动补全 
Plug 'scrooloose/nerdtree'            " 目录树
Plug 'scrooloose/nerdcommenter'       " 注释
Plug 'scrooloose/syntastic'           " code detection
Plug 'rhysd/vim-clang-format'         " 格式化代码
Plug 'ludovicchabant/vim-gutentags'   " auto ctags
Plug 'junegunn/vim-easy-align'        " 可以快速对齐的插件
Plug 'jistr/vim-nerdtree-tabs'        " 可以使 nerdtree Tab 标签的名称更友好些
Plug 'Xuyuanp/nerdtree-git-plugin'    " 可以在导航目录中看到 git 版本信息

" Vim 中文文档
Plug 'yianwillis/vimcdoc'

" 查看当前代码文件中的变量和函数列表的插件，
" 可以切换和跳转到代码中对应的变量和函数的位置
" 大纲式导航, Go 需要 https://github.com/jstemmer/gotags 支持
Plug 'majutsushi/tagbar'

" 可以在文档中显示 git 信息
Plug 'airblade/vim-gitgutter'

" 下面两个插件要配合使用，可以自动生成代码块
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" 配色方案
Plug 'KeitaNakamura/neodark.vim'
Plug 'crusoexia/vim-monokai'
Plug 'acarapetis/vim-colors-github'
Plug 'rakr/vim-one'

" go 主要插件
Plug 'fatih/vim-go', { 'tag': '*' }
" go 中的代码追踪，输入 gd 就可以自动跳转
Plug 'dgryski/vim-godef'

" Vim状态栏插件，包括显示行号，列号，文件类型，文件名，以及Git状态
Plug 'vim-airline/vim-airline'

call plug#end()

" }

" Colorscheme {

" 语法高亮
syntax  on

" 文件类型带上颜色
syntax  enable

" 突出显示当前行
set cursorline 

" 文件类型探测 使用缩进文件
filetype plugin indent on

" 设置背景色
set  background=dark

" 设置主题
colorscheme one

" }

" YCM {

" 寻找全局配置文件
let g:ycm_global_ycm_extra_conf = '/home/${USER}/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_seed_identifiers_with_syntax = 1          " 语法关键字补全
set completeopt-=preview                            " 关闭预览
let g:ycm_enable_diagnostic_signs = 0               " 关闭错误检测
let g:ycm_enable_diagnostic_highlighting = 0        " 关闭错误检测高亮

" }

" vim-go {
"
let g:go_fmt_command = "goimports" " 格式化将默认的 gofmt 替换
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

" }

" TagList {

" map <F3> :TlistToggle<CR>
" let Tlist_Show_One_File=1           " 只显示当前文件的tags
" let Tlist_WinWidth=25               " 设置taglist宽度
" let Tlist_Exit_OnlyWindow=1         " tagList窗口是最后一个窗口，则退出Vim
" let Tlist_Use_Right_Window=1        " 在Vim窗口右侧显示taglist窗口

" majutsushi/tagbar {
"
map <F3> :TagbarToggle<CR>

let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

let g:tagbar_sort = 0 "设置标签不排序，默认排序

" }

" NERDTree {

map <F4> :NERDTreeToggle<CR>

" let NERDTreeShowLineNumbers=1
" 打开文件时是否显示目录
let NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=0
" 设置宽度
let NERDTreeWinSize=25
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 打开 vim 文件及显示书签列表
let NERDTreeShowBookmarks=2

" 在终端启动vim时，共享NERDTree
" let g:nerdtree_tabs_open_on_console_startup=1

" }

" nerdtree-git-plugin {

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

let g:NERDTreeShowIgnoredStatus = 1

" }

" nerdcommenter {

" 注释的时候自动加个空格, 强迫症必配
let mapleader=","
let g:NERDSpaceDelims=1
map <C-m> ,c<space>

" }

" Compile {

" C++

map <F6> :call CR()<CR>
func! CR()
    exec "w"
    exec "!g++ % -std=c++11 -o %<"
    exec "! ./%<"
endfunc

" Golang
autocmd FileType go map <F8> :GoRun %<CR>

" }

" Code Style {

autocmd FileType cpp,c exec ":call SetCppFileConfig()" 
autocmd FileType go,bash,python,java,html,javascipt,vim,sh,txt,json exec ":call SetCommonFileConfig()"

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
    set completeopt=longest,menu

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
