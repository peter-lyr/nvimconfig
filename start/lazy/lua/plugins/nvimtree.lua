return {
  'nvim-tree/nvim-tree.lua',
  lazy = true,
  event = { 'FocusLost', },
  keys = {
    '<leader>;',
    '<leader>l',
    '<leader><leader>l',
  },
  config = function()
    require('config.nvimtree')
  end,
}
