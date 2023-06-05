return {
  'tpope/vim-fugitive',
  lazy = true,
  event = { 'FocusLost', },
  cmd = { "Git" },
  keys = {
    '<leader>gg',
    '<leader>gA',
    '<leader>ga',
  },
  config = function()
    vim.keymap.set({ 'n', 'v' }, '<leader>gg', ':<c-u>Git<cr>', { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<leader>gA', ':<c-u>Git add -A<cr>', { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<leader>ga', ':<c-u>Git add %<cr>', { silent = true })
  end,
}
