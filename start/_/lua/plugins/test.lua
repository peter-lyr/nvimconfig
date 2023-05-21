return {
  -- plugin manager itself
  { "folke/lazy.nvim" },

  -- useful lua functions
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  {
    "kyazdani42/nvim-web-devicons",
    lazy = true,
  },

  {
    "dstein64/vim-startuptime",
    lazy = true,
    cmd = "StartupTime",
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
