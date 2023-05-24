local name = "bufferjump"

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  event = { 'FocusLost' },
  keys = {
    '<leader>p',
    '<leader>w', '<leader>s', '<leader>a', '<leader>d',
    '<leader>o', '<leader>i', '<leader>u',
    '<leader><leader>o', '<leader><leader>i',
    '<leader><leader><leader>i',
    '<leader><leader>w', '<leader><leader>s', '<leader><leader>d', '<leader><leader>a',
  }
}
