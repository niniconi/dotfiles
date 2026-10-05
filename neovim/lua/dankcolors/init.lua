local config = require("dankcolors.config")

local M = {}
---@type {light?: string, dark?: string}
M.styles = {}

---@param opts? dankcolors.Config
function M.load(opts)
  opts = require("dankcolors.config").extend(opts)
  local bg = vim.o.background
  local style_bg = "dark"

  if opts.style == "day" then
    style_bg = "light"
  end

  if bg ~= style_bg then
    if vim.g.colors_name == "dankcolors" then
      opts.style = bg == "light" and "day" or "dark"
    else
      vim.o.background = style_bg
    end
  end
  M.styles[vim.o.background] = opts.style
  return require("dankcolors.theme").setup(opts)
end

M.setup = config.setup

return M
