local name = "fontsize"

local patterns = {
  ".cache",
  "build",
  "compile_commands.json",
  "CMakeLists.txt",
  ".git",
}

return {
  name = name,
  dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. name,
  keys = {
    '<C-ScrollWheelDown>',
    '<C-ScrollWheelUp>',
    '<C-MiddleMouse>',

    '<c-9>',
    '<c-->',
    '<c-0>',
    '<c-=>',

    '<c-s-k>',
  },
  dependencies = {
    name = 'tabline',
    dir = vim.fn.expand('$VIMRUNTIME') .. '\\pack\\nvimconfig\\opt\\' .. 'tabline',
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
  },
}
