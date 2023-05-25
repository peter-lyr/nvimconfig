local patterns = {
  ".cache",
  "build",
  "compile_commands.json",
  "CMakeLists.txt",
  ".git",
}

require("project_nvim").setup({
  manual_mode = false,
  datapath = vim.fn['expand']("$VIMRUNTIME") .. "\\my-neovim-data",
  detection_methods = { "pattern", "lsp" },
  patterns = patterns,
})

require('telescope').load_extension("projects")

local _ = function()
  vim.cmd('Telescope projects')
  vim.cmd([[call feedkeys("\<esc>\<esc>")]])
  vim.keymap.set({ 'n', 'v' }, '<a-s-k>', ':<c-u>Telescope projects<cr>', { silent = true })
  vim.cmd([[call feedkeys(":Telescope projects\<cr>")]])
end

-- mappings

vim.keymap.set({ 'n', 'v' }, '<a-s-k>', _, { silent = true })
