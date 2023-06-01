return {
  'hrsh7th/nvim-cmp',
  lazy = true,
  event = { 'FocusLost', 'InsertEnter', },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    {
      'quangnguyen30192/cmp-nvim-ultisnips',
      dependencies = {
        'SirVer/ultisnips',
      }
    }
  },
  config = function()
    require('config.cmp')
  end,
}