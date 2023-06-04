local m = require("nvim-tree.marks")

local M = {}

-- node: { "hidden", "absolute_path", "extension", "git_status", "type", "fs_stat", "executable", "name", "parent" }

M.toggle_sel = function(node)
  m.toggle_mark(node)
  local marks = m.get_marks()
  print(#marks)
  vim.cmd('norm j')
end

return M
