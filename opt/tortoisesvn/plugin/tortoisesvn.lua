local path = require("plenary.path")

local system_cd_string = function(absfolder)
  local fpath = path:new(absfolder)
  if not fpath:exists() then
    return ''
  end
  if fpath:is_dir() then
    return string.sub(absfolder, 1, 1) .. ': && cd ' .. absfolder
  end
  return string.sub(absfolder, 1, 1) .. ': && cd ' .. fpath:parent()['filename']
end

local tortoisesvn = function(params)
  if not params or #params < 3 then
    return
  end
  local cmd, cmd1, cmd2, root, yes = unpack(params)
  if #params == 3 then
    cmd, root, yes = unpack(params)
  elseif #params == 4 then
    cmd1, cmd2, root, yes = unpack(params)
    cmd = cmd1 .. ' ' .. cmd2
  end
  if not cmd then
    return
  end
  local abspath = (root == 'root') and vim.fn['projectroot#get'](vim.api.nvim_buf_get_name(0)) or
  vim.api.nvim_buf_get_name(0)
  if yes == 'yes' or vim.tbl_contains({ 'y', 'Y' }, vim.fn.trim(vim.fn.input("Sure to update? [Y/n]: ", 'Y'))) == true then
    vim.fn.execute(string.format("silent !%s && start tortoiseproc.exe /command:%s /path:\"%s\"",
      system_cd_string(abspath),
      cmd, abspath))
  end
end

vim.api.nvim_create_user_command('TortoisesvN', function(params)
  tortoisesvn(params['fargs'])
end, { nargs = "*", })


vim.keymap.set({ 'n', 'v' }, '<leader>vo', ':TortoisesvN settings cur yes<cr>',  { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>vd', ':TortoisesvN diff cur yes<cr>',  { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>vD', ':TortoisesvN diff root yes<cr>',  { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>vb', ':TortoisesvN blame cur yes<cr>',  { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>vw', ':TortoisesvN repobrowser cur yes<cr>',  { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>vW', ':TortoisesvN repobrowser root yes<cr>',  { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>vs', ':TortoisesvN repostatus cur yes<cr>',  { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>vS', ':TortoisesvN repostatus root yes<cr>',  { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>vr', ':TortoisesvN rename cur yes<cr>',  { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>vR', ':TortoisesvN remove cur yes<cr>',  { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>vv', ':TortoisesvN revert cur yes<cr>',  { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>vV', ':TortoisesvN revert root yes<cr>',  { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>va', ':TortoisesvN add cur yes<cr>',  { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>vA', ':TortoisesvN add root yes<cr>',  { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>vc', ':TortoisesvN commit cur yes<cr>',  { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>vC', ':TortoisesvN commit root yes<cr>',  { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>vu', ':TortoisesvN update root no<cr>',  { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>vU', ':TortoisesvN update /rev root yes<cr>',  { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>vl', ':TortoisesvN log cur yes<cr>',  { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>vL', ':TortoisesvN log root yes<cr>',  { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>vk', ':TortoisesvN checkout root yes<cr>',  { silent = true })
