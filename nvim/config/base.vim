" 设置行号
set number

" 搜索不区分大小写
set ignorecase

" 编码
set encoding=utf-8

" 行高亮
set cursorline

" 历史命令条数
set history=1024

" 恢复光标位置
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" 不生成备份文件
set nobackup

" 不创建临时交换文件
set noswapfile
    
" 剪贴板
set clipboard=unnamed

" 设置tab为4个空格
set tabstop=4

" 设置缩进为4个空格
set shiftwidth=4

" 用space替代tab的输入
set expandtab

set termguicolors

" 设置leader键
let mapleader="\<space>"

" 文件头
command! -nargs=0 SetTitle :call SetTitle()
command! -nargs=0 SetCodeForces :call SetCodeForces()
func SetTitle()
    call setline(1, "/**")
    call setline(2, " *    author:  journey-c")
    call setline(3, " *    created: ".strftime("%m.%d.%Y %H:%M:%S"))
    call setline(4, " **/")
endfunc

func SetCodeForces()
    call setline(1, "/**")
    call setline(2, " *    author:  journey-c")
    call setline(3, " *    created: ".strftime("%m.%d.%Y %H:%M:%S"))
    call setline(4, " **/")
    call setline(5, "#include <bits/stdc++.h>")
    call setline(6, "")
    call setline(7, "using namespace std;")
    call setline(8, "")
    call setline(9, "int main() {")
    call setline(10, "    ios::sync_with_stdio(false);")
    call setline(11, "    cin.tie(0);")
    call setline(12, "    return 0;")
    call setline(13, "}")
endfunc

