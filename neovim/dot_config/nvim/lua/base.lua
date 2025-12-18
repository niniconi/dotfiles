vim.g.encoding = "utf-8"
vim.o.syntax = "enable"
vim.o.relativenumber = true
vim.o.number = true
vim.o.cursorline = true
vim.o.wrap = true
vim.o.ruler = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.smartcase = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true

vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4

vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

vim.o.smartindent = true
vim.o.history = 1000
vim.o.list = true
vim.o.termguicolors = true
vim.opt.termguicolors = true

vim.opt.clipboard = "unnamedplus"

vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
