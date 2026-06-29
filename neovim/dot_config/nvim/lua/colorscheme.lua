local dankcolors_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
local ok, spec = pcall(dofile, dankcolors_path)
if ok and spec and spec[1] and spec[1].config then
	spec[1].config()
else
	local status_ok, _ = pcall(vim.cmd, "colorscheme tokyonight-moon")
	if not status_ok then
		vim.notify("colorscheme not found")
	end
end
