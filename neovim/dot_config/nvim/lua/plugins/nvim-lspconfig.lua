local M = {}

local on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
        require('nvim-navbuddy').attach(client, bufnr)
    end
end


function M.setup()
    require('mason').setup()
    require('mason-lspconfig').setup({
        ensure_installed = { 'rust_analyzer', 'pyright', 'clangd', 'lua_ls', 'bashls', 'jdtls', 'phpactor', 'zls', 'ts_ls', 'asm_lsp', 'sqls', 'html', 'cssls', 'jsonls', 'yamlls' },
    })

    vim.diagnostic.config({
        virtual_text = true,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = ' ',
                [vim.diagnostic.severity.WARN]  = ' ',
                [vim.diagnostic.severity.HINT]  = ' ',
                [vim.diagnostic.severity.INFO]  = ' ',
            }
        },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            source = true,
            focusable = true,
            border = 'rounded',
        },
    })

    vim.lsp.inlay_hint.enable(true)

    local default_lsp_config = {
        on_attach = on_attach
    }

    vim.lsp.config('rust_analyzer', {
        on_attach = on_attach,
        settings = {
            ['rust-analyzer'] = {
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
                    }
                }
            },
        },
    })
    vim.lsp.config('pyright', default_lsp_config)
    vim.lsp.config('clangd', {
        on_attach = on_attach,
        init_options = {
            fallbackFlags = { "-std=c++23" },
        },
    })
    vim.lsp.config('bashls', default_lsp_config)
    vim.lsp.config('jdtls', default_lsp_config)
    vim.lsp.config('phpactor', default_lsp_config)
    vim.lsp.config('zls', default_lsp_config)
    vim.lsp.config('ts_ls', default_lsp_config)
    vim.lsp.config('asm_lsp', default_lsp_config)
    vim.lsp.config('dartls', {
        on_attach = on_attach,
        cmd = { 'fvm', 'dart', 'language-server', '--protocol=lsp' }
    })
    vim.lsp.enable('dartls')

    vim.lsp.config('lua_ls', {
        on_attach = on_attach,
        on_init = function(client)
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if
                    path ~= vim.fn.stdpath('config')
                    and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                then
                    return
                end
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most
                    -- likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Tell the language server how to find Lua modules same way as Neovim
                    -- (see `:h lua-module-load`)
                    path = {
                        'lua/?.lua',
                        'lua/?/init.lua',
                    },
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME
                        -- Depending on the usage, you might want to add additional paths
                        -- here.
                        -- '${3rd}/luv/library'
                        -- '${3rd}/busted/library'
                    }
                    -- Or pull in all of 'runtimepath'.
                    -- NOTE: this is a lot slower and will cause issues when working on
                    -- your own configuration.
                    -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                    -- library = {
                    --   vim.api.nvim_get_runtime_file('', true),
                    -- }
                }
            })
        end,
        settings = {
            Lua = {}
        }
    })

    vim.lsp.config('sqls', default_lsp_config)

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    vim.lsp.config('html', {
        on_attach = on_attach,
        capabilities = capabilities,
    })
    vim.lsp.config('cssls', {
        on_attach = on_attach,
        capabilities = capabilities,
    })
    vim.lsp.config('jsonls', {
        on_attach = on_attach,
        capabilities = capabilities,
    })
    vim.lsp.config('yamlls', {
        on_attach = on_attach,
        settings = {
            yaml = {
                schemas = {
                    ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/v1.32.1-standalone-strict/all.json"] =
                    "/*.k8s.yaml",
                },
            },
        }
    })
end

return M
