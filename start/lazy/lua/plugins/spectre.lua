return {
  'nvim-pack/nvim-spectre',
  lazy = true,
  keys = {
    '<a-r>',
  },
  config = function()
    require('spectre').setup()
    vim.keymap.set({ 'n', 'v' }, '<a-r>', ':<c-u>Spectre<cr><cr>', { silent = true })
  end,
}
