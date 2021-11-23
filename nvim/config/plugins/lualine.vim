lua <<EOF

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'gruvbox',
        disabled_filetypes = {},
        component_separators = '|',
        section_separators = {left = '', right = ''}
    },

    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_lsp', 'coc'}}},
        lualine_c = {'filename'},
        lualine_x = {
            {
                'diagnostics',
                sources = {'nvim_lsp'},
                color_error = "#BF616A",
                color_warn  = "#EBCB8B",
                color_info  = "#81A1AC",
                color_hint  = "#88C0D0",
                symbols = {error = ' ', warn = ' ', info = ' '}
            },
        },
        lualine_y = {'filetype', 'encoding', 'fileformat'},
        lualine_z = {'progress', 'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}

EOF
