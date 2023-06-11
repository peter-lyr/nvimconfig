return {
  'folke/todo-comments.nvim',
  lazy = true,
  event = { 'FocusLost', 'CursorMoved', },
  key = {
    '<a-t>',
    '<a-s-t>',
  },
  config = function()
    require('todo-comments').setup({})
    vim.keymap.set({ 'n', 'v' }, '<a-t>', ':<c-u>TodoTelescope<cr>', { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<a-s-t>', ':<c-u>TodoQuickFix<cr>', { silent = true })
  end,
}
