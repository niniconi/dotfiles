local function hl(name, attr)
  local ok, val = pcall(vim.api.nvim_get_hl_by_name, name, true)
  if ok and val[attr] then
    return string.format("#%06x", val[attr])
  end
  return "NONE"
end

local function get_mode_colors()
  return {
    blue = hl("LualineBlue", "background"),
    cyan = hl("LualineCyan", "background"),
    black = hl("LualineBlack", "foreground"),
    white = hl("LualineWhite", "foreground"),
    red = hl("LualineRed", "background"),
    violet = hl("LualineViolet", "background"),
    grey = hl("LualineGrey", "background"),
  }
end

local sections = {
  lualine_a = {
    { "mode", separator = { right = "" }, right_padding = 2 },
  },
  lualine_b = {
    "filename",
    "branch",
    "diff",
    {
      "diagnostics",
      symbols = { error = "󰅚 ", warn = " ", info = "󰋽 ", hint = "󰘥 " },
    },
  },
  lualine_c = { "fileformat" },
  lualine_x = {},
  lualine_y = { "filetype", "encoding", "progress" },
  lualine_z = {
    { "location", separator = { left = "" }, left_padding = 2 },
  },
}

local inactive_sections = {
  lualine_a = { "filename" },
  lualine_b = {},
  lualine_c = {},
  lualine_x = {},
  lualine_y = {},
  lualine_z = { "location" },
}

local options = {
  refresh = {
    statusline = 1000,
    tabline = 1000,
    winbar = 1000,
  },
  component_separators = { left = ")", right = "(" },
  section_separators = { left = "", right = "" },
}

require("lualine").setup({
  options = vim.tbl_extend("keep", { theme = "auto" }, options),
  sections = sections,
  inactive_sections = inactive_sections,
  tabline = {},
  extensions = {},
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local c = get_mode_colors()
    vim.api.nvim_set_hl(0, "lualine_a_normal", { fg = c.black, bg = c.violet })
    vim.api.nvim_set_hl(0, "lualine_a_insert", { fg = c.black, bg = c.blue })
    vim.api.nvim_set_hl(0, "lualine_a_visual", { fg = c.black, bg = c.cyan })
    vim.api.nvim_set_hl(0, "lualine_a_replace", { fg = c.black, bg = c.red })
    vim.api.nvim_set_hl(0, "lualine_b_normal", { fg = c.white, bg = c.grey })
    vim.api.nvim_set_hl(0, "lualine_c_normal", { fg = c.white, bg = c.black })
    vim.api.nvim_set_hl(0, "lualine_a_inactive", { fg = c.white, bg = c.black })
    vim.api.nvim_set_hl(0, "lualine_b_inactive", { fg = c.white, bg = c.black })
    vim.api.nvim_set_hl(0, "lualine_c_inactive", { fg = c.black, bg = c.black })
  end,
})
