return {
  'kdheepak/lazygit.nvim',
  lazy = true,
  keys = {
    '<a-g>',
  },
  config = function()
    -- require('config.lazygit')
    require("telescope").load_extension("lazygit")
    vim.keymap.set({ 'n', 'v' }, '<a-g>', ':<c-u>Spectre<cr><cr>', { silent = true })
  end,
}
