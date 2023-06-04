return {
  'nvim-tree/nvim-tree.lua',
  lazy = true,
  event = { 'FocusLost', },
  keys = {
    '<leader>;',
    '<leader>l',
    '<leader><leader>l',
  },
  dependencies = {
    {
      name = 'terminal',
      dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. 'terminal',
    }
  },
  config = function()
    require('config.nvimtree')
  end,
}
