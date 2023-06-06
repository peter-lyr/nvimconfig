-- 总是显示tabline

vim.opt.showtabline = 2
vim.cmd([[set tabline=%!tabline#tabline()]])

-- 更新窗口标题

local rep = function(path)
  path, _ = string.gsub(path, '\\', '/')
  return path
end

local titlestring = function()
  vim.opt.titlestring = string.format('%s %.1fM', rep(vim.loop.cwd()),
    vim.loop.resident_set_memory() / 1024 / 1024)
end

titlestring()

vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter', 'VimResized', 'WinResized', }, {
  callback = function()
    if vim.g.GuiWindowFullScreen == 0 then
      titlestring()
    end
  end,
})

-- 记录上一个buffer，来回切换

vim.g.lastbufnr = nil

vim.api.nvim_create_autocmd({ 'BufLeave' }, {
  callback = function()
    if vim.fn.filereadable(vim.api.nvim_buf_get_name(0)) then
      vim.g.lastbufnr = vim.fn.bufnr()
    end
  end,
})

-- 新buffer更新高亮

local Path = require("plenary.path")
local devicons = require("nvim-web-devicons")

TablineHi = {}
vim.g.tablinehi = {}

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function()
    local path = Path:new(vim.api.nvim_buf_get_name(0))
    if not path:exists() then
      return
    end
    local ext = string.match(path.filename, "%.([^.]+)$")
    if not ext then
      return
    end
    local ic, color = devicons.get_icon_color(path.filename, ext)
    if ic then
      vim.api.nvim_get_hl(0, { name = 'MyTabline' .. ext })
      TablineHi[ext] = { ic, color }
      vim.api.nvim_set_hl(0, "MyTabline" .. ext, { fg = color, bold = true, bg = 'NONE' })
      vim.api.nvim_set_hl(0, "TablineHi", { fg = '#8ca2c9', bold = true })
      vim.api.nvim_set_hl(0, "TablineDim", { fg = '#626262', bg = 'NONE' })
      vim.g.tablinehi = TablineHi
    end
  end,
})

-- colorscheme变化时恢复高亮

vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
  callback = function()
    for k, v in pairs(TablineHi) do
      local ext = k
      local color = v[2]
      local hl_group = "MyTabline" .. ext
      vim.api.nvim_set_hl(0, hl_group, { fg = color, bold = true })
      vim.api.nvim_set_hl(0, "TablineHi", { fg = '#8ca2c9', bold = true })
      vim.api.nvim_set_hl(0, "TablineDim", { fg = '#626262' })
    end
  end,
})

-- 窗口大小改变时，更新tabline

vim.api.nvim_create_autocmd({ 'VimResized' }, {
  callback = function()
    vim.g.tabline_done = 0
  end,
})

-- 每隔一秒更新一次tabline

local function format_time(secs)
  local seconds = secs % 60
  local minutes = math.floor(secs / 60) % 60
  local hours = math.floor(secs / 60 / 60) % 24
  local days = math.floor(secs / 60 / 60 / 24) % 30
  local months = math.floor(secs / 60 / 60 / 24 / 30) % 12
  local years = math.floor(secs / 60 / 60 / 24 / 30 / 12) % 365
  if years > 0 then
    return string.format("%02d/%02d/%02d %02d:%02d:%02d", years, months, days, hours, minutes, seconds)
  elseif months > 0 then
    return string.format("%02d/%02d %02d:%02d:%02d", months, days, hours, minutes, seconds)
  elseif days > 0 then
    return string.format("%02d %02d:%02d:%02d", days, hours, minutes, seconds)
  elseif hours > 0 then
    return string.format("%02d:%02d:%02d", hours, minutes, seconds)
  elseif minutes > 0 then
    return string.format("%02d:%02d", minutes, seconds)
  else
    return string.format("%02d", seconds)
  end
end

-- mappings

vim.keymap.set({ 'n', 'v' }, '<leader><bs>', ':<c-u>try|exe "b" . g:lastbufnr|catch|endtry<cr>', { silent = true })

vim.api.nvim_create_user_command('PrintRuntime', function()
  print(format_time(os.difftime(os.time(), vim.g.startuptime)))
end, { nargs = 0, })
