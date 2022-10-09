local telescope = {}

function telescope.conf()
    require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
            }
        }
    }
    }
end

return telescope
