return {
  'junegunn/vim-slash',
  lazy = true,
  event = { 'CursorMoved', },
  config = function()
    vim.cmd([[
if has('timers')
  noremap <expr> <plug>(slash-after) slash#blink(3, 20) " Blink 2 times with 50ms interval
endif
]])
  end
}
