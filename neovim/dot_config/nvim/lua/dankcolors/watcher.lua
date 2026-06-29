local M = {}

local DANKCOLORS_FILE = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
local uv = vim.uv or vim.loop
M._watcher = nil

function M.start()
  if M._watcher then
    M._watcher:close()
    M._watcher = nil
  end

  local ok, w = pcall(uv.new_fs_event)
  if not ok then return end

  local ok_start = pcall(w.start, w, DANKCOLORS_FILE, {}, vim.schedule_wrap(function()
    vim.defer_fn(function()
      require("dankcolors").load()
    end, 50)
  end))

  if ok_start then
    M._watcher = w
  end
end

function M.stop()
  if M._watcher then
    M._watcher:close()
    M._watcher = nil
  end
end

return M
