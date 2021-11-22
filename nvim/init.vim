let bootstrap = 0

lua << EOF

local fn           = vim.fn
local g            = vim.g
local install_path = fn.stdpath('config') .. "/autoload/plug.vim"

if fn.empty(fn.glob(install_path)) > 0 then
    g.bootstrap = 1
    print("[ installing vim-plug ]")
    fn.system({'curl', '-fLo', install_path, '--create-dirs', 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'})
end

EOF

" 加载base
exec 'source' globpath(stdpath('config'), "/config/base.vim")

" 加载插件
exec 'source' globpath(stdpath('config'), "/config/plug.vim")

" 加载主题
exec 'source' globpath(stdpath('config'), "/config/theme.vim")
