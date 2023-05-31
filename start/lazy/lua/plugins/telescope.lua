return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.1',
  lazy = true,
  event = { 'FocusLost', },
  keys = {
    '<a-/>',
    '<a-c>',
    '<a-C>',

    '<a-o>',
    '<a-k>',
    '<a-j>',
    '<a-J>',
    '<a-;>e',

    '<a-;>k',
    '<a-;>i',
    '<a-;>o',
    '<a-;>h',
    '<a-;>j',
    '<a-;>l',

    '<a-l>',
    '<a-L>',
    '<a-i>',

    '<a-b>',
    '<a-.>',

    '<a-q>',
    '<a-Q>',

    '<a-\'>a',
    '<a-\'>c',
    '<a-\'>d',
    '<a-\'>f',
    '<a-\'>h',
    '<a-\'>j',
    '<a-\'>m',
    '<a-\'>o',
    '<a-\'>p',
    '<a-\'>z',

    '<a-\\>',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    require('config.telescope')
  end,
}
