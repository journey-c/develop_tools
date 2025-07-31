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
    vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "", -- 错误符号
                [vim.diagnostic.severity.WARN]  = "", -- 警告符号
                [vim.diagnostic.severity.INFO]  = "", -- 信息符号
                [vim.diagnostic.severity.HINT]  = "", -- 提示符号
            },
            -- 可选：定义高亮组（如果需要自定义颜色）
            texthl = {
                [vim.diagnostic.severity.ERROR] = "GruvboxRed",
                [vim.diagnostic.severity.WARN]  = "GruvboxYellow",
                [vim.diagnostic.severity.INFO]  = "GruvboxBlue",
                [vim.diagnostic.severity.HINT]  = "GruvboxAqua",
            },
        },
        virtual_text = true,
    })

    require("mason").setup()
    require("mason-lspconfig").setup {
        ensure_installed = {
            "lua_ls",
            "gopls",
            "clangd",
        },
    }
end

return _M
