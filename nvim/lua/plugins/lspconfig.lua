local _M = {}

function _M.conf()
    local lspconfig = require('lspconfig')

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.documentationFormat = {
        'markdown', 'plaintext'
    }
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.preselectSupport = true
    capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
    capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
    capabilities.textDocument.completion.completionItem.deprecatedSupport = true
    capabilities.textDocument.completion.completionItem.commitCharactersSupport =
        true
    capabilities.textDocument.completion.completionItem.tagSupport = {
        valueSet = { 1 }
    }
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = { 'documentation', 'detail', 'additionalTextEdits' }
    }
    vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "GruvboxRed" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "GruvboxYellow" })
    vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "GruvboxBlue" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "GruvboxAqua" })

    require("mason").setup()
    require("mason-lspconfig").setup {
        ensure_installed = {
            "lua_ls",
            "gopls",
            "clangd",
        },
    }
    local navbuddy = require("nvim-navbuddy")
    require("mason-lspconfig").setup_handlers({
        function(server_name)
            require("lspconfig")[server_name].setup {
                on_attach = function(client, bufnr)
                    require('lsp_signature').on_attach({
                        -- 参数提示
                        bind = true,
                        use_lspsaga = false,
                        floating_window = true,
                        fix_pos = true,
                        hint_enable = true,
                        hint_prefix = " ",
                        hi_parameter = "Search",
                        handler_opts = { "double" }
                    })
                    navbuddy.attach(client, bufnr) -- 函数树
                end
            }
        end,
        -- Next, you can provide targeted overrides for specific servers.
        ["lua_ls"] = function()
            lspconfig.lua_ls.setup {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" }
                        }
                    }
                }
            }
        end
    })
end

return _M
