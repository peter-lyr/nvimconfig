return {
  'stevearc/aerial.nvim',
  lazy = true,
  event = { 'FocusLost', 'CursorMoved', },
  keys = {
    '<leader>',
    ']a',
    '[a',
  },
  config = function()
    require('config.aerial')
  end,
}
