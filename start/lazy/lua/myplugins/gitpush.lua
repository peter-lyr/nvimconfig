local name = "gitpush"

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  event = { 'FocusLost' },
  keys = {
    '<leader>g1',
    '<leader>g2',
    '<leader>g3',
    '<leader>g4',
    '<leader>g5',
    '<leader>gI',
    '<leader>g<f1>',
  },
}
