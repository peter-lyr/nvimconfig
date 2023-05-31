local name = "terminal"

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  keys = {
    '\\q',
    '\\w',
    '\\e',
    '\\r',
  },
}
