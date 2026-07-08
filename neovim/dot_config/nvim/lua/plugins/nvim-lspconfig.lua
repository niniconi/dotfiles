local M = {}

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

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = {
      "rust_analyzer",
      "pyright",
      "clangd",
      "lua_ls",
      "bashls",
      "jdtls",
      "phpactor",
      "zls",
      "ts_ls",
      "asm_lsp",
      "sqls",
      "html",
      "cssls",
      "jsonls",
      "yamlls",
      "marksman",
    },
  })

  vim.lsp.enable("dartls")
end

return M
