return {
  'ahmedkhalf/project.nvim',
  lazy = true,
  event = { 'FocusLost', },
  keys = {
    '<a-s-k>',
  },
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('config.telescope-projects')
  end,
}
