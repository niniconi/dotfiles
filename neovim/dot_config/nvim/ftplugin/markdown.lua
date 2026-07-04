vim.opt_local.conceallevel = 3
vim.opt_local.concealcursor = 'nc'
vim.opt_local.spell = true
vim.opt_local.spelllang = 'en_us'
vim.opt_local.textwidth = 0
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.showbreak = '  '
vim.opt_local.foldmethod = 'expr'
vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt_local.foldtext = ''
vim.opt_local.formatoptions = vim.opt_local.formatoptions
    + 'a'  -- auto-wrap text
    - 't'  -- don't auto-wrap on insert
    + 'c'  -- auto-wrap comments with textwidth
    + 'r'  -- continue comment on Enter
    + 'o'  -- continue comment on o/O
    + 'n'  -- recognize numbered lists
    + 'j'  -- remove comment leader when joining
