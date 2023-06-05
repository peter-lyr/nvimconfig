local name = "buffernew"

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  keys = {
    '<leader>bb',
    '<leader>bf',
    '<leader>b;',
    '<leader>bk',
    '<leader>bj',
    '<leader>bh',
    '<leader>bl',

    '<leader>bq',
    '<leader>bw',
    '<leader>ba',
    '<leader>bs',
    '<leader>bd',

    '<leader>bI',
    '<leader>bH',
    '<leader>bJ',
    '<leader>bK',
    '<leader>bL',

    '<leader>xc',
    '<leader>xt',
    '<leader><del>',
    '<a-bs>',

    'ZX',
  },
  event = { 'FocusLost' },
}
