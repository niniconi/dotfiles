local M = {}

local DANKCOLORS_FILE = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"

local function read_dankcolors()
    local ok, spec = pcall(dofile, DANKCOLORS_FILE)
    if not ok or not spec or not spec[1] or not spec[1].config then
        return {}
    end

    local content = vim.fn.readfile(DANKCOLORS_FILE)
    local text = table.concat(content, "\n")

    local colors = {}
    for key, val in text:gmatch("base(%x+)%s*=%s*'(#[0-9a-fA-F]+)'") do
        colors["base" .. key] = val
    end
    return colors
end

local hl_map = {
    -- base  background/foreground
    Normal        = { bg = "base00", fg = "base05", sp = "NONE" },
    NormalFloat   = { bg = "base00", fg = "base05" },
    NormalNC      = { bg = "base00", fg = "base05" },
    ColorColumn   = { bg = "base01" },
    CursorColumn  = { bg = "base01" },
    CursorLine    = { bg = "base01" },
    LineNr        = { fg = "base04", bg = "NONE" },
    CursorLineNr  = { fg = "base05", bg = "base01" },
    SignColumn    = { bg = "base00" },
    Folded        = { bg = "base01", fg = "base03" },
    VertSplit     = { fg = "base03", bg = "NONE" },
    WinSeparator  = { fg = "base03", bg = "NONE" },
    Pmenu         = { bg = "base01", fg = "base05" },
    PmenuSel      = { bg = "base02", fg = "base05" },
    PmenuSbar     = { bg = "base01" },
    PmenuThumb    = { bg = "base03" },
    StatusLine    = { fg = "base04", bg = "base01" },
    StatusLineNC  = { fg = "base03", bg = "base01" },
    Visual        = { bg = "base02" },
    VisualNOS     = { bg = "base02" },
    Search        = { fg = "base00", bg = "base0A" },
    IncSearch     = { fg = "base00", bg = "base0A" },
    Substitute    = { fg = "base00", bg = "base0A" },
    MatchParen    = { fg = "base08", bg = "base02" },
    NonText       = { fg = "base03" },
    Whitespace    = { fg = "base03" },
    SpecialKey    = { fg = "base03" },
    EndOfBuffer   = { fg = "base01" },
    FloatBorder   = { fg = "base03", bg = "base00" },
    FloatTitle    = { fg = "base05", bg = "base00" },
    TabLine       = { fg = "base03", bg = "base01" },
    TabLineSel    = { fg = "base05", bg = "base02" },
    TabLineFill   = { bg = "base01" },
    Title         = { fg = "base0D" },
    Directory     = { fg = "base0D" },
    Comment       = { fg = "base03" },

    -- syntax
    Constant      = { fg = "base09" },
    String        = { fg = "base0B" },
    Character     = { fg = "base0B" },
    Number        = { fg = "base09" },
    Boolean       = { fg = "base09" },
    Float         = { fg = "base09" },
    Identifier    = { fg = "base08" },
    Function      = { fg = "base0D" },
    Statement     = { fg = "base0E" },
    Conditional   = { fg = "base0E" },
    Repeat        = { fg = "base0E" },
    Label         = { fg = "base0E" },
    Operator      = { fg = "base05" },
    Keyword       = { fg = "base0E" },
    Exception     = { fg = "base08" },
    PreProc       = { fg = "base0F" },
    Include       = { fg = "base0D" },
    Define        = { fg = "base0E" },
    Macro         = { fg = "base08" },
    PreCondit     = { fg = "base0F" },
    Type          = { fg = "base0C" },
    StorageClass  = { fg = "base0E" },
    Structure     = { fg = "base0C" },
    Typedef       = { fg = "base0C" },
    Special       = { fg = "base0C" },
    SpecialChar   = { fg = "base0C" },
    Tag           = { fg = "base0D" },
    Delimiter     = { fg = "base05" },
    SpecialComment = { fg = "base03" },
    Debug         = { fg = "base08" },
    Underlined    = { fg = "base0D", underline = true },
    Error         = { fg = "base08" },
    Todo          = { fg = "base0A", bg = "base01" },

    -- diff
    DiffAdd       = { fg = "base0B", bg = "NONE" },
    DiffChange    = { fg = "base0D", bg = "NONE" },
    DiffDelete    = { fg = "base08", bg = "NONE" },
    diffAdded     = { fg = "base0B" },
    diffRemoved   = { fg = "base08" },
    diffChanged   = { fg = "base0D" },

    -- diagnostics
    DiagnosticError          = { fg = "base08" },
    DiagnosticWarn           = { fg = "base0A" },
    DiagnosticInfo           = { fg = "base0D" },
    DiagnosticHint           = { fg = "base0C" },
    DiagnosticOk             = { fg = "base0B" },
    DiagnosticVirtualTextError = { fg = "base08", bg = "NONE" },
    DiagnosticVirtualTextWarn  = { fg = "base0A", bg = "NONE" },
    DiagnosticVirtualTextInfo  = { fg = "base0D", bg = "NONE" },
    DiagnosticVirtualTextHint  = { fg = "base0C", bg = "NONE" },
    DiagnosticUnderlineError   = { undercurl = true, sp = "base08" },
    DiagnosticUnderlineWarn    = { undercurl = true, sp = "base0A" },
    DiagnosticUnderlineInfo    = { undercurl = true, sp = "base0D" },
    DiagnosticUnderlineHint    = { undercurl = true, sp = "base0C" },
    DiagnosticSignError        = { fg = "base08", bg = "base00" },
    DiagnosticSignWarn         = { fg = "base0A", bg = "base00" },
    DiagnosticSignInfo         = { fg = "base0D", bg = "base00" },
    DiagnosticSignHint         = { fg = "base0C", bg = "base00" },
    DiagnosticFloatingError    = { fg = "base08", bg = "base01" },
    DiagnosticFloatingWarn     = { fg = "base0A", bg = "base01" },
    DiagnosticFloatingInfo     = { fg = "base0D", bg = "base01" },
    DiagnosticFloatingHint     = { fg = "base0C", bg = "base01" },

    -- neo-tree
    NeoTreeNormal             = { fg = "base05", bg = "base00" },
    NeoTreeNormalNC           = { fg = "base05", bg = "base00" },
    NeoTreeCursorLine         = { bg = "base01" },
    NeoTreeIndentMarker       = { fg = "base03" },
    NeoTreeExpander           = { fg = "base03" },
    NeoTreeDotfile            = { fg = "base04" },
    NeoTreeRootName           = { fg = "base0D" },
    NeoTreeDirectoryName      = { fg = "base0D" },
    NeoTreeFileName           = { fg = "base05" },
    NeoTreeFileNameOpened     = { fg = "base0D" },
    NeoTreeTitleBar           = { fg = "base04", bg = "base01" },
    NeoTreeFloatBorder        = { fg = "base03", bg = "base00" },
    NeoTreeFloatTitle         = { fg = "base05", bg = "base00" },
    NeoTreeDimText            = { fg = "base03" },
    NeoTreeSymbolicLinkTarget = { fg = "base0C" },
    NeoTreeGitAdded           = { fg = "base0B" },
    NeoTreeGitDeleted         = { fg = "base08" },
    NeoTreeGitModified        = { fg = "base0D" },
    NeoTreeGitUntracked       = { fg = "base0A" },
    NeoTreeGitConflict        = { fg = "base08" },
    NeoTreeGitIgnored         = { fg = "base03" },
    NeoTreeTabActive          = { fg = "base05", bg = "base00" },
    NeoTreeTabInactive        = { fg = "base03", bg = "base01" },
    NeoTreeTabSeparatorActive   = { fg = "base03", bg = "base00" },
    NeoTreeTabSeparatorInactive = { fg = "base01", bg = "base01" },
    NeoTreeWinSeparator       = { fg = "base03", bg = "base00" },
    WinBar                    = { fg = "base04", bg = "base01" },
    WinBarNC                  = { fg = "base03", bg = "base01" },
}

local term_colors = {
    "base00", "base08", "base0B", "base0A",
    "base0D", "base0E", "base0C", "base05",
    "base03", "base09", "base0B", "base0A",
    "base0D", "base0E", "base0C", "base07",
}

function M.override()
    local colors = read_dankcolors()
    if not next(colors) then
        return
    end

    for group, opts in pairs(hl_map) do
        local hl = {}
        for k, v in pairs(opts) do
            if type(v) == "string" and v:match("^base") then
                hl[k] = colors[v] or "NONE"
            else
                hl[k] = v
            end
        end
        pcall(vim.api.nvim_set_hl, 0, group, hl)
    end

    for i, base in ipairs(term_colors) do
        if colors[base] then
            vim.g["terminal_color_" .. (i - 1)] = colors[base]
        end
    end
end

-- re-apply on ColorScheme (fires when vim.cmd("colorscheme ...") runs)
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        M.override()
    end,
})

-- watch dankcolors.lua and re-apply; defer so embedded watcher runs first
local uv = vim.uv or vim.loop
_G._dank_override_watcher = nil

local function start_watcher()
    if _G._dank_override_watcher then
        _G._dank_override_watcher:close()
    end
    local ok, w = pcall(uv.new_fs_event)
    if not ok then return end
    local ok_start = pcall(w.start, w, DANKCOLORS_FILE, {}, vim.schedule_wrap(function()
        vim.defer_fn(function()
            M.override()
        end, 50)
    end))
    if ok_start then
        _G._dank_override_watcher = w
    end
end

start_watcher()

-- retry watcher later if file didn't exist yet
if vim.fn.filereadable(DANKCOLORS_FILE) == 0 then
    vim.defer_fn(start_watcher, 2000)
end

M.override()

return M
