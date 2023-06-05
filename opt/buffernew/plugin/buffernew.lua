local stack_fpath
local split

local open_fpath = function()
  if split == 'up' then
    vim.cmd('leftabove split')
  elseif split == 'right' then
    vim.cmd('rightbelow vsplit')
  elseif split == 'down' then
    vim.cmd('rightbelow split')
  elseif split == 'left' then
    vim.cmd('leftabove vsplit')
  end
  pcall(vim.cmd, 'e ' .. stack_fpath)
end

local open = function(mode)
  split = mode
  open_fpath()
end

local copy_fpath = function()
  stack_fpath = vim.api.nvim_buf_get_name(0)
  print(stack_fpath)
end

local ft = {
  'jpg', 'png',
}

local index_of = function(arr, val)
  if not arr then
    return nil
  end
  for i, v in ipairs(arr) do
    if v == val then
      return i
    end
  end
  return nil
end

local copy_fpath_silent = function()
  local fname = vim.api.nvim_buf_get_name(0)
  if #fname > 0 then
    stack_fpath = fname
  end
  pcall(vim.cmd, 'hide')
  local cur_fname = vim.api.nvim_buf_get_name(0)
  local extension = string.match(cur_fname, '.+%.(%w+)$')
  if index_of(ft, extension) then
    vim.cmd('bw! ' .. cur_fname)
  end
end

local bwunlisted = function()
  local sta, Path = pcall(require, 'plenary.path')
  if not sta then
    print(Path)
    return
  end
  local bufnrs = vim.tbl_filter(function(b)
    if 1 ~= vim.fn.buflisted(b) then
      local path = Path:new(vim.api.nvim_buf_get_name(b))
      if path:exists() and not path:is_dir() then
        return true
      end
      return false
    end
    return false
  end, vim.api.nvim_list_bufs())
  for _, v in ipairs(bufnrs) do
    vim.cmd('bw!' .. v)
  end
end

local run = function(params)
  if not params or #params == 0 then
    return
  end
  local cmd = params[1]
  if cmd == 'copy_fpath' then
    copy_fpath()
  elseif cmd == 'copy_fpath_silent' then
    copy_fpath_silent()
  elseif cmd == 'bwunlisted' then
    bwunlisted()
  else
    open(cmd)
  end
end

vim.api.nvim_create_user_command('BufferneW', function(params)
  run(params['fargs'])
end, { nargs = '*', })

-- '<,'>s/vim\.keymap\.set(\([^}]\+},\) *\([^,]\+,\) *\([^,]\+,\) *\([^)]\+\))/\=printf("vim.keymap.set(%-20s %-24s %-64s %s)", submatch(1), submatch(2), submatch(3), submatch(4))

vim.keymap.set({ 'n', 'v' },        '<leader>bg',            ':<c-u>BufferneW copy_fpath<cr>',                                { silent = true })
vim.keymap.set({ 'n', 'v' },        '<leader>bi',            ':<c-u>BufferneW here<cr>',                                      { silent = true })
vim.keymap.set({ 'n', 'v' },        '<leader>bk',            ':<c-u>BufferneW up<cr>',                                        { silent = true })
vim.keymap.set({ 'n', 'v' },        '<leader>bj',            ':<c-u>BufferneW down<cr>',                                      { silent = true })
vim.keymap.set({ 'n', 'v' },        '<leader>bh',            ':<c-u>BufferneW left<cr>',                                      { silent = true })
vim.keymap.set({ 'n', 'v' },        '<leader>bl',            ':<c-u>BufferneW right<cr>',                                     { silent = true })

vim.keymap.set({ 'n', 'v' },        '<leader>xc',            ':<c-u>BufferneW copy_fpath_silent<cr>',                         { silent = true })
vim.keymap.set({ 'n', 'v' },        '<leader><del>',         ':<c-u>BufferneW bwunlisted<cr>',                                { silent = true })

vim.keymap.set({ 'n', 'v' },        '<leader>bn',            ':<c-u>leftabove split<cr>',                                     { silent = true })
vim.keymap.set({ 'n', 'v' },        '<leader>bm',            ':<c-u>leftabove new<cr>',                                       { silent = true })
vim.keymap.set({ 'n', 'v' },        '<leader>bo',            ':<c-u>leftabove vsplit<cr>',                                    { silent = true })
vim.keymap.set({ 'n', 'v' },        '<leader>bp',            ':<c-u>leftabove vnew<cr>',                                      { silent = true })

vim.keymap.set({ 'n', 'v' },        '<leader>ba',            ':<c-u>split<cr>',                                               { silent = true })
vim.keymap.set({ 'n', 'v' },        '<leader>bb',            ':<c-u>new<cr>',                                                 { silent = true })
vim.keymap.set({ 'n', 'v' },        '<leader>bc',            ':<c-u>vsplit<cr>',                                              { silent = true })
vim.keymap.set({ 'n', 'v' },        '<leader>bd',            ':<c-u>vnew<cr>',                                                { silent = true })
vim.keymap.set({ 'n', 'v' },        '<leader>be',            '<c-w>s<c-w>T',                                                  { silent = true })
vim.keymap.set({ 'n', 'v' },        '<leader>bf',            ':<c-u>tabnew<cr>',                                              { silent = true })

vim.keymap.set({ 'n', 'v' },        '<leader>xX',            ':<c-u>tabclose<cr>',                                            { silent = true })
vim.keymap.set({ 'n', 'v' },        '<a-bs>',                ':<c-u>bw!<cr>',                                                 { silent = true })
vim.keymap.set({ 'n', 'v' },        'ZX',                    ':<c-u>qa!<cr>',                                                 { silent = true })
