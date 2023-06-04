return {
  'iamcco/markdown-preview.nvim',
  lazy = true,
  keys = {
    '<F3><F3>',
  },
  config = function()
    require('config.markdownpreview')
  end,
}
