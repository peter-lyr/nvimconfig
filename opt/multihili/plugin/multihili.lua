local getvisualcontent = function()
  local s = vim.fn.getpos("'<")
  local line1 = s[2]
  local col1 = s[3]
  local e = vim.fn.getpos("'>")
  local line2 = e[2]
  local col2 = e[3]
  local lines = {}
  for lnr = line1, line2 do
    local line = vim.fn.getline(lnr)
    if lnr == line1 and lnr == line2 then
      line = string.sub(line, col1, col2)
    else
      if lnr == line1 then
        line = string.sub(line, col1)
      elseif lnr == line2 then
        line = string.sub(line, 0, col2)
      end
    end
    local cells = {}
    for ch in string.gmatch(line, ".") do
      if ch == "'" then
        table.insert(cells, [["'"]])
      else
        if vim.tbl_contains({ '\\', '/' }, ch) then
          ch = '\\' .. ch
        end
        table.insert(cells, string.format([['%s']], ch))
      end
    end
    if #cells > 0 then
      table.insert(lines, table.concat(cells, ' . '))
    else
      table.insert(lines, "''")
    end
  end
  local content = table.concat(lines, " . '\\n' . ")
  return content
end

local multilinesearch = function()
  vim.cmd([[call feedkeys("\<esc>")]])
  local timer = vim.loop.new_timer()
  timer:start(10, 0, function()
    vim.schedule(function()
      vim.cmd(string.format([[let @/ = "\\V" . %s]], getvisualcontent()))
      vim.cmd([[call feedkeys("/\<c-r>/\<cr>")]])
    end)
  end)
end

local colorinit = function()
  local light = require("nvim-web-devicons-light")
  local by_filename = light.icons_by_filename
  Colors = {}
  for _, v in pairs(by_filename) do
    table.insert(Colors, v['color'])
  end
end

colorinit()

HiLi = {}

local function hili()
  if vim.tbl_contains({ 'v', 'V', '' }, vim.fn.mode()) == true then
    vim.cmd([[call feedkeys("\<esc>")]])
    local timer = vim.loop.new_timer()
    timer:start(10, 0, function()
      vim.schedule(function()
        vim.cmd(string.format([[let @0 = %s]], getvisualcontent()))
        local content = string.gsub(vim.fn.getreg('0'), '%[', '\\[')
        content = string.gsub(content, '%*', '\\*')
        local number = 1
        local g = {}
        for _, v in pairs(vim.tbl_values(HiLi)) do
          table.insert(g, v[1])
        end
        for i = 1, 50000 do
          if vim.tbl_contains(g, 'HiLi' .. i) == false then
            number = i
            break
          end
        end
        local hiname = 'HiLi' .. number
        local rand1 = math.random(#Colors)
        local rand2 = math.random(#Colors)
        if rand2 == rand1 then
          if rand1 > 1 then
            rand2 = rand1 - 1
          else
            rand2 = rand1 + 1
          end
        end
        local fg = Colors[rand1]
        local bg = Colors[rand2]
        HiLi = vim.tbl_deep_extend('force', HiLi, {
          [content] = { hiname, fg, bg }
        })
        vim.api.nvim_set_hl(0, hiname, { fg = fg, bg = bg, bold = true })
        vim.fn.matchadd(hiname, content)
      end)
    end)
  end
end

local rehili = function()
  for c, v in pairs(HiLi) do
    local h = v[1]
    local f = v[2]
    local b = v[3]
    vim.api.nvim_set_hl(0, h, { fg = f, bg = b, bold = true })
    vim.fn.matchadd(h, c)
  end
end

vim.keymap.set({ 'v' }, '<c-8>', hili, { silent = true })

vim.keymap.set({ 'n', 'v' }, '<c-7>', rehili, { silent = true })

vim.keymap.set({ 'v' }, '*', multilinesearch, { silent = true })
