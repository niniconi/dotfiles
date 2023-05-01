-- vim.o.background = "dark"
-- vim.g.tokyonight_style = "storm" -- day / night
-- 半透明
-- vim.g.tokyonight_transparent = true
-- vim.g.tokyonight_transparent_sidebar = true

local colorscheme = "tokyonight"
--import colorscheme lua
local moduleName = "colorschemes.".. colorscheme
local f=io.open("colorschemes/"..colorscheme..".lua","r")
if f~=nil then
    require(moduleName)
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme: " .. colorscheme .. "not found the colorscheme")
  return
end
