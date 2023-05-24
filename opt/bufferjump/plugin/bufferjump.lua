vim.keymap.set({ 'n', 'v' }, '<leader>p', '<c-w>p', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>w', ':<c-u>call bufferjump#up(1)<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>s', ':<c-u>call bufferjump#down(1)<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>a', ':<c-u>call bufferjump#left(1)<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>d', ':<c-u>call bufferjump#right(1)<cr>', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>o', ':<c-u>call bufferjump#maxheight()<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>i', ':<c-u>call bufferjump#samewidthheight()<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>u', ':<c-u>call bufferjump#maxwidth()<cr>', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader><leader>o', ':<c-u>call bufferjump#miximize(1)<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader><leader>i', ':<c-u>call bufferjump#miximize(0)<cr>', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader><leader><leader>i', ':<c-u>call bufferjump#samewidthheightfix()<cr>', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader><leader>w', ':<c-u>call bufferjump#winfixheight()<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader><leader>s', ':<c-u>call bufferjump#nowinfixheight()<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader><leader>d', ':<c-u>call bufferjump#winfixwidth()<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader><leader>a', ':<c-u>call bufferjump#nowinfixwidth()<cr>', { silent = true })
