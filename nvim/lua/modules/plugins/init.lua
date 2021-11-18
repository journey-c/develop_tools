local global = require('core.global')

local plugins = {}

function plugins:enable_plugins()
    require('modules.plugins.packer')
    require('packer').install()
end

return plugins
