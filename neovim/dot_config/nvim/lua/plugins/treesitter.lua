local M = {}

function M.setup()
    require('nvim-treesitter.configs').setup({
        ensure_installed = { 'rust' },
        highlight = { enable = true },
        indent = { enable = true },
    })
end

return M
