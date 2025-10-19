local M = {}

function M.setup()
    vim.opt.termguicolors = true

    require('bufferline').setup {}
end

return M
