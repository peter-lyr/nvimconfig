return {
  'phaazon/hop.nvim',
  lazy = true,
  keys = {
    's',
  },
  config = function()
    require('hop').setup()
    vim.keymap.set('n', 's', ':HopChar1<cr>', { silent = true })
  end,
}
