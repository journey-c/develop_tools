 let g:dashboard_footer_icon = ' '
" 

let g:dashboard_custom_header = [
\ '════════════════════════════════════════════════════════════════',
\ '                                                                ',
\ '     ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗     ',
\ '     ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║     ',
\ '     ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║     ',
\ '     ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║     ',
\ '     ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║     ',
\ '     ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝     ',
\ '                                                                ',
\ '════════════════════════════════════════════════════════════════',
\]

" Default value is clap
let g:dashboard_default_executive ='telescope'

"SPC mean the leaderkey
let g:dashboard_custom_shortcut={
\ 'last_session'       : '<leader> s l',
\ 'find_history'       : '<leader> f h',
\ 'find_file'          : '<leader> f f',
\ 'new_file'           : '<leader> c f',
\ 'change_colorscheme' : '<leader> t c',
\ 'find_word'          : '<leader> f g',
\ 'book_marks'         : '<leader> f b',
\ }

nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cf :DashboardNewFile<CR>
