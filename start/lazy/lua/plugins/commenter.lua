return {
  'commenter',
  lazy = true,
  keys = {
    '<leader>cp',
    '<leader>c}',
    '<leader>c{',
    '<leader>cG',
  },
  config = function()
    vim.keymap.set({ 'n', 'v' }, '<leader>cp', "vip:call nerdcommenter#Comment('x', 'toggle')<CR>",  { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<leader>c}', "V}k:call nerdcommenter#Comment('x', 'toggle')<CR>",  { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<leader>c{', "V{j:call nerdcommenter#Comment('x', 'toggle')<CR>",  { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<leader>cG',  "VG:call nerdcommenter#Comment('x', 'toggle')<CR>",  { silent = true })
  end,
}
