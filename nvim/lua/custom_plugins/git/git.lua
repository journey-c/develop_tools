local git = {}
local api = vim.api

-- 一个基于 Neovim 原生能力实现的轻量 git 插件：
--   :GitDiff  左右分屏查看变更（左删除 / 右新增），底部文件树可选择
--   :GitLog   当前窗口展示 git log，<CR> 查看对应 commit 的 diff
--
-- 颜色全部复用当前主题的高亮组（Directory/Comment/Title/Identifier
-- /GitSignsAdd/GitSignsDelete/NonText 等），不自造任何高亮。
function git.setup(opts)
    opts = opts or {}

    api.nvim_create_user_command("GitDiff", function()
        require("custom_plugins.git.diff").open({})
    end, { desc = "左右分屏查看 git 变更" })

    api.nvim_create_user_command("GitLog", function()
        require("custom_plugins.git.log").open()
    end, { desc = "查看 git log" })

    if not opts.no_default_keymaps then
        local map_opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<leader>gd", "<cmd>GitDiff<CR>",
            vim.tbl_extend("force", map_opts, { desc = "Git 分屏 diff" }))
        vim.keymap.set("n", "<leader>gl", "<cmd>GitLog<CR>",
            vim.tbl_extend("force", map_opts, { desc = "Git log" }))
    end
end

return git
