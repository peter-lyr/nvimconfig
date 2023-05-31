return {
  'nvim-treesitter/nvim-treesitter',
  lazy = true,
  event = { 'FocusLost', 'CursorMoved', 'CursorMovedI', },
  dependencies = {
    'p00f/nvim-ts-rainbow',
    'nvim-treesitter/nvim-treesitter-context',
  },
  keys = {
    'qi',
  },
  config = function()
    require('config.treesitter')
  end,
}
