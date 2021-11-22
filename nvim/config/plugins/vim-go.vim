" --------------------------
" |        vim-go          |
" --------------------------
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

" 预览悬浮窗
let g:go_doc_popup_window = 1
