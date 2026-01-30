local M = {}

function M.setup()
    local neotest = require('neotest')
    neotest.setup({
        adapters = {
            require("neotest-rust")
        }
    })
end

return M
