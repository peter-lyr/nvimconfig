local name = "multilinesearch"

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  keys = {
    '<c-8>',
  },
}
