return {
  'nvim-treesitter/nvim-treesitter',
  lazy = true,
  event = { 'FocusLost', 'CursorMoved', 'CursorMovedI', },
  keys = {
    'qi',
  },
  config = function()
    require('config.treesitter')
  end,
}
