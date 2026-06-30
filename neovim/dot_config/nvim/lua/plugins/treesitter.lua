local M = {}

local langs = {
    -- Backend
    'rust', 'python', 'go', 'java', 'c_sharp', 'cpp',
    'ruby', 'php', 'scala', 'haskell', 'zig', 'ocaml',
    'elixir', 'erlang', 'gleam', 'nim', 'v',
    -- Dart + mobile
    'dart', 'kotlin', 'swift',
    -- Frontend
    'javascript', 'typescript', 'tsx', 'css', 'scss', 'html',
    'svelte', 'vue', 'astro', 'graphql', 'pug',
    -- Data / Config
    'json', 'yaml', 'toml', 'xml', 'dockerfile', 'ini',
    'make', 'cmake', 'hcl', 'proto', 'nix', 'bicep', 'cue',
    'json5', 'kdl', 'ron',
    -- Scripting
    'bash', 'fish', 'lua',
    'clojure', 'fennel', 'racket', 'scheme', 'perl',
    'tcl', 'purescript', 'rescript',
    -- Database
    'sql', 'prql', 'kusto', 'promql',
    -- Documentation
    'latex', 'bibtex', 'rst', 'djot',
    -- DevOps / Build
    'terraform', 'jsonnet', 'puppet', 'meson', 'ninja', 'helm',
    -- Git
    'gitcommit', 'gitignore', 'git_config', 'git_rebase', 'gitattributes',
    'diff', 'regex', 'comment',
    -- Game / Shaders
    'gdscript', 'glsl', 'hlsl', 'wgsl',
    -- Security / Hardware
    'rego', 'vhdl', 'asm', 'cuda',
    -- Utils
    'just', 'hurl', 'jq', 'templ', 'typst',
}

function M.setup()
    require('nvim-treesitter').setup({})

    require('nvim-treesitter').install(langs)

    vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
            local ignore = {
                "help", "dashboard", "neo-tree", "lazy",
                "TelescopePrompt", "NvimTree", "qf", "notify",
            }
            if vim.tbl_contains(ignore, args.data) then
                return
            end
            pcall(vim.treesitter.start, args.buf)
            local ft = vim.bo[args.buf].filetype
            if vim.tbl_contains(langs, ft) then
                pcall(require('nvim-treesitter').install, { ft })
            end
        end,
        desc = "Enable treesitter highlighting and auto-install parsers",
    })
end

return M
