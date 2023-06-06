vim.keymap.set({ 'n', 'v' }, '<F6>z', function()
  vim.fn.system(
  [[reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f]])
  print('proxe on')
end, { silent = true })

vim.keymap.set({ 'n', 'v' }, '<F6>Z', function()
  vim.fn.system(
  [[reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f]])
  print('proxe off')
end, { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>tw', function()
  if vim.opt.wrap:get() == true then
    vim.opt.wrap = false
    print('no wrap')
  else
    vim.opt.wrap = true
    print('wrap')
  end
end, { silent = true })
