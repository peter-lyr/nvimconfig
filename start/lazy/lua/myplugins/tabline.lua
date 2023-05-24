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
    '<leader>bU',
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
        require("project_nvim").setup({
          manual_mode = false,
          datapath = vim.fn['expand']("$VIMRUNTIME") .. "\\my-neovim-data",
          detection_methods = { "pattern", "lsp" },
          patterns = patterns,
        })
      end
    },
  },
}
