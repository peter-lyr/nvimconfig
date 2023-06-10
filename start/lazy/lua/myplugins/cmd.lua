local name = "cmd"

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  keys = {
    '<a-g>',
  },
  config = function()
    vim.keymap.set({ 'n', 'v' }, '<a-g>', ':<c-u>!start cmd /c lazygit<cr>', { silent = true })
  end,
}
