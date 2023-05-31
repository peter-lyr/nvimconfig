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
local startuptime = os.date("%H:%M:%S", vim.g.startuptime)

local update_title_string = function()
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
  end

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
  vim.fn['timer_start'](100, update_title_string)
end

local changecolorschemedefault = function()
  local cwd = string.lower(string.gsub(vim.loop.cwd(), '\\', '/'))
  if vim.tbl_contains(vim.tbl_keys(colors), cwd) then
    if vim.g.colors_name == 'default' then
      c(string.format([[call feedkeys(":\<c-u>colorscheme %s\<cr>")]], colors[cwd]))
      vim.fn['timer_start'](100, update_title_string)
      return
    end
  end
  c([[call feedkeys(":\<c-u>colorscheme default\<cr>")]])
  vim.fn['timer_start'](100, update_title_string)
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
