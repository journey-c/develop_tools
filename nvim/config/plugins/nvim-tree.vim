lua << EOF
require('nvim-tree').setup {
    filters = {
        dotfiles = true,
    },
    git = {
        enable = false,
        ignore = true,
        timeout = 500,
    },
}
EOF

let g:nvim_tree_quit_on_open = 0
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_git_hl = 0
let g:nvim_tree_root_folder_modifier = ':~'
let g:nvim_tree_group_empty = 1
let g:nvim_tree_disable_window_picker = 0
let g:nvim_tree_symlink_arrow = ' >> '
let g:nvim_tree_respect_buf_cwd = 0
let g:nvim_tree_refresh_wait = 10000
let g:nvim_tree_show_icons = {
            \    'git': 0,
            \    'folders': 1,
            \    'files': 1
            \ }
let g:nvim_tree_icons = {
            \    'default': '',
            \    'symlink': '',
            \    'git': {
            \            'unstaged': "✗",
            \            'staged': "✓",
            \            'unmerged': "",
            \            'renamed': "➜",
            \            'untracked': "★",
            \            'deleted': "",
            \            'ignored': "◌"
            \    },
            \    'folder': {
            \            'arrow_open': "",
            \            'arrow_closed': "",
            \            'default': "",
            \            'open': "",
            \            'empty': "",
            \            'empty_open': "",
            \            'symlink': "",
            \            'symlink_open': "",
            \    }
            \}

nnoremap <leader>n :NvimTreeToggle<CR>
nnoremap <leader>fn :NvimTreeFindFile<CR>

" a list of groups can be found at `:help nvim_tree_highlight`
"highlight NvimTreeFolderIcon guibg=blue
