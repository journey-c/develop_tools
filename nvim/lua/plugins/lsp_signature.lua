local _M = {}

function _M.conf()
    local ok, sig = pcall(require, 'lsp_signature')
    if not ok then return end
    sig.setup({
        bind = true,
        floating_window = true,
        floating_window_above_cur_line = false,
        hint_enable = false,
        doc_lines = 0,
        max_height = 12,
        max_width = 80,
        handler_opts = { border = 'single' },
        always_trigger = true,
        auto_close_after = nil,
        wrap = true,
        transparency = 10,
        zindex = 50,
        toggle_key = '<M-s>',
        select_signature_key = '<C-n>',
        move_cursor_key = '<C-f>',
        extra_trigger_chars = { '(', ',' },
    })
end

return _M
