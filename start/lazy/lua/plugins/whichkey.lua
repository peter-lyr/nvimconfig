return {
  'folke/which-key.nvim',
  lazy = true,
  event = { 'FocusLost', 'CursorMoved', },
  config = function()
    require('which-key').setup()
  end,
}
