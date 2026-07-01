local M = {}

function M.setup()
  local wk = require("which-key")

  wk.setup({
    delay = 500,
    icons = { mappings = false },
  })

  wk.add({
    { "<leader>b", group = "Breakpoint" },
    { "<leader>c", group = "Cargo" },
    { "<leader>d", group = "Debug" },
    { "<leader>f", group = "Find" },
    { "<leader>h", group = "Git Hunk" },
    { "<leader>n", group = "Neo-tree" },
    { "<leader>t", group = "Terminal" },
    { "<leader>v", group = "Diagnostic" },
    { "<leader>w", group = "Window" },
  })
end

return M
