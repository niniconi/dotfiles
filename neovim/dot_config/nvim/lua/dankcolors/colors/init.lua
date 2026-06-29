local Util = require("dankcolors.util")

local M = {}

---@param opts? dankcolors.Config
function M.setup(opts)
  opts = require("dankcolors.config").extend(opts)

  Util.day_brightness = opts.day_brightness

  local DANKCOLORS_FILE = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"

  local text
  local ok, fd = pcall(io.open, DANKCOLORS_FILE, "r")
  if ok then
    text = fd:read("*a")
    fd:close()
  end

  local b16 = {}
  if text then
    for key, val in text:gmatch("base(%x+)%s*=%s*['\"](#[0-9a-fA-F]+)['\"]") do
      b16["base" .. key] = val
    end
  end

  if not next(b16) then
    b16 = {
      base00 = "#0f1512",
      base01 = "#171d1a",
      base02 = "#1b211e",
      base03 = "#808a85",
      base04 = "#d2dfd9",
      base05 = "#f8fffc",
      base06 = "#f8fffc",
      base07 = "#f8fffc",
      base08 = "#ffbc9f",
      base09 = "#ffbc9f",
      base0A = "#a5eacc",
      base0B = "#fff272",
      base0C = "#d7ffed",
      base0D = "#a5eacc",
      base0E = "#c0ffe4",
      base0F = "#c0ffe4",
    }
  end

  local green_mint = b16.base0D
  local pale_mint = b16.base0C
  local peach = b16.base08

  local palette = {
    bg = b16.base00,
    bg_dark = Util.blend_bg(b16.base01, 0.6, b16.base00),
    bg_dark1 = Util.blend_bg(b16.base01, 0.7, "#000000"),
    bg_highlight = b16.base02,
    comment = b16.base03,
    fg = b16.base05,
    fg_dark = b16.base04,
    fg_gutter = Util.blend_bg(b16.base02, 0.5, b16.base03),

    blue = Util.brighten(pale_mint, -0.30, -0.3),
    blue0 = Util.blend_bg(pale_mint, 0.25, "#000000"),
    blue1 = Util.brighten(pale_mint, -0.13, 0),
    blue2 = Util.brighten(pale_mint, -0.20, 0),
    blue5 = Util.brighten(pale_mint, -0.25, 0),
    blue6 = Util.brighten(pale_mint, -0.05, 0),
    blue7 = Util.blend_bg(pale_mint, 0.35, b16.base00),

    cyan = Util.brighten(pale_mint, -0.18, 0),
    teal = Util.brighten(pale_mint, -0.28, 0),
    green = green_mint,
    green1 = Util.brighten(green_mint, 0.05, 0),
    green2 = Util.blend(green_mint, 0.5, pale_mint),
    magenta = Util.brighten(peach, -0.10, 0),
    magenta2 = Util.brighten(peach, 0.05, 0),
    orange = b16.base09,
    purple = Util.brighten(peach, -0.20, 0),
    red = b16.base08,
    red1 = Util.blend_bg(peach, 0.3, "#000000"),
    yellow = b16.base0B,

    dark3 = b16.base03,
    dark5 = b16.base04,
    terminal_black = Util.blend_bg(b16.base02, 0.5, "#000000"),
  }

  palette.none = "NONE"

  palette.diff = {
    add = Util.blend_bg(palette.green, 0.25),
    delete = Util.blend_bg(palette.red, 0.25),
    change = Util.blend_bg(palette.blue, 0.15),
    text = palette.blue7,
  }

  palette.git = {
    add = Util.brighten(palette.green, 0.05, 0.1),
    change = Util.brighten(palette.blue, 0.05, 0.1),
    delete = Util.brighten(palette.red, 0.05, 0.1),
    ignore = palette.dark3,
  }
  palette.black = Util.blend_bg(palette.bg, 0.8, "#000000")
  palette.border_highlight = Util.blend_bg(palette.blue, 0.8)
  palette.border = palette.black

  palette.bg_popup = palette.bg_dark
  palette.bg_statusline = palette.bg_dark

  palette.bg_sidebar = opts.styles.sidebars == "transparent" and palette.none
    or opts.styles.sidebars == "dark" and palette.bg_dark
    or palette.bg

  palette.bg_float = opts.styles.floats == "transparent" and palette.none
    or opts.styles.floats == "dark" and palette.bg_dark
    or palette.bg

  palette.bg_visual = Util.blend_bg(palette.blue, 0.4)
  palette.bg_search = palette.blue0
  palette.fg_sidebar = palette.fg_dark
  palette.fg_float = palette.fg

  palette.error = palette.red
  palette.todo = palette.blue
  palette.warning = palette.yellow
  palette.info = palette.blue2
  palette.hint = palette.teal

  palette.rainbow = {
    palette.blue,
    palette.yellow,
    palette.green,
    palette.teal,
    palette.magenta,
    palette.purple,
    palette.orange,
    palette.red,
  }

  palette.terminal = {
    black = palette.black,
    black_bright = palette.terminal_black,
    red = palette.red,
    red_bright = Util.brighten(palette.red),
    green = palette.green,
    green_bright = Util.brighten(palette.green),
    yellow = palette.yellow,
    yellow_bright = Util.brighten(palette.yellow),
    blue = palette.blue,
    blue_bright = Util.brighten(palette.blue),
    magenta = palette.magenta,
    magenta_bright = Util.brighten(palette.magenta),
    cyan = palette.cyan,
    cyan_bright = Util.brighten(palette.cyan),
    white = palette.fg_dark,
    white_bright = palette.fg,
  }

  Util.bg = palette.bg
  Util.fg = palette.fg

  opts.on_colors(palette)

  return palette, opts
end

return M
