local term = {}
local api  = vim.api

local function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command('augroup ' .. group_name)
        api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
            api.nvim_command(command)
        end
        api.nvim_command('augroup END')
    end
end

local autocmds = {
    terminal_job = {
        { "TermOpen", "*", [[tnoremap <buffer> <Esc> <c-\><c-n>]] };
        { "TermOpen", "*", "startinsert" };
        { "TermOpen", "*", "setlocal listchars= nonumber norelativenumber" };
    };
}

function term.setup()
    nvim_create_augroups(autocmds)
end

return term
