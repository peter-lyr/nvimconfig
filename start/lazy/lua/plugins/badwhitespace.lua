return {
  'bitc/vim-bad-whitespace',
  lazy = true,
  keys = {
    '<leader>ee',
    '<leader>eh',
    '<leader>es',
  },
  config = function()
    vim.keymap.set({ 'n', 'v' }, '<leader>ee', ':<c-u>EraseBadwhitespace<cr>',  { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<leader>eh', ':<c-u>HideBadwhitespace<cr> ',  { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<leader>es', ':<c-u>ShowBadwhitespace<cr> ',  { silent = true })
  end,
}
