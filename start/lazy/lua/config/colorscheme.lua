local c = vim.cmd
local f = vim.fn
local a = vim.api

ColorSchemes = {}

for _, v in pairs(vim.fn.getcompletion("", "color")) do
  if string.match(v, '^base16') and not string.match(v, 'light') then
    table.insert(ColorSchemes, v)
  end
end

math.randomseed(os.time())

local colors = {}
local lastcwd = ''

local changecolorscheme = function(force)
  local cwd = string.lower(string.gsub(vim.loop.cwd(), '\\', '/'))
  if force ~= true and (cwd == lastcwd or f['filereadable'](a.nvim_buf_get_name(0)) == 0) then
    return
  end
  lastcwd = cwd
  if not vim.tbl_contains(vim.tbl_keys(colors), cwd) or force == true then
    local color = ColorSchemes[math.random(#ColorSchemes)]
    colors[cwd] = color
  end
  c(string.format([[call feedkeys(":\<c-u>colorscheme %s\<cr>")]], colors[cwd]))
end

local changecolorschemedefault = function()
  local cwd = string.lower(string.gsub(vim.loop.cwd(), '\\', '/'))
  if vim.tbl_contains(vim.tbl_keys(colors), cwd) then
    if vim.g.colors_name == 'default' then
      c(string.format([[call feedkeys(":\<c-u>colorscheme %s\<cr>")]], colors[cwd]))
      return
    end
  end
  c([[call feedkeys(":\<c-u>colorscheme default\<cr>")]])
end

local timer = vim.loop.new_timer()
timer:start(100, 100, function()
  vim.schedule(function()
    changecolorscheme(false)
  end)
end)

local s = vim.keymap.set
local opt = { silent = true }
s({ 'n', 'v' }, '<leader>bw', function() changecolorscheme(true) end, opt)
s({ 'n', 'v' }, '<leader>bW', function() changecolorschemedefault() end, opt)
