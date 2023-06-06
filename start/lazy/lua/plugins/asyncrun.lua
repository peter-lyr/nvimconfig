return {
  'skywind3000/asyncrun.vim',
  lazy = true,
  cmd = {
    'AsyncRun',
    'AsyncStop',
    'AsyncReset',
  },
  config = function()
        vim.cmd([[
augroup local_asyncrun
au!
au User AsyncRunStop copen | wincmd p | lua vim.notify('AsyncRun Done.')
augroup END
  ]])
  end
}
