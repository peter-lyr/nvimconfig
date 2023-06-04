local M = {}

M.sel_items = {}

-- node: { "hidden", "absolute_path", "extension", "git_status", "type", "fs_stat", "executable", "name", "parent" }

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

local appendIfNotExists = function(t, s)
  local idx = index_of(t, s)
  local cwd = vim.fn.getcwd()
  if not idx then
    table.insert(t, s)
    vim.cmd(string.format([[ec 'attach(1/%d): %s']], #t, string.sub(s, #cwd + 2, #s)))
  else
    table.remove(t, idx)
    vim.cmd(string.format([[ec 'detach(remain %d): %s']], #t, string.sub(s, #cwd + 2, #s)))
  end
  return t
end

M.test = function(node)
  local absolute_path = node["absolute_path"]
  appendIfNotExists(M.sel_items, absolute_path)
  vim.cmd('norm j')
end

return M
