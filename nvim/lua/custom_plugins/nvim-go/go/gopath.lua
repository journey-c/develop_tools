local utils           = require "custom_plugins.nvim-go.go.utils"
local api             = vim.api
local gopath          = {}
local initial_go_path = ""

function gopath.Default()
    local GOPATH = os.getenv("GOPATH")
    if #GOPATH == 0 then
        return utils.Env("GOPATH")
    end
    return GOPATH
end

function gopath.GoPath(args)
    -- echo
    if #args == 0 then
        print(gopath.Default())
        return
    end

    -- reset
    if args[1] == '""' then
        if #initial_go_path ~= 0 then
            vim.api.nvim_command("let $GOPATH=\""..initial_go_path.."\"")
            initial_go_path = ""
        end
        utils.Info("GOPATH restored to ".. os.getenv("GOPATH"))
        print(api.nvim_command("LspRestart gopls"))
        return
    end

    -- change
    if args[1] == "." or args[1] == "./" then
        args[1] = vim.fn.getcwd()
    end
    initial_go_path = os.getenv("GOPATH")
    api.nvim_command("let $GOPATH=\""..args[1].."\"")
    if package.loaded['lspconfig'] then
        api.nvim_command("LspRestart gopls")
        utils.Info("GOPATH changed to "..args[1].." and restart lsp server")
    else
        utils.Info("GOPATH changed to "..args[1])
    end
end

return gopath
