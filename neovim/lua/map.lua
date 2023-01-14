-- leader key 为空
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local opt = {
  noremap = true,
  silent = true,
}
local pluginKeys = {}
local map = vim.api.nvim_set_keymap
map('n','<C-x>',':NERDTreeFocus<CR>',opt)
map('n','<C-q>',':NERDTreeClose<CR>',opt)
map('n','T'    ,':FloatermNew<CR>'  ,opt)

--
-- here is coc's map conf
--

pluginKeys.maplsp = function(mapbuf)
    -- -- rename
    -- mapbuf('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opt)
    -- -- code action
    -- mapbuf('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opt)
    -- -- go xx
    -- mapbuf('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
    -- mapbuf('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
    -- mapbuf('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
    -- mapbuf('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
    -- mapbuf('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opt)
    -- -- diagnostic
    -- mapbuf('n', 'go', '<cmd>lua vim.diagnostic.open_float()<CR>', opt)
    -- mapbuf('n', 'gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opt)
    -- mapbuf('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opt)
    -- -- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
    -- -- leader + =
    -- mapbuf('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opt)
    -- -- mapbuf('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opt)
    -- -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
    -- -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
    -- -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
    -- -- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end

return pluginKeys
