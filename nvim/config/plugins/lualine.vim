lua <<EOF

local custom_gruvbox = require'lualine.themes.gruvbox'

custom_gruvbox.normal.c.bg = '#112233' -- rgb colors are supported

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = custom_gruvbox,
        disabled_filetypes = {},
        component_separators = '|',
        section_separators = {left = '', right = ''}
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_diagnostic', 'coc'}}},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
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
