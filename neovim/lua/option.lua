vim.opt.backup = false

vim.opt.foldmethod = "indent"
vim.opt.foldenable = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "neo-tree",
  },
  callback = function()
    vim.schedule(function()
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.foldenable = false
    end)
  end,
})
