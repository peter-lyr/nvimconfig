return {
  { "folke/lazy.nvim" },

  {
    "nvim-lua/plenary.nvim",
    -- lazy = true,
  },

  {
    "nvim-tree/nvim-web-devicons",
    -- lazy = true,
  },

  {
    "dstein64/vim-startuptime",
    lazy = true,
    cmd = "StartupTime",
  },

  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     math.randomseed(os.time())
  --     vim.cmd([[colorscheme tokyonight]])
  --   end,
  -- },

}
