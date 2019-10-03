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

" Beautify-Powerline {

set rtp+=/home/lvcheng1/.local/lib/python2.7/site-packages/powerline/bindings/vim/
set laststatus=2
 
" }

" Plugin Management {

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'Valloric/YouCompleteMe'         " 自动补全 
    Plugin 'scrooloose/nerdtree'            " 目录树
    Plugin 'scrooloose/nerdcommenter'       " 注释
    Plugin 'scrooloose/syntastic'           " code detection
    Plugin 'rhysd/vim-clang-format'         " 格式化代码
    Plugin 'ludovicchabant/vim-gutentags'   " auto ctags
call vundle#end()

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

" YCM {

" 寻找全局配置文件
let g:ycm_global_ycm_extra_conf = '/home/${USER}/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_seed_identifiers_with_syntax = 1          " 语法关键字补全
set completeopt-=preview                            " 关闭预览
let g:ycm_enable_diagnostic_signs = 0               " 关闭错误检测
let g:ycm_enable_diagnostic_highlighting = 0        " 关闭错误检测高亮

" }

" TagList {

map <F3> :TlistToggle<CR>
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
