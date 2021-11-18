local g    = vim.g
local fn   = vim.fn
local opt  = vim.opt
local cmd  = vim.cmd
local exec = vim.api.nvim_exec
local map = vim.api.nvim_set_keymap

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

    -- getscriptPlugin.vim
    -- gzip.vim
    -- health.vim
    -- logiPat.vim
    -- man.vim
    -- manpager.vim
    -- matchit.vim
    -- matchparen.vim
    -- netrwPlugin.vim
    -- rplugin.vim
    -- rrhelper.vim
    -- shada.vim
    -- spellfile.vim
    -- tarPlugin.vim
    -- tohtml.vim
    -- tutor.vim
    -- vimballPlugin.vim
    -- zipPlugin.vim

    -- disable builtins plugins
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
	g.mapleader = '<space>'

    cmd [[
        nnoremap <C-n> :NvimTreeToggle<CR>
        nnoremap <leader>r :NvimTreeRefresh<CR>
        nnoremap <leader>n :NvimTreeFindFile<CR>
    ]]
    local map = vim.api.nvim_set_keymap
end

function core()
	basic_configuration()
	plugins_management()
    key_maps()
    cmd [[
        colorscheme gruvbox
    ]]
end

core()
