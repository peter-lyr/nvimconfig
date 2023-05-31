local path = require('plenary.path')

local myplugins = function()
  local name = vim.fn.input('myplugins name: ', '')
  if #string.match(name, '^%s*(.-)%s*$') == 0 then
    return
  end
  local content = string.format([[
return {
  '%s',
  lazy = true,
  event = { 'FocusLost', 'CursorMoved', },
  keys = {
    '<leader>gi',
  },
  dependencies = {
  },
  config = function()
    require('config.%s')
  end,
}]], name, name)
  local pluginslua = path:new(vim.g.boot_lua):parent():parent():joinpath('lua', 'myplugins', name .. '.lua')
  pluginslua:write(content, 'w')
  vim.cmd(string.format([[e %s]], pluginslua.filename))
end

local plugins = function()
  local name = vim.fn.input('plugins name: ', '')
  if #string.match(name, '^%s*(.-)%s*$') == 0 then
    return
  end
  local content = string.format([[
return {
  '%s',
  lazy = true,
  event = { 'FocusLost', 'CursorMoved', },
  keys = {
    '<leader>gi',
  },
  dependencies = {
  },
  config = function()
    require('config.%s')
  end,
}]], name, name)
  local pluginslua = path:new(vim.g.boot_lua):parent():parent():joinpath('lua', 'plugins', name .. '.lua')
  pluginslua:write(content, 'w')
  vim.cmd(string.format([[e %s]], pluginslua.filename))
end

vim.keymap.set({ 'n', 'v' }, '<leader><leader><leader>z', plugins, { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader><leader><leader>y', myplugins, { silent = true })
