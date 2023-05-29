return {
  'phaazon/hop.nvim',
  lazy = true,
  event = { 'FocusLost', },
  keys = {
    's',
    'f',
  },
  config = function()
    require('hop').setup()
    vim.keymap.set('n', 's', ':HopChar1<cr>',  { silent = true })
    vim.keymap.set('n', 'f', ':HopChar2<cr>',  { silent = true })
  end,
}
