-- leader key is Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keyset = vim.keymap.set

--
-- some basic keymap conf
--
local opts = { noremap = true, silent = true }
keyset('n', '<leader>n', ':NvimTreeOpen<CR>', opts)
keyset('n', '<leader>q', ':NvimTreeClose<CR>', opts)
keyset('n', '<leader>y', ':FloatermNew<CR>', opts)
keyset('n', '<leader>t', ':terminal<CR>', opts)
keyset('n', '<leader>w', "<C-w>", opts)
keyset('n', '<leader>fw', ":w<CR>", opts)
keyset('n', '<leader>fq', ":q<CR>", opts)
keyset('n', '<leader>h', "^", opts)
keyset('n', '<leader>l', "$", opts)

--
-- telescope's map conf
--
local telescope_builtin = require('telescope.builtin')
keyset('n', '<leader>ff', telescope_builtin.find_files, {})
keyset('n', '<leader>fg', telescope_builtin.live_grep, {})
keyset('n', '<leader>fb', telescope_builtin.buffers, {})
keyset('n', '<leader>fh', telescope_builtin.help_tags, {})

--
-- nvim-dap's map conf
--
keyset('n', '<F5>', ':lua require("dap").continue()<CR>')
keyset('n', '<F10>', ':lua require("dap").step_over()<CR>')
keyset('n', '<F11>', ':lua require("dap").step_into()<CR>')
keyset('n', '<F12>', ':lua require("dap").step_out()<CR>')
keyset('n', '<leader>b', ':lua require("dap").toggle_breakpoint()<CR>')
keyset('n', '<leader>B', ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')
keyset('n', '<leader>lp', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>')
keyset('n', '<leader>dr', ':lua require("dap").repl.open()<CR>')
keyset('n', '<leader>dl', ':lua require("dap").run_last()<CR>')


keyset('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
keyset('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
keyset('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
keyset('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
keyset('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
keyset('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
keyset('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
keyset('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
keyset('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
keyset('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
keyset('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
keyset('n', '<leader>vd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
keyset('n', '<leader>vD', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
keyset('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
keyset('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
keyset('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
keyset('n', '<leader>ty', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

local crates = require("crates")
opts = { silent = true }

keyset("n", "<leader>ct", crates.toggle, opts)
keyset("n", "<leader>cr", crates.reload, opts)

keyset("n", "<leader>cv", crates.show_versions_popup, opts)
keyset("n", "<leader>cf", crates.show_features_popup, opts)
keyset("n", "<leader>cd", crates.show_dependencies_popup, opts)

keyset("n", "<leader>cu", crates.update_crate, opts)
keyset("v", "<leader>cu", crates.update_crates, opts)
keyset("n", "<leader>ca", crates.update_all_crates, opts)
keyset("n", "<leader>cU", crates.upgrade_crate, opts)
keyset("v", "<leader>cU", crates.upgrade_crates, opts)
keyset("n", "<leader>cA", crates.upgrade_all_crates, opts)

keyset("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, opts)
keyset("n", "<leader>cX", crates.extract_crate_into_table, opts)

keyset("n", "<leader>cH", crates.open_homepage, opts)
keyset("n", "<leader>cR", crates.open_repository, opts)
keyset("n", "<leader>cD", crates.open_documentation, opts)
keyset("n", "<leader>cC", crates.open_crates_io, opts)
keyset("n", "<leader>cL", crates.open_lib_rs, opts)
