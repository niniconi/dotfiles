local M = {}

function M.setup()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.opt.termguicolors = true

    require("neo-tree").setup({
        close_if_last_window = true,
        sort_case_insensitive = true,
        enable_git_status = true,
        enable_diagnostics = true,
        follow_current_file = {
            enabled = true,
        },
        use_libuv_file_watcher = true,
        source_selector = {
            winbar = true,
            statusline = false,
        },
        filesystem = {
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = false,
            },
            group_empty_dirs = true,
        },
    })
end

return M
