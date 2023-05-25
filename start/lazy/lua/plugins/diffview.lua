return {
  'sindrets/diffview.nvim',
  lazy = true,
  event = { 'FocusLost', },
  keys = {
    '<leader>gi',
    '<leader>go',
    '<leader>gq',

    '<leader>gT',
    '<leader>ge',
    '<leader>gl',
  },
  config = function()
    require('config.diffview')
  end,
}
