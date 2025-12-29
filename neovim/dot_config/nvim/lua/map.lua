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
keyset('n', '<leader>n', ':NvimTreeOpen<CR>', opts.default("Open NvimTree"))
keyset('n', '<leader>q', ':NvimTreeClose<CR>', opts.default("Close NvimTree"))
keyset('n', '<leader>y', ':FloatermNew<CR>', opts.default("Open float terminal"))
keyset('n', '<leader>t', ':terminal<CR>', opts.default("Open terminal"))
keyset('n', '<leader>w', "<C-w>", opts.default("Split window mode"))
keyset('n', '<leader>fw', ":w<CR>", opts.default("Save file"))
keyset('n', '<leader>fq', ":q<CR>", opts.default("Quit"))
keyset('n', '<leader>h', "^", opts.default("Goto start of line"))
keyset('n', '<leader>l', "$", opts.default("Goto end of line"))

--
-- telescope's map conf
--
local telescope_builtin = require('telescope.builtin')
keyset('n', '<leader>ff', telescope_builtin.find_files, opts.default("Find files"))
keyset('n', '<leader>fg', telescope_builtin.live_grep, opts.default("Find content"))
keyset('n', '<leader>fb', telescope_builtin.buffers, opts.default("Find in buffers"))
keyset('n', '<leader>fh', telescope_builtin.help_tags, opts.default("Find neovim heap"))
keyset('n', '<leader>fc', telescope_builtin.commands, opts.default("Find commands"))
keyset('n', '<leader>fk', telescope_builtin.keymaps, opts.default("Find keymaps"))
keyset('n', '<leader>fgs', telescope_builtin.git_status, opts.default("Show git status"))

keyset('n', '<leader>fs', telescope_builtin.lsp_document_symbols,
    { desc = "Lists LSP document symbols in the current buffer" })
keyset('n', '<leader>fS', telescope_builtin.lsp_dynamic_workspace_symbols,
    { desc = "Dynamically lists LSP for all workspace symbols" })

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


keyset('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts.default("Goto to declaration"))
keyset('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts.default("Goto to definition"))
keyset('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts.default())
keyset('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts.default())
keyset('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts.default())
keyset('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts.default())
keyset('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts.default())
keyset('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts.default())
keyset('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts.default())
keyset('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts.default())
keyset('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts.default())
keyset('n', '<leader>vd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts.default())
keyset('n', '<leader>vD', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts.default())
keyset('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts.default())
keyset('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts.default())
keyset('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts.default())
keyset('n', '<leader>ty', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts.default())

local crates = require("crates")

keyset("n", "<leader>ct", crates.toggle, opts.default())
keyset("n", "<leader>cr", crates.reload, opts.default())

keyset("n", "<leader>cv", crates.show_versions_popup, opts.default())
keyset("n", "<leader>cf", crates.show_features_popup, opts.default())
keyset("n", "<leader>cd", crates.show_dependencies_popup, opts.default())

keyset("n", "<leader>cu", crates.update_crate, opts.default())
keyset("v", "<leader>cu", crates.update_crates, opts.default())
keyset("n", "<leader>cac", crates.update_all_crates, opts.default())
keyset("n", "<leader>cU", crates.upgrade_crate, opts.default())
keyset("v", "<leader>cU", crates.upgrade_crates, opts.default())
keyset("n", "<leader>cA", crates.upgrade_all_crates, opts.default())

keyset("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, opts.default())
keyset("n", "<leader>cX", crates.extract_crate_into_table, opts.default())

keyset("n", "<leader>cH", crates.open_homepage, opts.default())
keyset("n", "<leader>cR", crates.open_repository, opts.default())
keyset("n", "<leader>cD", crates.open_documentation, opts.default())
keyset("n", "<leader>cC", crates.open_crates_io, opts.default())
keyset("n", "<leader>cL", crates.open_lib_rs, opts.default())
