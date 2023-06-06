-- '<,'>s/vim\.keymap\.set(\([^}]\+},\) *\([^,]\+,\) *\([^,]\+,\) *\([^)]\+\))/\=printf("vim.keymap.set(%-20s %-24s %-40s %s)", submatch(1), submatch(2), submatch(3), submatch(4))

vim.keymap.set({ 'n', 'v', 'i' },   '<C-ScrollWheelDown>',   ':<c-u>call fontSize#change(-1)<cr>',    { silent = true })
vim.keymap.set({ 'n', 'v', 'i' },   '<C-ScrollWheelUp>',     ':<c-u>call fontSize#change(1)<cr>',     { silent = true })
vim.keymap.set({ 'n', 'v', 'i' },   '<C-MiddleMouse>',       ':<c-u>call fontSize#change(0)<cr>',     { silent = true })

vim.keymap.set({ 'n', 'v', 'i' },   '<c-9>',                 ':<c-u>call fontSize#change(-2)<cr>',    { silent = true })
vim.keymap.set({ 'n', 'v', 'i' },   '<c-->',                 ':<c-u>call fontSize#change(-1)<cr>',    { silent = true })
vim.keymap.set({ 'n', 'v', 'i' },   '<c-0>',                 ':<c-u>call fontSize#change(0)<cr>',     { silent = true })
vim.keymap.set({ 'n', 'v', 'i' },   '<c-=>',                 ':<c-u>call fontSize#change(1)<cr>',     { silent = true })

vim.keymap.set({ 'n', 'v', 'i' },   '<c-s-k>',               ':<c-u>call fontSize#full()<cr>',        { silent = true })
