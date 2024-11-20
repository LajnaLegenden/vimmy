vim.keymap.set('n', '<leader>fg', ':FzfLua live_grep_native<CR>')
vim.keymap.set('n', '<leader>ff', ':FzfLua files<CR>')
vim.keymap.set('n', '<leader><leader>', ':FzfLua files<CR>')
vim.keymap.set('n', '<C-p>', ':FzfLua buffers<CR>')

vim.keymap.set('n', '<leader>e', ':Telescope file_browser<CR>')

-- Internal Bindings
vim.keymap.set('n', '-', ':normal ddp<CR>') -- Move line in normal mode (down)
vim.keymap.set('n', '_', '@=\'kddpk\'<CR>') -- Move line in normal mode (up)
vim.keymap.set("v", "-", ":m '>+1<CR>gv=gv") -- Move block in visual mode (down)
vim.keymap.set("v", "_", ":m '<-2<CR>gv=gv") -- Move block in visual mode (up)

-- Search for the current variable name
vim.api.nvim_set_keymap('n', '<leader>d', ':lua require"config.custom".search_with_word()<CR>>', { noremap = true, silent = true })

-- Grep search for the current variable name
vim.api.nvim_set_keymap('n', '<leader>s', ':lua require"config.custom".grep_search_with_word()<CR>>', { noremap = true, silent = true })

