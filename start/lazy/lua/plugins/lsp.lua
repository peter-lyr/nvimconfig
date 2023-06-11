local patterns = {
  ".cache",
  "build",
  "compile_commands.json",
  "CMakeLists.txt",
  ".git",
}

return {
  'neovim/nvim-lspconfig',
  lazy = true,
  event = { 'LspAttach', 'FocusLost', },
  dependencies = {
    'folke/neodev.nvim',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    {
      "dbakker/vim-projectroot",
      config = function()
        vim.g.rootmarkers = patterns
      end
    },
  },
  ft = {
    'c', 'cpp',
    'python',
    'md',
    'lua',
    'vim',
  },
  config = function()
    require('config.lsp')
  end,
}

