vim.g.NERDSpaceDelims = 1
vim.g.NERDDefaultAlign = "left"
vim.g.NERDCommentEmptyLines = 1
vim.g.NERDTrimTrailingWhitespace = 1
vim.g.NERDToggleCheckAllLines = 1
vim.g.NERDAltDelims_c = 1

vim.keymap.set({ 'n', 'v' }, '<leader>cp', "vip:call nerdcommenter#Comment('x', 'toggle')<CR>",  { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>c}', "V}k:call nerdcommenter#Comment('x', 'toggle')<CR>",  { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>c{', "V{j:call nerdcommenter#Comment('x', 'toggle')<CR>",  { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>cG',  "VG:call nerdcommenter#Comment('x', 'toggle')<CR>",  { silent = true })
