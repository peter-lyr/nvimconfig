return {
  'kevinhwang91/nvim-bqf',
  lazy = true,
  event = { 'FocusLost', },
  keys = {
    '<leader>m',
  },
  config = function()
    require('config.bqf')
  end,
}
