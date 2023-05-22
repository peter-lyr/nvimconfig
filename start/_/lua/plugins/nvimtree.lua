vim.keymap.set({ 'n', 'v' }, '<leader>;', ':<c-u>NvimTreeToggle<cr>', { silent = true })

return {
  'nvim-tree/nvim-tree.lua',
  lazy = true,
  cmd = { 'NvimTreeToggle', },
  event = { 'FocusLost', },
  config = function()
    require('nvim-tree').setup()
    vim.cmd('NvimTreeOpen')
    vim.cmd('NvimTreeClose')
  end
}
