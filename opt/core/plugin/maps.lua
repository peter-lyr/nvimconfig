local o = { silent = true }

-- alt_num

vim.keymap.set('n', '<alt-1>', '<nop>', o)
vim.keymap.set('n', '<alt-2>', '<nop>', o)
vim.keymap.set('n', '<alt-3>', '<nop>', o)
vim.keymap.set('n', '<alt-4>', '<nop>', o)
vim.keymap.set('n', '<alt-5>', '<nop>', o)
vim.keymap.set('n', '<alt-6>', '<nop>', o)
vim.keymap.set('n', '<alt-7>', '<nop>', o)
vim.keymap.set('n', '<alt-8>', '<nop>', o)
vim.keymap.set('n', '<alt-9>', '<nop>', o)
vim.keymap.set('n', '<alt-0>', '<nop>', o)

-- change_cwd

vim.keymap.set({ 'n', 'v' }, 'c.', ':try|cd %:h|ec getcwd()|catch|endtry<cr>', o)
vim.keymap.set({ 'n', 'v' }, 'cu', ':try|cd ..|ec getcwd()|catch|endtry<cr>', o)
vim.keymap.set({ 'n', 'v' }, 'c-', ':try|cd -|ec getcwd()|catch|endtry<cr>', o)

-- copy_pase

vim.keymap.set({ 'n', 'v' }, '<a-y>', '"+y')
vim.keymap.set({ 'n', 'v' }, '<a-p>', '"+p')
vim.keymap.set({ 'n', 'v' }, '<a-s-p>', '"+P')

vim.keymap.set({ 'c', 'i' }, '<a-w>', '<c-r>=g:word<cr>')
vim.keymap.set({ 'c', 'i' }, '<a-v>', '<c-r>"')
vim.keymap.set({ 't',     }, '<a-v>', '<c-\\><c-n>pi')
vim.keymap.set({ 'c', 'i' }, '<a-=>', '<c-r>+')
vim.keymap.set({ 't',     }, '<a-=>', '<c-\\><c-n>"+pi')
vim.keymap.set({ 'n', 'v' }, '<a-z>', '"zy')
vim.keymap.set({ 'c', 'i' }, '<a-z>', '<c-r>z')
vim.keymap.set({ 't',     }, '<a-z>', '<c-\\><c-n>"zpi')

vim.keymap.set({ 'n', 'v' }, '<leader>y', '<esc>:let @+ = expand("%:t")<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>gy', '<esc>:let @+ = substitute(nvim_buf_get_name(0), "/", "\\\\", "g")<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader><leader>gy', '<esc>:let @+ = substitute(getcwd(), "/", "\\\\", "g")<cr>')

local buf_leave = function()
  vim.g.word = vim.fn.expand('<cword>')
end

vim.api.nvim_create_autocmd({ "BufLeave", "CmdlineEnter" }, {
  callback = buf_leave,
})

-- cursor

vim.keymap.set({ 'n', 'v', }, '<c-j>', '5j')
vim.keymap.set({ 'n', 'v', }, '<c-k>', '5k')

vim.keymap.set({ 't', 'c', 'i' }, '<a-k>', '<UP>')
vim.keymap.set({ 't', 'c', 'i' }, '<a-j>', '<DOWN>')
vim.keymap.set({ 't', 'c', 'i' }, '<a-s-k>', '<UP><UP><UP><UP><UP>')
vim.keymap.set({ 't', 'c', 'i' }, '<a-s-j>', '<DOWN><DOWN><DOWN><DOWN><DOWN>')
vim.keymap.set({ 't', 'c', 'i' }, '<a-i>', '<HOME>')
vim.keymap.set({ 't', 'c', 'i' }, '<a-s-i>', '<HOME>')
vim.keymap.set({ 't', 'c', 'i' }, '<a-o>', '<END>')
vim.keymap.set({ 't', 'c', 'i' }, '<a-s-o>', '<END>')
vim.keymap.set({ 't', 'c', 'i' }, '<a-l>', '<RIGHT>')
vim.keymap.set({ 't', 'c', 'i' }, '<a-h>', '<LEFT>')
vim.keymap.set({ 't', 'c', 'i' }, '<a-s-l>', '<c-RIGHT>')
vim.keymap.set({ 't', 'c', 'i' }, '<a-s-h>', '<c-LEFT>')

vim.keymap.set('v', '<c-l>', 'L')
vim.keymap.set('v', '<c-h>', 'H')
vim.keymap.set('v', '<c-g>', 'G')
vim.keymap.set('v', '<c-m>', 'M')
vim.keymap.set('v', '<c-u>', 'U')

-- esc

vim.keymap.set('v', 'm', '<esc>')

vim.keymap.set({ 'i', 'c', }, 'ql', '<esc><esc>')
vim.keymap.set({ 'i', 'c', }, 'qL', '<esc><esc>')
vim.keymap.set({ 'i', 'c', }, 'Ql', '<esc><esc>')
vim.keymap.set({ 'i', 'c', }, 'QL', '<esc><esc>')

vim.keymap.set( 't', 'ql', '<c-\\><c-n>')
vim.keymap.set( 't', 'qL', '<c-\\><c-n>')
vim.keymap.set( 't', 'Ql', '<c-\\><c-n>')
vim.keymap.set( 't', 'QL', '<c-\\><c-n>')

vim.keymap.set({ 'i', 'c' }, '<a-m>', '<esc><esc>')
vim.keymap.set({ 't',     }, '<esc>', '<c-\\><c-n>')
vim.keymap.set({ 't',     }, '<a-m>', '<c-\\><c-n>')

-- f5

vim.keymap.set({ 'n', 'v' }, '<f5>', '<cmd>:e!<cr>', o)

-- mouse

vim.keymap.set({ 'n', 'v', 'i' }, '<rightmouse>', '<leftmouse>', o)
vim.keymap.set({ 'n', 'v', 'i' }, '<rightrelease>', '<nop>', o)
vim.keymap.set({ 'n', 'v', 'i' }, '<middlemouse>', '<nop>', o)

-- record

vim.keymap.set({ 'n', 'v' }, 'q', '<nop>', o)
vim.keymap.set({ 'n', 'v' }, 'Q', 'q', o)

-- source

vim.keymap.set({ 'n', 'v' }, '<leader>f.', ':if (&ft == "vim" || &ft == "lua") | source %:p | endif<cr>', o)

-- undo

vim.keymap.set('n', 'U', '<c-r>', o)
