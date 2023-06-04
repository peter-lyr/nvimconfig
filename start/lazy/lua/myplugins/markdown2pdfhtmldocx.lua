local name = "markdown2pdfhtmldocx"

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  keys = {
    '<F3>i',
    '<F3>o',
  },
  dependencies = {
    name = 'terminal',
    dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. 'terminal',
  },
}
