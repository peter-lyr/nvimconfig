return {
  'RRethy/nvim-base16',
  lazy = true,
  event = { 'FocusLost', 'CursorMoved', },
  keys = {
    '<leader>bw',
    '<leader>bW',
  },
  config = function()
    require('config.colorscheme')
  end,
}
