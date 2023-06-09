local markdowntable_line = 0

local get_paragraph = function()
  local paragraph = {}
  local linenr = vim.fn.line('.')
  local lines = 0
  for i = linenr, 1, -1 do
    local line = vim.fn.getline(i)
    if #line > 0 then
      lines = lines + 1
      table.insert(paragraph, 1, line)
    else
      markdowntable_line = i + 1
      break
    end
  end
  for i = linenr + 1, vim.fn.line('$') do
    local line = vim.fn.getline(i)
    if #line > 0 then
      table.insert(paragraph, line)
      lines = lines + 1
    else
      break
    end
  end
  return paragraph
end

local aligntable = function()
  if vim.opt.modifiable:get() == 0 then
    return
  end
  if vim.opt.ft:get() ~= 'markdown' then
    return
  end
  local ll = vim.fn.getpos('.')
  local lines = get_paragraph()
  local cols = 0
  for _, line in ipairs(lines) do
    local cells = vim.fn.split(vim.fn.trim(line), '|')
    if cols < #cells then
      cols = #cells
    end
  end
  local Lines = {}
  local Matrix = {}
  for _, line in ipairs(lines) do
    local cells = vim.fn.split(vim.fn.trim(line), '|')
    local Cells = {}
    local matrix = {}
    for i = 1, cols do
      local cell = string.gsub(cells[i], "^%s*(.-)%s*$", "%1")
      table.insert(Cells, cell)
      table.insert(matrix, { vim.fn.strlen(cell), vim.fn.strwidth(cell) })
    end
    table.insert(Lines, Cells)
    table.insert(Matrix, matrix)
  end
  local Cols = {}
  for i = 1, cols do
    local m = 0
    for j = 1, #Matrix do
      if Matrix[j][i][2] > m then
        m = Matrix[j][i][2]
      end
    end
    table.insert(Cols, m)
  end
  local newLines = {}
  for i = 1, #Lines do
    local Cells = Lines[i]
    local newCell = '|'
    for j = 1, cols do
      newCell = newCell ..
      string.format(string.format(" %%-%ds |", Matrix[i][j][1] + (Cols[j] - Matrix[i][j][2])), Cells[j])
    end
    table.insert(newLines, newCell)
  end
  vim.fn.setline(markdowntable_line, newLines)
  vim.cmd(string.format([[norm %dgg0%d|]], ll[2], ll[3]))
end

vim.keymap.set({ 'n', 'v' }, '<leader><leader>ta', aligntable, { silent = true })
