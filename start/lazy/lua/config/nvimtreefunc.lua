local m = require("nvim-tree.marks")
local p = require("plenary.path")
local s = require("plenary.scandir")

-- node: { "hidden", "absolute_path", "extension", "git_status", "type", "fs_stat", "executable", "name", "parent" }

local pp = p:new(vim.g.boot_lua):parent():parent():joinpath('lua', 'config')

local recyclebin = pp:joinpath('nvimtree-recyclebin.exe').filename
-- local copy2clip = pp:joinpath('nvimtree-copy2clip.exe').filename

local M = {}

local rep = function(path)
  path, _ = string.gsub(path, '\\\\', '/')
  path, _ = string.gsub(path, '\\', '/')
  return path
end

M.toggle_sel = function(node)
  m.toggle_mark(node)
  local marks = m.get_marks()
  print('selected', #marks, 'items.')
  vim.cmd('norm j')
end

M.toggle_sel_up = function(node)
  m.toggle_mark(node)
  local marks = m.get_marks()
  print('selected', #marks, 'items.')
  vim.cmd('norm k')
end

M.empty_sel = function()
  m.clear_marks()
  print('empty selected.')
end

M.delete_sel = function()
  local marks = m.get_marks()
  local res = vim.fn.input("Confirm deletion " .. #marks .. " [N/y] ", "y")
  if vim.tbl_contains({ 'y', 'Y', 'yes', 'Yes', 'YES' }, res) == true then
    for _, v in ipairs(marks) do
      local absolute_path = v['absolute_path']
      local path = p:new(absolute_path)
      if path:is_dir() then
        local entries = s.scan_dir(absolute_path, { hidden = true, depth = 10, add_dirs = false })
        for _, entry in ipairs(entries) do
          pcall(vim.cmd, "bw! " .. rep(entry))
        end
      else
        pcall(vim.cmd, "bw! " .. rep(absolute_path))
      end
      vim.fn.system(string.format('%s "%s"', recyclebin, absolute_path:match('^(.-)\\*$')))
    end
    m.clear_marks()
  else
    print('canceled!')
  end
end

return M
