local name = "bufferclean"

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  event = { 'FocusLost' },
  keys = {
    '<leader>hh',
    '<leader><leader>hh',
  },
}
