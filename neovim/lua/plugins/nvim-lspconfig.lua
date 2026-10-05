local M = {}

local servers = {
  "asm_lsp",
  "bashls",
  "clangd",
  "cssls",
  "dartls",
  "html",
  "jdtls",
  "jsonls",
  "lua_ls",
  "marksman",
  "nixd",
  "phpactor",
  "pyright",
  "rust_analyzer",
  "sqls",
  "ts_ls",
  "yamlls",
  "zls",
}

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
    require("nvim-navbuddy").attach(client, bufnr)
  end
end

function M.setup()
  vim.diagnostic.config({
    virtual_text = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = " ",
        [vim.diagnostic.severity.INFO] = " ",
      },
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      source = true,
      focusable = true,
      border = "rounded",
    },
  })

  vim.lsp.inlay_hint.enable(true)

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  vim.lsp.config("*", {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- servers come from nixpkgs (hosts/common/packages/dev/lsp.nix), configs in
  -- lua/lsp/<server>.lua
  for _, server in ipairs(servers) do
    vim.lsp.config(server, require("lsp." .. server))
    vim.lsp.enable(server)
  end
end

return M
