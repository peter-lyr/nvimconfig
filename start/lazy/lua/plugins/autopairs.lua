return {
  'windwp/nvim-autopairs',
  lazy = true,
  event = { 'FocusLost', 'CursorMoved', },
  config = function()
    require('nvim-autopairs')
  end,
}
