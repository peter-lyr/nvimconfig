local name = "markdownblock"

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  keys = {
    'yib',
    'vib',
    'dib',
    'cib',

    'yab',
    'vab',
    'dab',
    'cab',
  },
}
