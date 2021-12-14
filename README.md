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
    },
    "suggest.completionItemKindLabels": {
        "keyword": "\uf1de",
        "variable": "\ue79b",
        "value": "\uf89f",
        "operator": "\u03a8",
        "constructor": "\uf0ad",
        "function": "\u0192",
        "reference": "\ufa46",
        "constant": "\uf8fe",
        "method": "\uf09a",
        "struct": "\ufb44",
        "class": "\uf0e8",
        "interface": "\uf417",
        "text": "\ue612",
        "enum": "\uf435",
        "enumMember": "\uf02b",
        "module": "\uf40d",
        "color": "\ue22b",
        "property": "\ue624",
        "field": "\uf9be",
        "unit": "\uf475",
        "event": "\ufacd",
        "file": "\uf723",
        "folder": "\uf114",
        "snippet": "\ue60b",
        "typeParameter": "\uf728",
        "default": "\uf29c"
    }
}
```
