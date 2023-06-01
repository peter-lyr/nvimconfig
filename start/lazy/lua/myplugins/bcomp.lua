local name = "bcomp"

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  keys = {
    '<leader>b<f1>',
    '<leader>b<f2>',
    '<leader>b<f3>',
  },
}
