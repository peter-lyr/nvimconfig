return {
  'nvim-treesitter/nvim-treesitter',
  lazy = true,
  event = { 'FocusLost', 'CursorMoved', },
  keys = {
    'qi',
  },
  config = function()
    require('config.treesitter')
  end,
}
