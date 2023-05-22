G = vim.g
F = vim.fn
C = vim.cmd
A = vim.api
M = vim.keymap.set

local o = { silent = true }

-- alt_num

M('n', '<alt-1>', '<nop>', o)
M('n', '<alt-2>', '<nop>', o)
M('n', '<alt-3>', '<nop>', o)
M('n', '<alt-4>', '<nop>', o)
M('n', '<alt-5>', '<nop>', o)
M('n', '<alt-6>', '<nop>', o)
M('n', '<alt-7>', '<nop>', o)
M('n', '<alt-8>', '<nop>', o)
M('n', '<alt-9>', '<nop>', o)
M('n', '<alt-0>', '<nop>', o)

-- change_cwd

M({ 'n', 'v' }, 'c.', ':try|cd %:h|ec getcwd()|catch|endtry<cr>', o)
M({ 'n', 'v' }, 'cu', ':try|cd ..|ec getcwd()|catch|endtry<cr>', o)
M({ 'n', 'v' }, 'c-', ':try|cd -|ec getcwd()|catch|endtry<cr>', o)

-- copy_pase

M({ 'n', 'v' }, '<a-y>', '"+y')
M({ 'n', 'v' }, '<a-p>', '"+p')
M({ 'n', 'v' }, '<a-s-p>', '"+P')

M({ 'c', 'i' }, '<a-w>', '<c-r>=g:word<cr>')
M({ 'c', 'i' }, '<a-v>', '<c-r>"')
M({ 't',     }, '<a-v>', '<c-\\><c-n>pi')
M({ 'c', 'i' }, '<a-=>', '<c-r>+')
M({ 't',     }, '<a-=>', '<c-\\><c-n>"+pi')
M({ 'n', 'v' }, '<a-z>', '"zy')
M({ 'c', 'i' }, '<a-z>', '<c-r>z')
M({ 't',     }, '<a-z>', '<c-\\><c-n>"zpi')

M({ 'n', 'v' }, '<leader>y', '<esc>:let @+ = expand("%:t")<cr>')
M({ 'n', 'v' }, '<leader>gy', '<esc>:let @+ = substitute(nvim_buf_get_name(0), "/", "\\\\", "g")<cr>')
M({ 'n', 'v' }, '<leader><leader>gy', '<esc>:let @+ = substitute(getcwd(), "/", "\\\\", "g")<cr>')

local buf_leave = function()
  G.word = F.expand('<cword>')
end

A.nvim_create_autocmd({ "BufLeave", "CmdlineEnter" }, {
  callback = buf_leave,
})

-- cursor

M({ 'n', 'v', }, '<c-j>', '5j')
M({ 'n', 'v', }, '<c-k>', '5k')

M({ 't', 'c', 'i' }, '<a-k>', '<UP>')
M({ 't', 'c', 'i' }, '<a-j>', '<DOWN>')
M({ 't', 'c', 'i' }, '<a-s-k>', '<UP><UP><UP><UP><UP>')
M({ 't', 'c', 'i' }, '<a-s-j>', '<DOWN><DOWN><DOWN><DOWN><DOWN>')
M({ 't', 'c', 'i' }, '<a-i>', '<HOME>')
M({ 't', 'c', 'i' }, '<a-s-i>', '<HOME>')
M({ 't', 'c', 'i' }, '<a-o>', '<END>')
M({ 't', 'c', 'i' }, '<a-s-o>', '<END>')
M({ 't', 'c', 'i' }, '<a-l>', '<RIGHT>')
M({ 't', 'c', 'i' }, '<a-h>', '<LEFT>')
M({ 't', 'c', 'i' }, '<a-s-l>', '<c-RIGHT>')
M({ 't', 'c', 'i' }, '<a-s-h>', '<c-LEFT>')

M('v', '<c-l>', 'L')
M('v', '<c-h>', 'H')
M('v', '<c-g>', 'G')
M('v', '<c-m>', 'M')
M('v', '<c-u>', 'U')

-- esc

M('v', 'm', '<esc>')

M({ 'i', 'c', }, 'ql', '<esc><esc>')
M({ 'i', 'c', }, 'qL', '<esc><esc>')
M({ 'i', 'c', }, 'Ql', '<esc><esc>')
M({ 'i', 'c', }, 'QL', '<esc><esc>')

M( 't', 'ql', '<c-\\><c-n>')
M( 't', 'qL', '<c-\\><c-n>')
M( 't', 'Ql', '<c-\\><c-n>')
M( 't', 'QL', '<c-\\><c-n>')

M({ 'i', 'c' }, '<a-m>', '<esc><esc>')
M({ 't',     }, '<esc>', '<c-\\><c-n>')
M({ 't',     }, '<a-m>', '<c-\\><c-n>')

-- f5

M({ 'n', 'v' }, '<f5>', '<cmd>:e!<cr>', o)

-- key

M({ 'n', 'v' }, '<leader>M', 'M', o) -- 可用C代替
M({ 'n', 'v' }, 'M', 's', o)
M({ 'n', 'v' }, '<leader>F', 'F', o)
M({ 'n', 'v' }, 'F', 'f', o)

-- mouse

M({ 'n', 'v', 'i' }, '<rightmouse>', '<leftmouse>', o)
M({ 'n', 'v', 'i' }, '<rightrelease>', '<nop>', o)
M({ 'n', 'v', 'i' }, '<middlemouse>', '<nop>', o)

-- record

M({ 'n', 'v' }, 'q', '<nop>', o)
M({ 'n', 'v' }, 'Q', 'q', o)

-- source

M({ 'n', 'v' }, '<leader>f.', ':if (&ft == "vim" || &ft == "lua") | source %:p | endif<cr>', o)

-- undo

M('n', 'U', '<c-r>', o)
