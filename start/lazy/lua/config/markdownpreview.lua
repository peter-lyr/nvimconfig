local p = require("plenary.path")
local pp = p:new(vim.g.boot_lua):parent():parent():joinpath('lua', 'config')

vim.g.mkdp_markdown_css = pp:joinpath('mkdp_markdown.css').filename
vim.g.mkdp_theme = 'light'
vim.g.mkdp_auto_close = 0

vim.keymap.set({ 'n', 'v' }, '<f3><f3>', ":<c-u>MarkdownPreviewToggle<cr>", { silent = true })
