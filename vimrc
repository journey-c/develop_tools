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

" }

" Plugin Management {

filetype off
call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree'            " 目录树
    Plug 'scrooloose/nerdcommenter'       " 注释
    Plug 'vim-airline/vim-airline'        " Vim状态栏插件，包括显示行号，列号，文件类型，文件名，以及Git状态
    Plug 'rhysd/vim-clang-format'         " 格式化代码
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
" colorscheme  tomorrow-night

" }

" TagList {

map <F3> :TlistToggle<CR>
let Tlist_Ctags_Cmd="/usr/local/bin/ctags"
let Tlist_Show_One_File=1           " 只显示当前文件的tags
let Tlist_WinWidth=25               " 设置taglist宽度
let Tlist_Exit_OnlyWindow=1         " tagList窗口是最后一个窗口，则退出Vim
let Tlist_Use_Right_Window=1        " 在Vim窗口右侧显示taglist窗口

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
