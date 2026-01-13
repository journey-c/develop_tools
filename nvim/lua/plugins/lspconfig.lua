local _M = {}

function _M.conf()
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
            -- 设置背景高亮组，确保与主题一致
            linehl = nil,
            numhl = nil,
        },
        virtual_text = true,
    })

    require("mason").setup()
    require("mason-lspconfig").setup()

    -- 确保诊断符号的背景色与主题一致，同时保留前景色
    local normal_bg = vim.fn.synIDattr(vim.fn.hlID('Normal'), 'bg')
    vim.cmd(string.format([[
        hi DiagnosticSignError guifg=#fb4934 guibg=%s ctermfg=167 ctermbg=235
        hi DiagnosticSignWarn guifg=#fabd2f guibg=%s ctermfg=214 ctermbg=235
        hi DiagnosticSignInfo guifg=#83a598 guibg=%s ctermfg=109 ctermbg=235
        hi DiagnosticSignHint guifg=#8ec07c guibg=%s ctermfg=108 ctermbg=235
        hi SignColumn guibg=%s ctermbg=235
    ]], 
        normal_bg, normal_bg, normal_bg, normal_bg, normal_bg
    ))
    vim.lsp.config.ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        },
        root_markers = { "package.json", "tsconfig.json", ".git" },
        capabilities = capabilities,
    }

    vim.lsp.config.eslint = {
        cmd = { "vscode-eslint-language-server", "--stdio" },
        filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        },
        root_markers = { "package.json", ".eslintrc", ".git" },
        capabilities = capabilities,
    }

    -- 启用已安装的 LSP
    for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
        vim.lsp.enable(server)
    end
end

return _M
