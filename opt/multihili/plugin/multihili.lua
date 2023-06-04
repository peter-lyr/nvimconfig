local getcontent = function(line1, col1, line2, col2)
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

local getvisualcontent = function()
  local s = vim.fn.getpos("'<")
  local line1 = s[2]
  local col1 = s[3]
  local e = vim.fn.getpos("'>")
  local line2 = e[2]
  local col2 = e[3]
  return getcontent(line1, col1, line2, col2)
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

local hili = function()
  if vim.tbl_contains({ 'v', 'V', '' }, vim.fn.mode()) == true then
    vim.cmd([[call feedkeys("\<esc>")]])
    local timer = vim.loop.new_timer()
    timer:start(10, 0, function()
      vim.schedule(function()
        vim.cmd(string.format([[let @0 = %s]], getvisualcontent()))
        local content = string.gsub(vim.fn.getreg('0'), '%[', '\\[')
        content = string.gsub(content, '%*', '\\*')
        local number = 1
        if HiLi and #vim.tbl_keys(HiLi) > 0 then
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
        end
        local hiname = 'HiLi' .. number
        local bg = Colors[math.random(#Colors)]
        HiLi = vim.tbl_deep_extend('force', HiLi, {
          [content] = { hiname, bg }
        })
        vim.api.nvim_set_hl(0, hiname, { bg = bg })
        vim.fn.matchadd(hiname, content)
      end)
    end)
  end
end

local rmhili = function()
  if HiLi and #vim.tbl_keys(HiLi) > 0 then
    if vim.tbl_contains({ 'v', 'V', '' }, vim.fn.mode()) == true then
      vim.cmd([[call feedkeys("\<esc>")]])
      local timer = vim.loop.new_timer()
      timer:start(10, 0, function()
        vim.schedule(function()
          vim.cmd(string.format([[let @0 = %s]], getvisualcontent()))
          local content = string.gsub(vim.fn.getreg('0'), '%[', '\\[')
          content = string.gsub(content, '%*', '\\*')
          if vim.tbl_contains(vim.tbl_keys(HiLi), content) then
            local hiname = HiLi[content][1]
            vim.api.nvim_set_hl(0, hiname, { bg = 'NONE' })
            HiLi[content] = nil
          end
        end)
      end)
    end
  end
end

local rehili = function()
  if HiLi and #vim.tbl_keys(HiLi) > 0 then
    for c, v in pairs(HiLi) do
      local h = v[1]
      local b = v[2]
      vim.api.nvim_set_hl(0, h, { bg = b })
      vim.fn.matchadd(h, c)
    end
  end
end

local curcontent = ''

local prevhili = function()
  if HiLi and #vim.tbl_keys(HiLi) > 0 then
    vim.cmd([[call feedkeys("\<esc>")]])
    local content = table.concat(vim.tbl_keys(HiLi), '\\|')
    local ee = vim.fn.searchpos(content, 'be')
    local ss = vim.fn.searchpos(content, 'bn')
    vim.cmd(string.format([[let @0 = %s]], getcontent(ss[1], ss[2], ee[1], ee[2])))
    content = string.gsub(vim.fn.getreg('0'), '%[', '\\[')
    curcontent = string.gsub(content, '%*', '\\*')
  end
end

local nexthili = function()
  if HiLi and #vim.tbl_keys(HiLi) > 0 then
    vim.cmd([[call feedkeys("\<esc>")]])
    local content = table.concat(vim.tbl_keys(HiLi), '\\|')
    local ss = vim.fn.searchpos(content)
    local ee = vim.fn.searchpos(content, 'ne')
    vim.cmd(string.format([[let @0 = %s]], getcontent(ss[1], ss[2], ee[1], ee[2])))
    content = string.gsub(vim.fn.getreg('0'), '%[', '\\[')
    curcontent = string.gsub(content, '%*', '\\*')
  end
end

local prevcurhili = function()
  if #curcontent > 0 then
    vim.cmd([[call feedkeys("\<esc>")]])
    vim.fn.searchpos(curcontent, 'be')
  end
end

local nextcurhili = function()
  if #curcontent > 0 then
    vim.cmd([[call feedkeys("\<esc>")]])
    vim.fn.searchpos(curcontent)
  end
end

local selnexthili = function()
  if HiLi and #vim.tbl_keys(HiLi) > 0 then
    vim.cmd([[call feedkeys("\<esc>")]])
    local content = table.concat(vim.tbl_keys(HiLi), '\\|')
    vim.fn.searchpos(content)
    local ne = vim.fn.searchpos(content, 'ne')
    vim.cmd(string.format([[call feedkeys("v%dgg%d|")]], ne[1], ne[2]))
  end
end

local selprevhili = function()
  if HiLi and #vim.tbl_keys(HiLi) > 0 then
    vim.cmd([[call feedkeys("\<esc>")]])
    local content = table.concat(vim.tbl_keys(HiLi), '\\|')
    vim.fn.searchpos(content, 'be')
    local ne = vim.fn.searchpos(content, 'nb')
    vim.cmd(string.format([[call feedkeys("v%dgg%d|")]], ne[1], ne[2]))
  end
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter', 'ColorScheme', }, {
  callback = function()
    rehili()
    vim.api.nvim_set_hl(0, 'CursorWord', { bg = 'gray', fg = 'yellow' })
  end,
})

vim.api.nvim_create_autocmd({ 'CursorMoved', }, {
  callback = function()
    vim.cmd(string.format([[match CursorWord /\V\<%s\>/]], vim.fn.expand('<cword>')))
  end,
})

vim.keymap.set({ 'v', }, '*', multilinesearch, { silent = true })
vim.keymap.set({ 'v', }, '<c-8>', hili, { silent = true })
vim.keymap.set({ 'v', }, '<c-s-8>', rmhili, { silent = true })

vim.keymap.set({ 'n', 'v', }, '<c-n>', prevhili, { silent = true })
vim.keymap.set({ 'n', 'v', }, '<c-m>', nexthili, { silent = true })
vim.keymap.set({ 'n', 'v', }, '<c-s-n>', prevcurhili, { silent = true })
vim.keymap.set({ 'n', 'v', }, '<c-s-m>', nextcurhili, { silent = true })

vim.keymap.set({ 'n', 'v', }, '<c-7>', selnexthili, { silent = true })
vim.keymap.set({ 'n', 'v', }, '<c-s-7>', selprevhili, { silent = true })
