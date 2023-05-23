local name = "tabline"

vim.g.startuptime = os.time()

vim.keymap.set({ 'n', 'v' }, '<leader>bU', ':<c-u>TablineSessionRestoreProjects<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>bu', ':<c-u>TablineSessionRestoreAll<cr>', { silent = true })

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  event = { 'WinEnter', 'VimResized', 'FocusLost' },
  cmd = { 'TablineSessionRestoreProjects', 'TablineSessionRestoreAll', },
  dependencies = {
    "dbakker/vim-projectroot",
    config = function()
      vim.g.rootmarkers = {
        ".cache",
        "build",
        "compile_commands.json",
        "CMakeLists.txt",
        ".git",
      }
    end
  },
}
