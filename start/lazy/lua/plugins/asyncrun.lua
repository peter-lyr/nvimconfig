return {
  'skywind3000/asyncrun.vim',
  lazy = true,
  cmd = {
    'AsyncRun',
    'AsyncStop',
    'AsyncReset',
  },
  config = function()
    vim.cmd('au User AsyncRunStop echomsg "AsyncRun Done."')
  end
}
