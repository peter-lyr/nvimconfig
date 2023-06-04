local lang = {
  'c',
  'cpp',
  'python',
  'ld',
}

local tab_width = function()
  if vim.tbl_contains(lang, vim.opt.filetype:get()) == true then
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
  else
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2
  end
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    tab_width()
    vim.cmd('set mouse=a')
  end,
})
