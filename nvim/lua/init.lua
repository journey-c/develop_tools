local g    = vim.g
local opt  = vim.opt
local cmd  = vim.cmd
local map  = vim.api.nvim_set_keymap

local basic_configuration = function()
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
    opt.termguicolors  = true
    opt.completeopt    = 'menu,menuone,noselect'
    opt.swapfile       = false
    opt.signcolumn     = 'yes:1'

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

local plugins_management = function ()
    require('plugins')
end

local key_maps = function()
    local opts = { noremap=true, silent=true }
    g.mapleader = ' '

    map('n', '<leader>n', ':NvimTreeToggle<CR>',   opts)
    map('n', '<leader>fn', ':NvimTreeFindFile<CR>', opts)

    map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    map('n',  '<leader>tn', ':FloatermNew<CR>', opts)

    map('n', '<leader>bn', ':BufferLineCycleNext<CR>', opts)
    map('n', '<leader>bp', ':BufferLineCyclePrev<CR>', opts)
    map('n', '<leader>bl', ':BufferLineCloseLeft<CR>', opts)
    map('n', '<leader>br', ':BufferLineCloseRight<CR>', opts)
    map('n', '<leader>bd', ':bd<CR>', opts)

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
    map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
    map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
    map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

    map('n', '<Leader>tc', ':DashboardChangeColorscheme<CR>', opts)
    map('n', '<Leader>fb', ':DashboardJumpMark<CR>', opts)
    map('n', '<Leader>cf', ':DashboardNewFile<CR>', opts)

    map('n', '<leader>tt', ':TroubleToggle<CR>', opts)
end

local core = function()
    basic_configuration()
    plugins_management()
    key_maps()
end

core()
