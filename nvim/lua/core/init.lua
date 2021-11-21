local g    = vim.g
local opt  = vim.opt
local cmd  = vim.cmd
local map  = vim.api.nvim_set_keymap

function basic_configuration()
    opt.cursorline     = true
    opt.tabstop        = 4
    opt.shiftwidth     = 4
    opt.expandtab      = true
    opt.encoding       = 'utf-8'
    opt.ignorecase     = true
    opt.history        = 1024
    opt.lazyredraw     = true
    opt.smartindent    = true
    opt.number         = true
    opt.relativenumber = true
    opt.termguicolors  = true

    cmd [[
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif
    ]]

    local disabled_built_ins = {
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "gzip",
        "zip",
        "zipPlugin",
        "tar",
        "tarPlugin",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
        "logipat",
        "rrhelper",
        "spellfile_plugin",
        "matchit"
    }
    for _, plugin in pairs(disabled_built_ins) do
        g["loaded_" .. plugin] = 1
    end
end

function plugins_management()
    local plugins = require('modules.plugins')
    plugins.enable_plugins()
end

function key_maps()
    g.mapleader = ' '

    map('n', '<leader>n', ':NvimTreeToggle<CR>',   { noremap = true })
    map('n', '<leader>f', ':NvimTreeFindFile<CR>', { noremap = true })
end

function dashboard_setting()
    require('modules.ui')
end

function core()
    basic_configuration()
    plugins_management()
    key_maps()
    dashboard_setting()
end

core()
