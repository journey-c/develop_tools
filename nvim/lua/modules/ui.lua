local cmd = vim.cmd

local ui = {}

function ui:nvim_tree()
    require('nvim-tree').setup()
end

return ui
