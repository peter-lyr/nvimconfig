local name = "bufferclean"

vim.keymap.set({ 'n', 'v' }, '<leader>hh', ':<c-u>BuffercleaN cur<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader><leader>hh', ':<c-u>BuffercleaN all<cr>', { silent = true })

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  event = { 'FocusLost' },
  cmd = { 'BuffercleaN' },
}
