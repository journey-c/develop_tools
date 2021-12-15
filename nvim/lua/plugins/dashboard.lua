local g         = vim.g
local dashboard = {}

function dashboard.conf()
    g.dashboard_footer_icon = ' '
    g.dashboard_custom_header = {
'════════════════════════════════════════════════════════════════',
'                                                                ',
'     ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗     ',
'     ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║     ',
'     ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║     ',
'     ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║     ',
'     ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║     ',
'     ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝     ',
'                                                                ',
'════════════════════════════════════════════════════════════════',
}
    g.dashboard_default_executive = 'telescope'

    g.dashboard_custom_shortcut = {
        last_session       = '<leader> s l',
        find_history       = '<leader> f h',
        find_file          = '<leader> f f',
        new_file           = '<leader> c f',
        change_colorscheme = '<leader> t c',
        find_word          = '<leader> f g',
        book_marks         = '<leader> f b',
    }
end

return dashboard
