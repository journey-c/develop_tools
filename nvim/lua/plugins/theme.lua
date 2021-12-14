local cmd   = vim.cmd
local theme = {}

function theme.conf()
    cmd [[ colorscheme gruvbox ]]
end

return theme
