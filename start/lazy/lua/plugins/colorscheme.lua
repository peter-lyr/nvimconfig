return {
  'RRethy/nvim-base16',
  lazy = true,
  event = { 'FocusLost', 'CursorMoved', },
  keys = {
    '<leader>bc',
    '<leader>bC',
  },
  config = function()
    require('config.colorscheme')
  end,
}
