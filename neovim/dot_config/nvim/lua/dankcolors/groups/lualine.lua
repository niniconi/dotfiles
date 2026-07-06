local M = {}

M.url = "https://github.com/nvim-lualine/lualine.nvim"

function M.get(c)
  return {
    LualineViolet = { fg = c.bg, bg = c.cyan },
    LualineBlue = { fg = c.bg, bg = c.yellow },
    LualineCyan = { fg = c.bg, bg = c.magenta },
    LualineRed = { fg = c.bg, bg = c.orange },
    LualineGrey = { fg = c.fg_dark, bg = c.fg_gutter },
    LualineBlack = { fg = c.bg, bg = c.bg_statusline },
    LualineWhite = { fg = c.fg, bg = c.bg_statusline },

    lualine_a_normal = { fg = c.bg, bg = c.cyan },
    lualine_a_insert = { fg = c.bg, bg = c.yellow },
    lualine_a_visual = { fg = c.bg, bg = c.magenta },
    lualine_a_replace = { fg = c.bg, bg = c.orange },
    lualine_b_normal = { fg = c.fg, bg = c.fg_gutter },
    lualine_c_normal = { fg = c.fg, bg = c.bg_statusline },
    lualine_a_inactive = { fg = c.fg, bg = c.bg_statusline },
    lualine_b_inactive = { fg = c.fg, bg = c.bg_statusline },
    lualine_c_inactive = { fg = c.fg, bg = c.bg_statusline },
  }
end

return M
