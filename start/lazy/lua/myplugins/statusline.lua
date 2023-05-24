local name = "statusline"

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  event = { 'FocusLost', 'WinEnter', 'VimResized', },
  dependencies = {
    "itchyny/vim-gitbranch",
  },
}
