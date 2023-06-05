local name = "tabline"

local patterns = {
  ".cache",
  "build",
  "compile_commands.json",
  "CMakeLists.txt",
  ".git",
}

vim.g.startuptime = os.time()

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  event = { 'FocusLost', 'WinEnter', 'VimResized', },
  keys = {
    '<leader>xa',
    '<leader>xf',
    '<leader>xh',
    '<leader>xl',
    '<leader>xo',

    '<leader>bp',
    '<leader>bP',

    '<leader>be',

    '<leader>bo',

    '<leader>b<',
    '<leader>b>',

    '<leader>bi',
    '<leader>bu',
  },
  dependencies = {
    {
      "dbakker/vim-projectroot",
      config = function()
        vim.g.rootmarkers = patterns
      end
    },
    {
      'ahmedkhalf/project.nvim',
      config = function()
        require('config.telescope-projects')
      end
    },
  },
}

