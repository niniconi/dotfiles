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

  vim.lsp.config("rust_analyzer", {
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          buildScripts = {
            nJobs = 4,
          },
        },
        analysis = {
          nJobs = 4,
        },
        procMacro = {
          server = {
            numThreads = 4,
          },
        },
      },
    },
  })

  vim.lsp.config("dartls", {
    cmd = { "fvm", "dart", "language-server", "--protocol=lsp" },
  })
  vim.lsp.enable("dartls")

  vim.lsp.config("lua_ls", {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
          path ~= vim.fn.stdpath("config")
          and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
        then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = {
          version = "LuaJIT",
          path = {
            "lua/?.lua",
            "lua/?/init.lua",
          },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
          },
        },
      })
    end,
    settings = {
      Lua = {},
    },
  })

  vim.lsp.config("yamlls", {
    settings = {
      yaml = {
        schemas = {
          ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/v1.32.1-standalone-strict/all.json"] = "/*.k8s.yaml",
        },
      },
    },
  })
end

return M
