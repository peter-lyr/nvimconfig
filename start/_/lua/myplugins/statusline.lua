local name = "statusline"

return {
  {
    name = name,
    dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
    event = { 'WinEnter', 'VimResized', 'FocusLost' },
    dependencies = {
      "itchyny/vim-gitbranch",
    },
  },
}
