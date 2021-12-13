# 开发工具仓库
- [x] nvim

## 常用coc.nvim扩展
```
- ✓ coc-lua
- ✓ coc-pyright
- ✓ coc-rls
```
- coc-nvim配置lsp
**安装coc-go的话，他和vim-go都会起gopls server浪费资源**
```
{
    "languageserver": {
        "golang": {
            "command": "gopls",
            "rootPatterns": [
                "go.mod",
                ".vim/",
                ".git/",
                ".hg/"
            ],
            "filetypes": [
                "go"
            ],
            "initializationOptions": {
                "usePlaceholders": true
            }
        },
        "clangd": {
            "command": "clangd",
            "rootPatterns": [
                "compile_flags.txt",
                "compile_commands.json"
            ],
            "filetypes": [
                "c",
                "cc",
                "cpp",
                "c++",
                "objc",
                "objcpp"
            ]
        }
    }
}
```
