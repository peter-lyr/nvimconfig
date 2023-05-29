return {
  'nvim-treesitter/nvim-treesitter',
  lazy = true,
  event = { 'FocusLost', 'CursorMoved', 'CursorMovedI', },
  dependencies = {
    'p00f/nvim-ts-rainbow',
  },
  keys = {
    'qi',
  },
  config = function()
    require('config.treesitter')
  end,
}
