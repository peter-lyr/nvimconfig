vim.keymap.set({ 'n', 'v' }, '<leader>;', ':<c-u>NvimTreeToggle<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>l', ':<c-u>NvimTreeFindFileToggle<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader><leader>l', ':<c-u>NvimTreeOpen <c-r>=getcwd()<cr><cr>', { silent = true })

return {
  'nvim-tree/nvim-tree.lua',
  lazy = true,
  cmd = { 'NvimTreeToggle', 'NvimTreeFindFileToggle', 'NvimTreeOpen', },
  event = { 'FocusLost', },
  config = function()
    local sta, config = pcall(require, 'nvimtree')
    if not sta then
      config = {}
    end
    require('nvim-tree').setup(config)
    vim.cmd('NvimTreeOpen')
    vim.cmd('NvimTreeClose')
  end
}
