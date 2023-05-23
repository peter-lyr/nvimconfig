local name = "tabline"

vim.g.startuptime = os.time()

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  event = { 'WinEnter', 'VimResized', 'FocusLost' },
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
