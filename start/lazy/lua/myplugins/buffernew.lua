local name = "buffernew"

vim.keymap.set({ 'n', 'v' }, '<leader>bg', ':<c-u>BufferneW copy_fpath<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>bi', ':<c-u>BufferneW here<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>bk', ':<c-u>BufferneW up<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>bj', ':<c-u>BufferneW down<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>bh', ':<c-u>BufferneW left<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>bl', ':<c-u>BufferneW right<cr>', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>xc', ':<c-u>BufferneW copy_fpath_silent<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader><del>', ':<c-u>BufferneW bwunlisted<cr>', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>bn', ':<c-u>leftabove split<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>bm', ':<c-u>leftabove new<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>bo', ':<c-u>leftabove vsplit<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>bp', ':<c-u>leftabove vnew<cr>', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>ba', ':<c-u>split<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>bb', ':<c-u>new<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>bc', ':<c-u>vsplit<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>bd', ':<c-u>vnew<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>be', '<c-w>s<c-w>t', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>bf', ':<c-u>tabnew<cr>', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>xX', ':<c-u>tabclose<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-bs>', ':<c-u>bw!<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'ZX', ':<c-u>qa!<cr>', { silent = true })

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  event = { 'FocusLost' },
  cmd = { 'BufferneW' },
}
