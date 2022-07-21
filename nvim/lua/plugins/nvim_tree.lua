local g         = vim.g
local nvim_tree = {}

function nvim_tree.conf()
    require('nvim-tree').setup {
        filters = {
            dotfiles = true,
        },
        git = {
            enable = false,
            ignore = true,
            timeout = 500,
        },
        renderer = {
            indent_markers = {
                enable = true,
                icons = {
                    corner = "└",
                    edge = "│",
                    none = "",
                },
            },
            highlight_git = false,
            root_folder_modifier = ':~',
            group_empty = true,
            icons = {
                symlink_arrow = ' >> ',
                show = {
                    git = false,
                    folder = true,
                    file = true,
                },
                glyphs = {
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
                },
            },
        },
        respect_buf_cwd = false,
    }
    g.nvim_tree_refresh_wait = 10000
end

return nvim_tree
