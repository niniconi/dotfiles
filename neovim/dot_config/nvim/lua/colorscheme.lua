local ok, _ = pcall(vim.cmd, "colorscheme dankcolors")
if not ok then
  vim.notify("colorscheme: dankcolors not found")
else
  require("dankcolors.watcher").start()
end
