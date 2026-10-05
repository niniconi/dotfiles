local M = {}

function M.setup()
  require("noice").setup({
    presets = {
      lsp_doc_border = true,
    },
  })
end

return M
