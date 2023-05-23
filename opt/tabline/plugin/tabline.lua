-- 总是显示tabline

vim.opt.showtabline = 2
vim.cmd([[set tabline=%!tabline#tabline()]])

-- 更新窗口标题

local startuptime = os.date("%H:%M:%S", vim.g.startuptime)

vim.api.nvim_create_autocmd({ 'WinLeave' }, {
  callback = function()
    vim.fn.timer_start(100, function()
      local title = vim.loop.cwd()
      if #title > 0 then
        local t1 = title .. ' | ' .. startuptime
        if vim.g.colors_name then
          t1 = t1 .. ' ' .. vim.g.colors_name
        end
        vim.opt.titlestring = t1
      end
    end)
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

vim.keymap.set({ 'n', 'v' }, '<leader><bs>', ':<c-u>try|exe "b" . g:lastbufnr|catch|endtry<cr>', { silent = true })

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

vim.loop.new_timer():start(1000, 1000, function()
  vim.schedule(function()
    local t = format_time(os.difftime(os.time(), vim.g.startuptime))
    t = t .. ' ' .. string.format("%.1f", vim.loop.resident_set_memory() / 1024 / 1024)
    vim.g.process_mem = t
    vim.g.tabline_onesecond = 1
  end)
end)

-- 恢复上次保存的所有buffer

vim.api.nvim_create_user_command('TablineSessionRestoreAll', function()
  vim.fn['tabline#restoresession']()
end, { nargs = 0, })