return {
  "folke/twilight.nvim",
  lazy = true,
  keys = {
    '<leader>zz',
    '<leader>zt',
  },
  dependencies = {
    'folke/zen-mode.nvim',
  },
  config = function()
    vim.keymap.set({ 'n', 'v' }, '<leader>zz', ':<c-u>ZenMode<cr>', { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<leader>zt', ':<c-u>Twilight<cr>', { silent = true })
  end
}

