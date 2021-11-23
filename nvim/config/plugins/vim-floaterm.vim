" --------------------------
" |      vim-floaterm      |
" --------------------------
" Compile
let g:floaterm_title='terminal'
let g:floaterm_autoclose=0
command! -nargs=0 CodeForces :FloatermNew g++ % -std=c++17 -o %< && ./%< < in
command! -nargs=0 CxxRun :FloatermNew g++ % -std=c++17 -o %< && ./%<
command! -nargs=0 ShellRun :FloatermNew sh %
" termainal
nmap <leader>t :FloatermNew<CR>