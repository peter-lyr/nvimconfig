local M = {}

-- node: { "hidden", "absolute_path", "extension", "git_status", "type", "fs_stat", "executable", "name", "parent" }

M.test = function(node)
  print('absolute_path', node["absolute_path"])
  vim.cmd('norm j')
end

return M
