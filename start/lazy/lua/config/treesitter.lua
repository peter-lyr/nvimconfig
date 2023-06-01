local parser_path = vim.fn.expand("$VIMRUNTIME") .. "\\my-neovim-data\\treesitter-parser"

vim.opt.runtimepath:append(parser_path)

require("nvim-treesitter.configs").setup({
  ensure_installed = {}, -- 'all',
  sync_install = false,
  auto_install = false,
  parser_install_dir = parser_path,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "qi",
      node_incremental = "qi",
      scope_incremental = "qu",
      node_decremental = "qo",
    },
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  matchup = {
    enable = true,
  },
})

vim.fn['timer_start'](200, require"rainbow.internal".defhl)

require("treesitter-context").setup()

require("match-up").setup()
