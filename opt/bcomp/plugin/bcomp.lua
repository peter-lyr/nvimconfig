local path = require("plenary.path")

vim.g.bcomp1 = ''
vim.g.bcomp2 = ''

local bcomp = function(params)
  local param = params[1]
  local fpath = path:new(vim.api.nvim_buf_get_name(0))
  if not fpath:exists() then
    local tempfname1 = string.gsub(fpath.filename, '\\', '/')
    local tempfname2 = string.match(tempfname1, '.*/([^/]+)')
    local temppath = path:new(vim.fn.expand('$TEMP'))
    fpath = temppath:joinpath(tempfname2)
    fpath:write(table.concat(vim.fn.getline(1, vim.fn.line('$')), '\n'), 'w')
  end
  if param == '1' then
    vim.g.bcomp1 = fpath.filename
  elseif param == '2' then
    if #vim.g.bcomp1 == 0 then
      vim.g.bcomp1 = fpath.filename
      vim.cmd('echo "bcomp vim.g.bcomp1: ' .. vim.g.bcomp1 .. '"')
    else
      vim.g.bcomp2 = fpath.filename
      vim.cmd("echo 'bcomp vim.g.bcomp2: " .. vim.g.bcomp2 .. "'")
      vim.cmd(string.format([[silent !start /b /min cmd /c "bcomp "%s" "%s""]], vim.g.bcomp1, vim.g.bcomp2))
    end
  end
  if param == '3' then
    if #vim.g.bcomp1 > 0 and #vim.g.bcomp2 > 0 then
      vim.cmd(string.format([[silent !start /b /min cmd /c "bcomp "%s" "%s""]], vim.g.bcomp1, vim.g.bcomp2))
    end
  end
end

vim.api.nvim_create_user_command('BcomP', function(params)
  bcomp(params['fargs'])
end, { nargs = 1, })

vim.keymap.set({ 'n', 'v' }, '<leader>b<f1>', ':<c-u>BcomP 1<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>b<f2>', ':<c-u>BcomP 2<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>b<f3>', ':<c-u>BcomP 3<cr>', { silent = true })
