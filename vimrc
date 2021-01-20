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

" 退格键
set backspace=2

" 相对行号
" set relativenumber

" 使用鼠标
" set mouse=a

" 显示TAB键
" set list

" 自动保存
" set autowrite

" 设置n个字自动换行
" set textwidth=n

" 去掉警报
set vb

set foldmethod=syntax

set nofoldenable

" 设置leader键
let mapleader="\<space>"

" 恢复光标位置
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" <space> + t 下方打开终端
nmap <leader>t :below term<CR>
set termwinsize=6x0

" }

" Plugin Management {

filetype off
call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdcommenter'                     " 注释
    Plug 'vim-airline/vim-airline'                      " Vim状态栏插件，包括显示行号，列号，文件类型，文件名，以及Git状态
    Plug 'tpope/vim-fugitive'                           " 显示git分支
    Plug 'Yggdroot/LeaderF', {'do': './install.sh' }    " 全局搜索
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }  " vim-go
    Plug 'yianwillis/vimcdoc'                           " 中文文档
    Plug 'neoclide/coc.nvim', {'branch': 'release'}     " LSP
    Plug 'mhinz/vim-startify'                           " 启动界面
    Plug 'rhysd/vim-clang-format'                       " clang-format
call plug#end()

" }

" coc-vim {

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" }

" Colorscheme {

" 语法高亮
syntax  on

" 文件类型带上颜色
syntax  enable

" 文件类型探测 使用缩进文件
filetype plugin indent on

" 设置主题
colorscheme onedark
set termguicolors

" 每行前边不显示~
hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg

" Set the vertical split character to  a space (there is a single space after '\ ')
" set fillchars+=vert:\│
" set fillchars+=vert:┊
" highlight VertSplit ctermbg=236 ctermfg=236

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
let g:go_highlight_function_parameters = 1
let g:go_highlight_build_constraints = 1

let g:godef_split=2

" push quickfix window always to the bottom
autocmd FileType qf wincmd J

" }

" LeaderF {

let g:Lf_ShortcutF='<C-P>'
" let g:Lf_ShowDevIcons=0

" }

" vim-airline {

if !exists('g:airline_symbols')
    let g:airline_symbols={}
endif

let airline#extensions#tabline#ignore_bufadd_pat =
            \ '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree'
let g:airline#extensions#tabline#keymap_ignored_filetypes =
            \ ['vimfiler']

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

" let g:airline#extensions#tabline#enabled = 1

let g:airline_theme='onedark'
let g:airline#extensions#tabline#formatter = 'unique_tail'
" }

" nerdcommenter {

let g:NERDSpaceDelims=1 " 注释后加空格

" }

" Compile {

command! -nargs=0 CodeForces :call RunCXXCodeForces()
command! -nargs=0 CxxRun :call RunCPP()
command! -nargs=0 ShellRun :call RunSH()
command! -nargs=0 DotBuild :call BuildDot()

" shell
func! RunSH()
    exec "w"
    exec "!sh ./%"
endfunc

" CXX
func! RunCPP()
    exec "w"
    exec "!g++ % -std=c++17 -o %< && ./%< && rm -f %<>"
endfunc

" codeforces
func! RunCXXCodeForces()
    exec "w"
    exec "!g++ % -std=c++17 -D JOURNEY -o %< && ./%< <in && rm -f %<"
endfunc

" dot
func! BuildDot()
    exec "!dot % -T png -Gdpi=120 -o %<.png && open %<.png"
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

" gvim {

if has('gui_running')
    set guifont=Hack\ Nerd\ Font\ Mono:h18
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set lines=30 columns=90
endif

" }
