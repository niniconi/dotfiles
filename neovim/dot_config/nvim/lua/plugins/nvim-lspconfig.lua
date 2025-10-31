local M = {}

function M.setup()
    require('mason').setup()
    require('mason-lspconfig').setup({
        ensure_installed = { 'rust_analyzer', 'pyright', 'clangd', 'lua_ls', 'bashls', 'jdtls', 'phpactor', 'zls', 'ts_ls', 'asm_lsp', 'sqls', 'html', 'cssls', 'jsonls', 'yamlls' },
    })

    local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
    for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
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

    vim.lsp.config('rust_analyzer', {
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
    vim.lsp.config('pyright', {})
    vim.lsp.config('clangd', {})
    vim.lsp.config('bashls', {})
    vim.lsp.config('jdtls', {})
    vim.lsp.config('phpactor', {})
    vim.lsp.config('zls', {})
    vim.lsp.config('ts_ls', {})
    vim.lsp.config('asm_lsp', {})
    vim.lsp.config('dartls', {
        cmd = { 'fvm', 'dart', 'language-server', '--protocol=lsp' }
    })
    vim.lsp.enable('dartls')

    vim.lsp.config('lua_ls', {
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

    vim.lsp.config('sqls', {})

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    vim.lsp.config('html', {
        capabilities = capabilities,
    })
    vim.lsp.config('cssls', {
        capabilities = capabilities,
    })
    vim.lsp.config('jsonls', {
        capabilities = capabilities,
    })
    vim.lsp.config('yamlls', {
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
