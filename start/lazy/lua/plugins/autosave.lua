local event = { 'InsertLeave', 'TextChanged', 'TextChangedI', 'CursorHold', 'CursorHoldI', 'CompleteDone' }

return {
  '907th/vim-auto-save',
  lazy = true,
  event = event,
  config = function()
    vim.g.auto_save = 1
    vim.g.auto_save_silent = 1
    vim.g.auto_save_events = event
  end
}
