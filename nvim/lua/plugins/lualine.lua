local lualine = {}

function lualine.conf()
    local custom_gruvbox = require'lualine.themes.gruvbox'

    custom_gruvbox.normal.c.bg = '#112233' -- rgb colors are supported

    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = custom_gruvbox,
            disabled_filetypes = {},
            section_separators = {left = '', right = ''},
            component_separators = '|',
        },
        sections = {
            lualine_a = {
                {'mode', separator = { left = '' }, right_padding = 2}
            },
            lualine_b = {
                {'branch'},
                {'diff'},
                {'diagnostics', sources={'nvim_diagnostic'}}
            },
            lualine_c = {{'filename', path=1}},
            lualine_x = {'encoding', 'fileformat'},
            lualine_y = {'filetype', 'progress'},
            lualine_z = {{'location', separator = { right = '' }, left_padding = 2}}
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
end

return lualine
