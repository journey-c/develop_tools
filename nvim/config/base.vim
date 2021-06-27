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
let g:clipboard = {
  \   'name': 'xclip-xfce4-clipman',
  \   'copy': {
  \      '+': 'xclip -selection clipboard',
  \      '*': 'xclip -selection clipboard',
  \    },
  \   'paste': {
  \      '+': 'xclip -selection clipboard -o',
  \      '*': 'xclip -selection clipboard -o',
  \   },
  \   'cache_enabled': 1,
  \ }


" 设置tab为4个空格
set tabstop=4

" 设置缩进为4个空格
set shiftwidth=4

" 用space替代tab的输入
set expandtab
