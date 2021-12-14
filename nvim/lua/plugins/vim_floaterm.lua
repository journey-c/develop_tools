local g            = vim.g
local cmd          = vim.cmd
local vim_floaterm = {}

function vim_floaterm.conf()
    g.floaterm_title = 'terminal'
    g.floaterm_autoclose = 0
    g.floaterm_borderchars = '─│─│╭╮╯╰'
    cmd [[
    hi FloatermBorder guibg=synIDattr(hlID("Normal"), "bg")
    command! -nargs=0 CodeForces :FloatermNew g++ % -std=c++17 -o %< && ./%< < in
    command! -nargs=0 CxxRun :FloatermNew g++ % -std=c++17 -o %< && ./%<
    command! -nargs=0 ShellRun :FloatermNew sh %
    ]]
end

return vim_floaterm
