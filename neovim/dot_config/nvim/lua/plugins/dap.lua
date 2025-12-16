local M = {}

local rust = {}
local c = {}
local cpp = {}
local gdb = {
    type = 'executable',
    command = 'gdb',
    args = { '--interpreter=dap', '--eval-command', 'set print pretty on' }
}
local rust_gdb = {
    type = "executable",
    command = "rust-gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" }

}

function M.setup()
    local dap = require('dap')
    local dapui = require('dapui')
    local dap_virtaul_text = require('nvim-dap-virtual-text')

    dapui.setup()
    dap_virtaul_text.setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        show_stop_reason = true,
        commented = false,
    })

    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end

    dap.adapters["rust-gdb"] = rust_gdb
    dap.adapters["gdb"] = gdb
    dap.configurations.rust = rust.configuration()
    dap.configurations.c = c.configuration()
    dap.configurations.cpp = cpp.configuration()
end

function cpp.configuration()
    return c.configuration()
end

function c.configuration()
    return {
        {
            name = 'Launch',
            type = 'gdb',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopAtBeginningOfMainSubprogram = false,
        },
        {
            name = 'Select and attach to process',
            type = 'gdb',
            request = 'attach',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            pid = function()
                local name = vim.fn.input('Executable name (filter): ')
                return require('dap.utils').pick_process({ filter = name })
            end,
            cwd = '${workspaceFolder}'
        },
        {
            name = 'Attach to gdbserver :1234',
            type = 'gdb',
            request = 'attach',
            target = 'localhost:1234',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}'
        },
    }
end

function rust.configuration()
    return {
        {
            name = "Launch",
            type = "rust-gdb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            args = {}, -- provide arguments if needed
            cwd = "${workspaceFolder}",
            stopAtBeginningOfMainSubprogram = false,
        },
        {
            name = "Select and attach to process",
            type = "rust-gdb",
            request = "attach",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            pid = function()
                local name = vim.fn.input('Executable name (filter): ')
                return require("dap.utils").pick_process({ filter = name })
            end,
            cwd = "${workspaceFolder}"
        },
        {
            name = "Attach to gdbserver :1234",
            type = "rust-gdb",
            request = "attach",
            target = "localhost:1234",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}'
        }
    }
end

return M
