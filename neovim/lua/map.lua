local map = vim.api.nvim_set_keymap
map('n','<C-x>',':NERDTreeFocus<CR>',{noremap = true})
map('n','<C-q>',':NERDTreeClose<CR>',{noremap = true})
map('n','T'    ,':FloatermNew<CR>'  ,{noremap = true})
