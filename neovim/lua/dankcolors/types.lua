---@class dankcolors.Highlight: vim.api.keyset.highlight
---@field style? vim.api.keyset.highlight

---@alias dankcolors.Highlights table<string,dankcolors.Highlight|string>

---@alias dankcolors.HighlightsFn fun(colors: ColorScheme, opts:dankcolors.Config):dankcolors.Highlights

---@class dankcolors.Cache
---@field groups dankcolors.Highlights
---@field inputs table
