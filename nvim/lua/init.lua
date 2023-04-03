local g   = vim.g
local opt = vim.opt
local cmd = vim.cmd
local api = vim.api
local map = vim.api.nvim_set_keymap

local basic_configuration = function()
    opt.cursorline     = true
    opt.scrolloff      = 5
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
    opt.completeopt    = 'menu,menuone,noselect'
    opt.swapfile       = false
    opt.signcolumn     = 'yes:1'
    opt.colorcolumn    = '80'
    opt.mouse          = ''
    opt.splitbelow     = true

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

local disable_distribution_plugins = function()
    vim.g.loaded_gzip              = 1
    vim.g.loaded_tar               = 1
    vim.g.loaded_tarPlugin         = 1
    vim.g.loaded_zip               = 1
    vim.g.loaded_zipPlugin         = 1
    vim.g.loaded_getscript         = 1
    vim.g.loaded_getscriptPlugin   = 1
    vim.g.loaded_vimball           = 1
    vim.g.loaded_vimballPlugin     = 1
    vim.g.loaded_matchit           = 1
    vim.g.loaded_matchparen        = 1
    vim.g.loaded_2html_plugin      = 1
    vim.g.loaded_logiPat           = 1
    vim.g.loaded_rrhelper          = 1
    vim.g.loaded_netrw             = 1
    vim.g.loaded_netrwPlugin       = 1
    vim.g.loaded_netrwSettings     = 1
    vim.g.loaded_netrwFileHandlers = 1
end

local plugins_management = function()
    require('plugins')
    require('custom_plugins')
end

local key_maps = function()
    local opts = { noremap = true, silent = true }
    g.mapleader = ' '

    map('n', '<leader>n', ':NvimTreeToggle<CR>', opts)
    map('n', '<leader>fn', ':NvimTreeFindFile<CR>', opts)

    map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    api.nvim_command [[ command! -nargs=0 Format lua vim.lsp.buf.format { async = true }<CR> ]]

    map('n', '<leader>tn', ':split | terminal<CR>', opts)

    map('n', '<leader>bn', ':BufferLineCycleNext<CR>', opts)
    map('n', '<leader>bp', ':BufferLineCyclePrev<CR>', opts)
    map('n', '<leader>bl', ':BufferLineCloseLeft<CR>', opts)
    map('n', '<leader>br', ':BufferLineCloseRight<CR>', opts)
    map('n', '<leader>d', ':bd<CR>', opts)

    map('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', opts)
    map('n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>', opts)
    map('n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>', opts)
    map('n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>', opts)
    map('n', '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>', opts)
    map('n', '<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>', opts)
    map('n', '<leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>', opts)
    map('n', '<leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>', opts)
    map('n', '<leader>9', '<Cmd>BufferLineGoToBuffer 9<CR>', opts)

    map('n', '<leader>so', ':SymbolsOutline<CR>', opts)

    map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
    map('n', '<leader>fw', '<cmd>Telescope live_grep<cr>', opts)
    map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
    map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

    map('n', '<Leader>sc', ':DashboardChangeColorscheme<CR>', opts)
    map('n', '<Leader>fe', ':DashboardFindHistory<CR>', opts)

    map('n', '<leader>ga', "<Cmd>lua require('diaglist').open_all_diagnostics()<CR>", opts)
end

local dashboard_config = function()
    g.floaterm_title = 'terminal'
    g.floaterm_autoclose = 0
    g.floaterm_borderchars = '─│─│╭╮╯╰'
    cmd [[
    let g:floaterm_width = 0.9
    let g:floaterm_height = 0.9
    hi FloatermBorder guibg=synIDattr(hlID("Normal"), "bg")
    command! -nargs=0 Tig :terminal tig
    command! -nargs=0 CodeForces :split | terminal g++ % -std=c++17 -o %< && ./%< < in <CR>
    command! -nargs=0 CxxRun :split | terminal g++ % -std=c++17 -o %< && ./%< <CR>
    command! -nargs=0 ShellRun :split | terminal sh % <CR>
    ]]

    vim.opt.fillchars = {
        vert = "┃",
        eob = " ", -- suppress ~ at EndOfBuffer
    }
end

local core = function()
    basic_configuration()
    disable_distribution_plugins()
    plugins_management()
    -- listen to user event and trigger lualine refresh
    vim.cmd([[
    augroup lualine_augroup
        autocmd!
        autocmd User LspProgressStatusUpdated lua require("lualine").refresh()
    augroup END
    ]])
    key_maps()
    dashboard_config()
end

core()
