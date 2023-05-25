return {
  'lewis6991/gitsigns.nvim',
  lazy = true,
  event = { 'FocusLost', },
  keys = {
    '<leader>gr',
    '<leader>gR',
    '<leader>k',
    '<leader>j',
    '<leader>gp',
    '<leader>gx',
    '<leader>gd',
    '<leader>gD',
    '<leader>gtd',
    '<leader>gtb',
  },
  config = function()
    require('config.gitsigns')
  end,
}
