require("gitsigns").setup({
  -- current_line_blame = true,
  -- current_line_blame_opts = {
  --   delay = 120,
  -- },
})

-- '<,'>s/vim\.keymap\.set(\([^}]\+},\) *\([^,]\+,\) *\([^,]\+,\) *\([^)]\+\))/\=printf("vim.keymap.set(%-12s %-14s %-47s %s)", submatch(1), submatch(2), submatch(3), submatch(4))

vim.keymap.set({ 'n', 'v' }, '<leader>gr',  ':<c-u>Gitsigns reset_hunk<cr>',                { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>gR',  ':<c-u>Gitsigns reset_buffer<cr>',              { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>k',   ':<c-u>Gitsigns prev_hunk<cr>',                 { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>j',   ':<c-u>Gitsigns next_hunk<cr>',                 { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>gp',  ':<c-u>Gitsigns preview_hunk<cr>',              { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>gx',  ':<c-u>Gitsigns select_hunk<cr>',               { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>gd',  ':<c-u>Gitsigns diffthis<cr>',                  { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>gD',  ':<c-u>Gitsigns diffthis HEAD~1<cr>',           { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>gtd', ':<c-u>Gitsigns toggle_deleted<cr>',            { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>gtb', ':<c-u>Gitsigns toggle_current_line_blame<cr>', { silent = true })
