local M = {}

function M.setup()
  require('snacks').setup({
    image = {
      formats = {
        'png', 'jpg', 'jpeg', 'gif', 'bmp', 'webp', 'tiff', 'heic', 'avif',
        'mp4', 'mov', 'avi', 'mkv', 'webm', 'pdf',
      },
      force = false,
      doc = {
        enabled = true,
        inline = true,
        float = true,
        max_width = 80,
        max_height = 40,
        conceal = function(lang, type)
          return type == 'math'
        end,
      },
      img_dirs = { 'img', 'images', 'assets', 'static', 'public', 'media', 'attachments' },
      wo = {
        wrap = false, number = false, relativenumber = false,
        cursorcolumn = false, signcolumn = 'no', foldcolumn = '0',
        list = false, spell = false, statuscolumn = '',
      },
      cache = vim.fn.stdpath('cache') .. '/snacks/image',
      debug = { request = false, convert = false, placement = false },
      env = {},
      icons = { math = '󰪚 ', chart = '󰄧 ', image = ' ' },
      convert = {
        notify = true,
        mermaid = function()
          local theme = vim.o.background == 'light' and 'neutral' or 'dark'
          return { '-i', '{src}', '-o', '{file}', '-b', 'transparent', '-t', theme, '-s', '{scale}' }
        end,
        magick = {
          default = { '{src}[0]', '-scale', '1920x1080>' },
          vector = { '-density', 192, '{src}[0]' },
          math = { '-density', 192, '{src}[0]', '-trim' },
          pdf = { '-density', 192, '{src}[0]', '-background', 'white', '-alpha', 'remove', '-trim' },
        },
      },
      math = {
        enabled = true,
        typst = {
          tpl = [[
#set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
#show math.equation.where(block: false): set text(top-edge: 'bounds', bottom-edge: 'bounds')
#set text(size: 12pt, fill: rgb('${color}'))
${header}
${content}]],
        },
        latex = {
          font_size = 'Large',
          packages = { 'amsmath', 'amssymb', 'amsfonts', 'amscd', 'mathtools' },
          tpl = [[
\documentclass[preview,border=0pt,varwidth,12pt]{standalone}
\usepackage{${packages}}
\begin{document}
${header}
{ \${font_size} \selectfont
\color[HTML]{${color}}
${content}}
\end{document}]],
        },
      },
    },
    dashboard = {
      enabled = true,
      width = 80,
      pane_gap = 4,
      preset = {
        header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║   ██║██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║╚██████╔╝██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝ ╚═════╝ ╚═╝╚═╝     ╚═╝]],
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.picker.files({cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        function()
          local in_git = Snacks.git.get_root() ~= nil
          local has_git = vim.fn.executable("git") == 1
          local has_gh = vim.fn.executable("gh") == 1
          if not in_git or not has_git or not has_gh then
            return {}
          end
          local has_gh_notify = false
          local ext = vim.fn.system("gh extension list 2>/dev/null")
          has_gh_notify = ext and ext:find("gh%-notify") ~= nil
          local cmds = {}
          if has_gh_notify then
            table.insert(cmds, {
              title = "Notifications",
              cmd = "gh notify -s -a -n5",
              action = function()
                vim.ui.open("https://github.com/notifications")
              end,
              key = "n",
              icon = " ",
              height = 5,
            })
          end
          table.insert(cmds, {
            title = "Open Issues",
            cmd = "gh issue list -L 3",
            key = "i",
            action = function()
              vim.fn.jobstart("gh issue list --web", { detach = true })
            end,
            icon = " ",
            height = 7,
          })
          table.insert(cmds, {
            icon = " ",
            title = "Open PRs",
            cmd = "gh pr list -L 3",
            key = "P",
            action = function()
              vim.fn.jobstart("gh pr list --web", { detach = true })
            end,
            height = 7,
          })
          table.insert(cmds, {
            icon = " ",
            title = "Actions",
            cmd = "gh run list -L 5",
            key = "a",
            action = function()
              vim.fn.jobstart("gh run list --web", { detach = true })
            end,
            height = 8,
          })
          table.insert(cmds, {
            icon = " ",
            title = "Git Status",
            cmd = "git --no-pager diff --stat -B -M -C",
            height = 10,
          })
          return vim.tbl_map(function(cmd)
            return vim.tbl_extend("force", {
              pane = 2,
              section = "terminal",
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            }, cmd)
          end, cmds)
        end,
        { section = "startup" },
      },
    },
  })
end

return M
