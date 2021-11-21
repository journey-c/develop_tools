local cmd = vim.cmd
local ui = {}

function ui.set_colorscheme()
    cmd [[
        colorscheme gruvbox
    ]]
end

return ui
