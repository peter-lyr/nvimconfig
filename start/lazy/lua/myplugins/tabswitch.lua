local name = "tabswitch"

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  event = { 'FocusLost', 'TabNew', },
  keys = {
    '<leader><f1>',
    '<leader><f2>',
    '<leader><f3>',
    '<leader><f4>',
    '<leader><f5>',
    '<leader><f6>',
    '<leader><f7>',
    '<leader><f8>',
    '<leader><f9>',
    '<leader><f10>',
    '<leader><f11>',
    '<leader><f12>',

    '<leader><cr>',

    '<cr>',
    '<s-cr>',

    '<c-s-h>',
    '<c-s-l>',
  }
}
