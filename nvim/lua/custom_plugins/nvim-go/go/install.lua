local install = {}
local utils   = require("custom_plugins.nvim-go.go.utils")
local fn      = vim.fn
local uv      = vim.loop
local tools   = {}

local packages = {
      fillstruct    = 'github.com/davidrjenni/reftools/cmd/fillstruct@master',
      gomodifytags  = 'github.com/fatih/gomodifytags@latest',
      gotest        = 'github.com/cweill/gotests/gotests@master'
}

for pkg, _ in pairs(packages) do
    table.insert(tools, pkg)
end

local function checkBinaries()
    if fn.executable('go') ~= 1 then
        utils.Error("go executable not found.")
        return -1
    end
    if fn.executable('git') ~= 1 then
        utils.Error("git executable not found.")
        return -1
    end
    return 0
end

function install.install_all(updateBinaries)
    if (checkBinaries() ~= 0) then
        return
    end
    if utils.Gopath() == "" then
        utils.Error("'$GOPATH is not set and `go env GOPATH` returns empty'")
        return
    end

    local go_bin_path = fn.join({utils.Gopath(), "bin"}, '/')

    local install_cmd = { "go", "install", "-v" }

    local msg_prefix = nil
    if updateBinaries == 1 then
        msg_prefix = "ReInstall "
    else
        msg_prefix = "Install "
    end

    for k, v in pairs(packages) do
        if not uv.fs_stat(fn.join({go_bin_path, fn.tr(k, '_', '-')}, '/')) or updateBinaries == 1 then
            table.insert(install_cmd, v)
            fn.jobstart(install_cmd, {
                on_exit = function(_, data, _)
                    if data == 0 then
                        local msg = msg_prefix .. k .. " finished to folder " .. go_bin_path
                        print(msg)
                    end
                end,
                on_stderr = function(_, data, _)
                    local msg = nil
                    if #data > 1 then
                        msg = msg_prefix .. k .. " failed " .. vim.inspect(data)
                        print(msg)
                    end
                end,
            })
            table.remove(install_cmd)
       end
    end
end

return install
