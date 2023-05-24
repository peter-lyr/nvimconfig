local lasttab = 0

local space_enter = function()
  if lasttab ~= 0 then
    pcall(vim.cmd, "tabn " .. lasttab)
  end
end

vim.api.nvim_create_autocmd({ "TabLeave" }, {
  callback = function()
    lasttab = vim.fn['tabpagenr']()
  end
})

-- mappings

-- '<,'>s/vim\.keymap\.set(\([^}]\+},\) *\([^,]\+,\) *\([^,]\+,\) *\([^)]\+\))/\=printf("vim.keymap.set(%-20s %-24s %-64s %s)", submatch(1), submatch(2), submatch(3), submatch(4))
vim.keymap.set({ 'n', 'v', },       '<leader><f1>',          '1gt',                                                           { silent = true })
vim.keymap.set({ 'n', 'v', },       '<leader><f2>',          '2gt',                                                           { silent = true })
vim.keymap.set({ 'n', 'v', },       '<leader><f3>',          '3gt',                                                           { silent = true })
vim.keymap.set({ 'n', 'v', },       '<leader><f4>',          '4gt',                                                           { silent = true })
vim.keymap.set({ 'n', 'v', },       '<leader><f5>',          '5gt',                                                           { silent = true })
vim.keymap.set({ 'n', 'v', },       '<leader><f6>',          '6gt',                                                           { silent = true })
vim.keymap.set({ 'n', 'v', },       '<leader><f7>',          '7gt',                                                           { silent = true })
vim.keymap.set({ 'n', 'v', },       '<leader><f8>',          '8gt',                                                           { silent = true })
vim.keymap.set({ 'n', 'v', },       '<leader><f9>',          '9gt',                                                           { silent = true })
vim.keymap.set({ 'n', 'v', },       '<leader><f10>',         '10gt',                                                          { silent = true })
vim.keymap.set({ 'n', 'v', },       '<leader><f11>',         '11gt',                                                          { silent = true })
vim.keymap.set({ 'n', 'v', },       '<leader><f12>',         '<cmd>:tablast<cr>',                                             { silent = true })

vim.keymap.set({ 'n', 'v', },       '<leader><cr>',          space_enter,                                                     { silent = true })

vim.keymap.set({ 'n', 'v' },        '<cr>',                  ':<c-u>tabnext<cr>',                                             { silent = true })
vim.keymap.set({ 'n', 'v' },        '<s-cr>',                ':<c-u>tabprevious<cr>',                                         { silent = true })

vim.keymap.set({ 'n', 'v', },       '<c-s-h>',               ':<c-u>try <bar> tabmove - <bar> catch <bar> endtry<cr>',        { silent = true })
vim.keymap.set({ 'n', 'v', },       '<c-s-l>',               ':<c-u>try <bar> tabmove + <bar> catch <bar> endtry<cr>',        { silent = true })
