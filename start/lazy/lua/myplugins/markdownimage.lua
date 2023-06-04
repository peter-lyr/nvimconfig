local name = "markdownimage"

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  keys = {
    '<f3>p',
    '<f3>j',
    '<f3>u',
  },
  dependencies = {
    {
      name = 'terminal',
      dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. 'terminal',
    },
    {
      name = 'sha2',
      dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. 'sha2',
    },
  },
}
