return {
  'lukas-reineke/indent-blankline.nvim',
  lazy = true,
  event = { 'FocusLost', 'CursorMoved', },
  config = function()
    require('config.blankline')
  end,
}
