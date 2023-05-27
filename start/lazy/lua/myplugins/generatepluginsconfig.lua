local name = "generatepluginsconfig"

return {
  name = name,
  lazy = true,
  keys = {
    '<leader><leader><leader>z',
    '<leader><leader><leader>y',
  },
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name
}
