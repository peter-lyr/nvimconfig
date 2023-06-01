local name = "fontsize"

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  keys = {
    '<C-ScrollWheelDown>',
    '<C-ScrollWheelUp>',
    '<C-MiddleMouse>',

    '<c-9>',
    '<c-->',
    '<c-0>',
    '<c-=>',
  },
}
