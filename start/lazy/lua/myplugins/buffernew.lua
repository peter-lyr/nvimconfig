local name = "buffernew"

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  keys = {
    '<leader>bg',
    '<leader>bi',
    '<leader>bk',
    '<leader>bj',
    '<leader>bh',
    '<leader>bl',

    '<leader>xc',
    '<leader><del>',

    '<leader>bn',
    '<leader>bm',
    '<leader>bo',
    '<leader>bp',

    '<leader>ba',
    '<leader>bb',
    '<leader>bc',
    '<leader>bd',
    '<leader>be',
    '<leader>bf',

    '<leader>xX',
    '<a-bs>',
    'ZX',
  },
  event = { 'FocusLost' },
}
