local cmd = vim.cmd
local g   = vim.g
local ui  = {}

function ui.colorscheme()
    cmd [[
        colorscheme gruvbox
    ]]
end

function ui.nvim_tree() 
    g.nvim_tree_gitignore = 1
    g.nvim_tree_quit_on_open = 0
    g.nvim_tree_indent_markers = 1
    g.nvim_tree_git_hl = 0
    g.nvim_tree_root_folder_modifier = ':~'
    g.nvim_tree_group_empty = 1
    g.nvim_tree_disable_window_picker = 1
    g.nvim_tree_symlink_arrow = ' >> '
    g.nvim_tree_respect_buf_cwd = 1
    g.nvim_tree_refresh_wait = 500
    g.nvim_tree_show_icons = {
        git = 0,
        folders = 1,
        files = 1
    }
    g.nvim_tree_icons = {
        default = '',
        symlink = '',
        git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌"
        },
        folder = {
            arrow_open = "",
            arrow_closed = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
        }
    }
end

return ui
