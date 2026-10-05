-- leader key is Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keyset = vim.keymap.set
local opts = {}

function opts.default(desc)
  if desc ~= nil then
    return { desc = desc, noremap = true, silent = true }
  else
    return { noremap = true, silent = true }
  end
end

--
-- some basic keymap conf
--
keyset("n", "<leader>n", "<Cmd>Neotree filesystem reveal left<CR>", opts.default("Toggle file tree"))
keyset("n", "<leader>q", "<Cmd>Neotree close<CR>", opts.default("Close file tree"))
keyset("n", "<leader>st", function()
  require("dankcolors").load()
  vim.notify("DankColors reloaded")
end, opts.default("Reload DankColors"))
keyset("n", "<leader>y", function()
  Snacks.terminal.toggle()
end, opts.default("Toggle terminal"))
keyset("n", "<leader>t", ":terminal<CR>", opts.default("Open terminal"))
keyset("n", "<leader>w", "<C-w>", opts.default("Window commands"))
keyset("n", "<leader>fw", ":w<CR>", opts.default("Save file"))
keyset("n", "<leader>fq", ":q<CR>", opts.default("Quit"))
keyset("n", "<leader>h", "^", opts.default("Goto start of line"))
keyset("n", "<leader>l", "$", opts.default("Goto end of line"))

--
-- telescope's map conf
--
local telescope_builtin = require("telescope.builtin")
keyset("n", "<leader>ff", telescope_builtin.find_files, opts.default("Find files"))
keyset("n", "<leader>fg", telescope_builtin.live_grep, opts.default("Find content"))
keyset("n", "<leader>fb", telescope_builtin.buffers, opts.default("Find in buffers"))
keyset("n", "<leader>fh", telescope_builtin.help_tags, opts.default("Find help tags"))
keyset("n", "<leader>fc", telescope_builtin.commands, opts.default("Find commands"))
keyset("n", "<leader>fk", telescope_builtin.keymaps, opts.default("Find keymaps"))
keyset("n", "<leader>fgs", telescope_builtin.git_status, opts.default("Show git status"))

keyset("n", "<leader>fs", telescope_builtin.lsp_document_symbols, opts.default("LSP symbols"))
keyset("n", "<leader>fS", telescope_builtin.lsp_dynamic_workspace_symbols, opts.default("LSP workspace symbols"))

--
-- nvim-dap's map conf
--
keyset("n", "<F5>", ':lua require("dap").continue()<CR>', opts.default("Continue"))
keyset("n", "<F10>", ':lua require("dap").step_over()<CR>', opts.default("Step over"))
keyset("n", "<F11>", ':lua require("dap").step_into()<CR>', opts.default("Step into"))
keyset("n", "<F12>", ':lua require("dap").step_out()<CR>', opts.default("Step out"))
keyset("n", "<leader>b", ':lua require("dap").toggle_breakpoint()<CR>', opts.default("Toggle breakpoint"))
keyset(
  "n",
  "<leader>B",
  ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
  opts.default("Conditional breakpoint")
)
keyset(
  "n",
  "<leader>lp",
  ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
  opts.default("Log point")
)
keyset("n", "<leader>dr", ':lua require("dap").repl.open()<CR>', opts.default("Toggle REPL"))
keyset("n", "<leader>dl", ':lua require("dap").run_last()<CR>', opts.default("Run last"))

keyset("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts.default("Go to declaration"))
keyset("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts.default("Go to definition"))
keyset("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts.default("Hover"))
keyset("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts.default("Implementations"))
keyset("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts.default("Signature help"))
keyset("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts.default("Rename"))
keyset("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts.default("Code action"))
keyset("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts.default("References"))
keyset("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts.default("Format buffer"))
keyset("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts.default("Prev diagnostic"))
keyset("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts.default("Next diagnostic"))
keyset("n", "<leader>vd", "<cmd>lua vim.diagnostic.open_float()<CR>", opts.default("Diagnostic float"))
keyset("n", "<leader>vD", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts.default("Diagnostic loclist"))
keyset("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts.default("Add workspace"))
keyset("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts.default("Remove workspace"))
keyset(
  "n",
  "<leader>wl",
  "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
  opts.default("List workspaces")
)
keyset("n", "<leader>ty", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts.default("Type definition"))

keyset("n", "<leader>tr", ':lua require("neotest").run.run()<CR>', { desc = "Run Nearest" })
keyset("n", "<leader>tf", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', { desc = "Run File" })
keyset("n", "<leader>ts", ':lua require("neotest").summary.toggle()<CR>', { desc = "Toggle Summary" })
keyset("n", "<leader>to", ':lua require("neotest").output_panel.toggle()<CR>', { desc = "Toggle Output Panel" })

local crates = require("crates")

keyset("n", "<leader>ct", crates.toggle, opts.default("Toggle crates"))
keyset("n", "<leader>cr", crates.reload, opts.default("Reload crates"))

keyset("n", "<leader>cv", crates.show_versions_popup, opts.default("Show versions"))
keyset("n", "<leader>cf", crates.show_features_popup, opts.default("Show features"))
keyset("n", "<leader>cd", crates.show_dependencies_popup, opts.default("Show dependencies"))

keyset("n", "<leader>cu", crates.update_crate, opts.default("Update crate"))
keyset("v", "<leader>cu", crates.update_crates, opts.default("Update crates"))
keyset("n", "<leader>cac", crates.update_all_crates, opts.default("Update all crates"))
keyset("n", "<leader>cU", crates.upgrade_crate, opts.default("Upgrade crate"))
keyset("v", "<leader>cU", crates.upgrade_crates, opts.default("Upgrade crates"))
keyset("n", "<leader>cA", crates.upgrade_all_crates, opts.default("Upgrade all crates"))

keyset("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, opts.default("Expand crate"))
keyset("n", "<leader>cX", crates.extract_crate_into_table, opts.default("Extract crate"))

keyset("n", "<leader>cH", crates.open_homepage, opts.default("Open homepage"))
keyset("n", "<leader>cR", crates.open_repository, opts.default("Open repository"))
keyset("n", "<leader>cD", crates.open_documentation, opts.default("Open docs"))
keyset("n", "<leader>cC", crates.open_crates_io, opts.default("Open crates.io"))
keyset("n", "<leader>cL", crates.open_lib_rs, opts.default("Open lib.rs"))

--
-- gitsigns keymaps
--
keyset("n", "]c", function()
  if vim.wo.diff then
    return vim.cmd.normal({ "]c", bang = true })
  end
  require("gitsigns").nav_hunk("next")
end, opts.default("Next hunk"))

keyset("n", "[c", function()
  if vim.wo.diff then
    return vim.cmd.normal({ "[c", bang = true })
  end
  require("gitsigns").nav_hunk("prev")
end, opts.default("Prev hunk"))

keyset("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", opts.default("Stage hunk"))
keyset("v", "<leader>hs", ":Gitsigns stage_hunk<CR>", opts.default("Stage hunk visual"))
keyset("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", opts.default("Reset hunk"))
keyset("v", "<leader>hr", ":Gitsigns reset_hunk<CR>", opts.default("Reset hunk visual"))
keyset("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", opts.default("Preview hunk"))
keyset("n", "<leader>hb", ":Gitsigns blame_line<CR>", opts.default("Blame line"))
keyset("n", "<leader>hB", ":Gitsigns blame<CR>", opts.default("Blame full screen"))
keyset("n", "<leader>hd", ":Gitsigns diffthis<CR>", opts.default("Diff against index"))
keyset("n", "<leader>hS", ":Gitsigns stage_buffer<CR>", opts.default("Stage buffer"))
keyset("n", "<leader>hR", ":Gitsigns reset_buffer<CR>", opts.default("Reset buffer"))
keyset("n", "<leader>hi", ":Gitsigns preview_hunk_inline<CR>", opts.default("Preview hunk inline"))
keyset("n", "<leader>hq", ":Gitsigns setqflist<CR>", opts.default("Hunks to quickfix"))
keyset("n", "<leader>tb", ":Gitsigns toggle_current_line_blame<CR>", opts.default("Toggle blame"))
keyset("n", "<leader>tw", ":Gitsigns toggle_word_diff<CR>", opts.default("Toggle word diff"))
keyset("n", "<leader>tn", ":Gitsigns toggle_numhl<CR>", opts.default("Toggle num highlight"))
keyset("n", "<leader>tl", ":Gitsigns toggle_linehl<CR>", opts.default("Toggle line highlight"))
