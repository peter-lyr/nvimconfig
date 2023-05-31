local telescope = require('telescope')
local actions = require('telescope.actions')
local actions_layout = require('telescope.actions.layout')

vim.cmd([[
autocmd User TelescopePreviewerLoaded setlocal number | setlocal wrap
]])

local get_setup_table = function(file_ignore_patterns)
  return {
    defaults = {
      layout_strategy = 'horizontal',
      layout_config = {
        height = 0.99,
        width = 0.99,
      },
      -- preview = {
      --   hide_on_startup = true,
      -- },
      mappings = {
        i = {
          ['<a-m>'] = actions.close,
          ['qm'] = actions.close,
          ['<a-j>'] = actions.move_selection_next,
          ['<a-k>'] = actions.move_selection_previous,
          ['<a-;>'] = actions.send_to_qflist + actions.open_qflist,
          ['<c-j>'] = actions.select_horizontal,
          ['<c-l>'] = actions.select_vertical,
          ['<c-k>'] = actions.select_tab,
          ['<c-o>'] = actions.select_default,
          ['qo'] = actions.select_default,
          ['<a-,>'] = actions.select_default,
          ['<a-n>'] = actions_layout.toggle_preview,
          ['qj'] = function(prompt_bufnr)
            actions.move_selection_next(prompt_bufnr)
            vim.cmd([[call feedkeys("\<esc>")]])
          end,
          ['qk'] = function(prompt_bufnr)
            actions.move_selection_previous(prompt_bufnr)
            vim.cmd([[call feedkeys("\<esc>")]])
          end,
        },
        n = {
          ['ql'] = actions.close,
          ['qm'] = actions.close,
          ['<a-m>'] = actions.close,
          ['<a-j>'] = actions.move_selection_next,
          ['<a-k>'] = actions.move_selection_previous,
          ['<a-;>'] = actions.send_to_qflist + actions.open_qflist,
          ['<c-j>'] = actions.select_horizontal,
          ['<c-l>'] = actions.select_vertical,
          ['<c-k>'] = actions.select_tab,
          ['<c-o>'] = actions.select_default,
          ['o'] = actions.select_default,
          ['<a-,>'] = actions.select_default,
          ['w'] = actions_layout.toggle_preview,
        }
      },
      file_ignore_patterns = file_ignore_patterns,
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--fixed-strings',
      },
      wrap_results = false,
    },
  }
end

local add = function(t1, t2)
  for _, v in ipairs(t2) do
    table.insert(t1, v)
  end
  return t1
end

local t = {}

add(t, {
  '%.svn',
  '%.vs',
  '%.git',
  '%.cache',
  'obj',
  'build',
  'my%-neovim%-data',
  '%.js',
  '%.asc',
  '%.hex',
  'CMakeLists.txt',
})

-- add(t, {
--   'audio_lhdc',
--   'audio_test',
--   'MSVC',
-- })

-- add(t, {
--   'standard',
-- })

-- add(t, {
--   'map.txt',
--   '%.map',
--   '%.lst',
--   '%.S',
-- })

telescope.setup(get_setup_table(t))

telescope.load_extension("ui-select")

local do_telescope_lua = require("plenary.path"):new(vim.g.boot_lua):parent():parent():joinpath('lua', 'config', 'telescope.lua').filename

local open = function()
  vim.cmd('split')
  vim.cmd('e ' .. do_telescope_lua)
  vim.fn.search('telescope.setup' .. '(get_setup_table')
  vim.cmd([[call feedkeys("zb{{2j2w")]])
end

-- '<,'>s/vim\.keymap\.set(\([^}]\+},\) *\([^,]\+,\) *\([^,]\+,\) *\([^)]\+\))/\=printf("vim.keymap.set(%-12s %-10s %-54s %s)", submatch(1), submatch(2), submatch(3), submatch(4))

vim.keymap.set({ 'n', 'v' }, '<a-/>',   ':<c-u>Telescope search_history<cr>',                  { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-c>',   ':<c-u>Telescope command_history<cr>',                 { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-C>',   ':<c-u>Telescope commands<cr>',                        { silent = true })

vim.keymap.set({ 'n', 'v' }, '<a-o>',   ':<c-u>Telescope oldfiles previewer=false<cr>',        { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-k>',   ':<c-u>Telescope find_files previewer=false<cr>',      { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-j>',   ':<c-u>Telescope buffers cwd_only=true sort_mru=true ignore_current_buffer=true<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-J>',   ':<c-u>Telescope buffers<cr>',                         { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-;>e',  ':<c-u>Telescope empty_buffers<cr>',                   { silent = true })

vim.keymap.set({ 'n', 'v' }, '<a-;>k',  ':<c-u>Telescope git_files previewer=false<cr>',       { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-;>i',  ':<c-u>Telescope git_commits<cr>',                     { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-;>o',  ':<c-u>Telescope git_bcommits<cr>',                    { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-;>h',  ':<c-u>Telescope git_branches<cr>',                    { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-;>j',  ':<c-u>Telescope git_status previewer=false<cr>',      { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-;>l',  ':<c-u>Telescope git_diffs diff_commits<cr>',          { silent = true })

-- vim.keymap.set({ 'n', 'v' }, '<a-l>',   ':<c-u>Telescope live_grep shorten_path=true word_match=-w only_sort_text=true search= grep_open_files=true<cr>', { silent = true })
-- vim.keymap.set({ 'n', 'v' }, '<a-L>',   ':<c-u>Telescope live_grep<cr>',                       { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-l>',   ':<c-u>Telescope live_grep<cr>',                       { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-i>',   ':<c-u>Telescope grep_string shorten_path=true word_match=-w only_sort_text=true search= grep_open_files=true<cr>', { silent = true })

vim.keymap.set({ 'n', 'v' }, '<a-b>',   ':<c-u>Telescope lsp_document_symbols<cr>',            { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-.>',   ':<c-u>Telescope lsp_references<cr>',                  { silent = true })

vim.keymap.set({ 'n', 'v' }, '<a-q>',   ':<c-u>Telescope quickfix<cr>',                        { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-Q>',   ':<c-u>Telescope quickfixhistory<cr>',                 { silent = true })

vim.keymap.set({ 'n', 'v' }, '<a-\'>a', ':<c-u>Telescope builtin<cr>',                         { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-\'>c', ':<c-u>Telescope colorscheme<cr>',                     { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-\'>d', ':<c-u>Telescope diagnostics<cr>',                     { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-\'>f', ':<c-u>Telescope filetypes<cr>',                       { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-\'>h', ':<c-u>Telescope help_tags<cr>',                       { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-\'>j', ':<c-u>Telescope jumplist<cr>',                        { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-\'>m', ':<c-u>Telescope keymaps<cr>',                         { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-\'>o', ':<c-u>Telescope vim_options<cr>',                     { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-\'>p', ':<c-u>Telescope planets<cr>',                         { silent = true })
vim.keymap.set({ 'n', 'v' }, '<a-\'>z', ':<c-u>Telescope current_buffer_fuzzy_find<cr>',       { silent = true })

vim.keymap.set({ 'n', 'v' }, '<a-\\>',  open,                                                  { silent = true })
