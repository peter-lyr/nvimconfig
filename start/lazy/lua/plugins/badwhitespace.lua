return {
  'bitc/vim-bad-whitespace',
  lazy = true,
  keys = {
    '<leader>ee',
    '<leader>eh',
    '<leader>es',
  },
  config = function()
    vim.keymap.set({ 'n', 'v' }, '<leader>ee', ':<c-u>EraseBadWhitespace<cr>',  { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<leader>eh', ':<c-u>HideBadWhitespace<cr> ',  { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<leader>es', ':<c-u>ShowBadWhitespace<cr> ',  { silent = true })
  end,
}
