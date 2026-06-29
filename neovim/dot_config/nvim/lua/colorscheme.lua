local colorscheme = "tokyonight-moon"

local moduleName = "colorschemes.".. colorscheme
local f = io.open("colorschemes/"..colorscheme..".lua", "r")
if f ~= nil then
    require(moduleName)
end

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme: " .. colorscheme .. " not found")
    return
end

require("theme")
