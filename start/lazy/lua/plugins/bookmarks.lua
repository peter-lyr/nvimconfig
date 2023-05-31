local patterns = {
  ".cache",
  "build",
  "compile_commands.json",
  "CMakeLists.txt",
  ".git",
}

return {
  'tomasky/bookmarks.nvim',
  lazy = true,
  event = { 'FocusLost', },
  keys = {
    "mm",
    "mi",
    "mc",
    "ms",
    "mw",
    "ml",
    "<a-m>",
  },
  dependencies = {
    'nvim-telescope/telescope.nvim',
    {
      "dbakker/vim-projectroot",
      config = function()
        vim.g.rootmarkers = patterns
      end
    },
  },
  config = function()
    require('config.bookmarks')
  end,
}
