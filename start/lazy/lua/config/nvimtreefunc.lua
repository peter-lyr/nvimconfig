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

local get_dtarget = function(node)
  if node.type == 'directory' then
    return rep(node.absolute_path)
  end
  if node.type == 'file' then
    return rep(node.parent.absolute_path)
  end
  return nil
end

local get_fname_tail = function(fname)
  fname = string.gsub(fname, "/", "\\")
  local path = p:new(fname)
  if path:is_file() then
    fname = path:_split()
    return fname[#fname]
  elseif path:is_dir() then
    fname = path:_split()
    if #fname[#fname] > 0 then
      return fname[#fname]
    else
      return fname[#fname - 1]
    end
  end
  return ''
end

M.test = function(node)
  print(node.type)
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

M.move_sel = function(node)
  local dtarget = get_dtarget(node)
  if not dtarget then
    return
  end
  local marks = m.get_marks()
  local res = vim.fn.input("Confirm movment " .. #marks .. " [N/y] ", "y")
  if vim.tbl_contains({ 'y', 'Y', 'yes', 'Yes', 'YES' }, res) == true then
    for _, v in ipairs(marks) do
      local absolute_path = v['absolute_path']
      if p:new(absolute_path):is_dir() then
        local dname = get_fname_tail(absolute_path)
        dname = string.format('%s/%s', dtarget, dname)
        if p:new(dname):exists() then
          vim.cmd('redraw')
          local dname_new = vim.fn.input(absolute_path .. " ->\nExisted! Rename? ", dname)
          if #dname_new > 0 and dname_new ~= dname then
            vim.fn.system(string.format('move "%s" "%s"', string.sub(absolute_path, 1, #absolute_path - 1), dname_new))
          elseif #dname_new == 0 then
            print('cancel all!')
            return
          else
            vim.cmd('redraw')
            print(absolute_path .. ' -> failed!')
            goto continue
          end
        else
          vim.fn.system(string.format('move "%s" "%s"', string.sub(absolute_path, 1, #absolute_path - 1), dname))
        end
      else
        local fname = get_fname_tail(absolute_path)
        fname = string.format('%s/%s', dtarget, fname)
        if p:new(fname):exists() then
          vim.cmd('redraw')
          local fname_new = vim.fn.input(absolute_path .. " ->\nExisted! Rename? ", fname)
          if #fname_new > 0 and fname_new ~= fname then
            vim.fn.system(string.format('move "%s" "%s"', absolute_path, fname_new))
          elseif #fname_new == 0 then
            print('cancel all!')
            return
          else
            vim.cmd('redraw')
            print(absolute_path .. ' -> failed!')
            goto continue
          end
        else
          vim.fn.system(string.format('move "%s" "%s"', absolute_path, fname))
        end
      end
      pcall(vim.cmd, "bw! " .. rep(absolute_path))
      ::continue::
    end
    m.clear_marks()
  else
    print('canceled!')
  end
end

return M
