local f = require('config.nvimtree-func')

local wrap_node = function(fn)
  return function(node, ...)
    node = node or require("nvim-tree.lib").get_node_at_cursor()
    fn(node, ...)
  end
end

local others = function(bufnr)
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  vim.keymap.set('n', '<c-f9>', wrap_node(f.test)           , opts('test'))

  vim.keymap.set('n', '\''    , wrap_node(f.toggle_sel)     , opts('toggle_sel'))
  vim.keymap.set('n', '"'     , wrap_node(f.toggle_sel_up)  , opts('toggle_sel_up'))

  vim.keymap.set('n', 'dE'    , wrap_node(f.empty_sel)      , opts('empty_sel'))

  vim.keymap.set('n', 'dD'    , wrap_node(f.delete_sel)     , opts('delete_sel'))
  vim.keymap.set('n', 'dM'    , wrap_node(f.move_sel)       , opts('move_sel'))
  vim.keymap.set('n', 'dC'    , wrap_node(f.copy_sel)       , opts('copy_sel'))
  vim.keymap.set('n', 'dR'    , wrap_node(f.rename_sel)     , opts('rename_sel'))

  vim.keymap.set('n', 'dY'    , wrap_node(f.copy_2_clip)    , opts('copy_2_clip'))
  vim.keymap.set('n', 'dP'    , wrap_node(f.paste_from_clip), opts('paste_from_clip'))
end

local on_attach = function(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  -- '<,'>s/\(vim[^,]\+\), \([^,]\+\), \+\([^,]\+\), \+\(.\+\)/\=printf('%s, %-24s, %-60s, %s', submatch(1), submatch(2), submatch(3), submatch(4))
  vim.keymap.set('n', 'O'            , api.tree.change_root_to_node    , opts('CD'))
  vim.keymap.set('n', 'K'            , api.node.show_info_popup        , opts('Info'))
  vim.keymap.set('n', 'dk'           , api.node.open.tab               , opts('Open: New Tab'))
  vim.keymap.set('n', 'dl'           , api.node.open.vertical          , opts('Open: Vertical Split'))
  vim.keymap.set('n', 'dj'           , api.node.open.horizontal        , opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<BS>'         , api.node.navigate.parent_close  , opts('Close Directory'))
  vim.keymap.set('n', 'do'           , api.node.open.edit              , opts('Open'))
  vim.keymap.set('n', '<2-LeftMouse>', api.node.open.preview           , opts('Open'))
  vim.keymap.set('n', '<Tab>'        , api.node.open.preview           , opts('Open Preview'))
  vim.keymap.set('n', '>'            , api.node.navigate.sibling.next  , opts('Next Sibling'))
  vim.keymap.set('n', '<'            , api.node.navigate.sibling.prev  , opts('Previous Sibling'))
  vim.keymap.set('n', 'dx'           , api.node.run.cmd                , opts('Run Command'))
  vim.keymap.set('n', 'q'            , api.tree.change_root_to_parent  , opts('Up'))
  vim.keymap.set('n', 'db'           , api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
  vim.keymap.set('n', 'dg'           , api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
  vim.keymap.set('n', '<leader>k'    , api.node.navigate.git.prev      , opts('Prev Git'))
  vim.keymap.set('n', '<leader>j'    , api.node.navigate.git.next      , opts('Next Git'))
  vim.keymap.set('n', 'cc'           , api.fs.create                   , opts('Create'))
  vim.keymap.set('n', 'dc'           , api.fs.copy.node                , opts('Copy'))
  vim.keymap.set('n', 'D'            , api.fs.remove                   , opts('Delete'))
  vim.keymap.set('n', 'dp'           , api.fs.paste                    , opts('Paste'))
  vim.keymap.set('n', 'dx'           , api.fs.cut                      , opts('Cut'))
  vim.keymap.set('n', '<C-r>'        , api.fs.rename                   , opts('Rename'))
  vim.keymap.set('n', 'dr'           , api.fs.rename_sub               , opts('Rename: Omit Filename'))
  vim.keymap.set('n', 'r'            , api.fs.rename_basename          , opts('Rename: Basename'))
  vim.keymap.set('n', 'gy'           , api.fs.copy.absolute_path       , opts('Copy Absolute Path'))
  vim.keymap.set('n', 'Y'            , api.fs.copy.relative_path       , opts('Copy Relative Path'))
  vim.keymap.set('n', 'y'            , api.fs.copy.filename            , opts('Copy Name'))
  vim.keymap.set('n', 'pe'           , api.tree.expand_all             , opts('Expand All'))
  vim.keymap.set('n', 'F'            , api.live_filter.clear           , opts('Clean Filter'))
  vim.keymap.set('n', 'f'            , api.live_filter.start           , opts('Filter'))
  vim.keymap.set('n', '?'            , api.tree.toggle_help            , opts('Help'))
  vim.keymap.set('n', '.'            , api.tree.toggle_hidden_filter   , opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'I'            , api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  vim.keymap.set('n', '}'            , api.node.navigate.sibling.last  , opts('Last Sibling'))
  vim.keymap.set('n', '{'            , api.node.navigate.sibling.first , opts('First Sibling'))
  vim.keymap.set('n', 'P'            , api.node.navigate.parent        , opts('Parent Directory'))
  vim.keymap.set('n', '<CR>'         , api.node.open.no_window_picker  , opts('Open: No Window Picker'))
  vim.keymap.set('n', 'a'            , api.node.open.no_window_picker  , opts('Open: No Window Picker'))
  vim.keymap.set('n', 'o'            , api.node.open.no_window_picker  , opts('Open: No Window Picker'))
  vim.keymap.set('n', 'R'            , api.tree.reload                 , opts('Refresh'))
  vim.keymap.set('n', 'xs'           , api.node.run.system             , opts('Run System'))
  vim.keymap.set('n', 'pW'           , api.tree.collapse_all           , opts('Collapse'))
  vim.keymap.set('n', 'pw'           , function() api.tree.collapse_all(true) end, opts('Collapse'))
  others(bufnr)
  -- vim.keymap.set('n', 'q'                     , api.tree.close                                              , opts('Close'))
  -- vim.keymap.set('n', 'S'                     , api.tree.search_node                                        , opts('Search'))
  -- vim.keymap.set('n', 'U'                     , api.tree.toggle_custom_filter                               , opts('Toggle Hidden'))
  -- vim.keymap.set('n', '<2-RightMouse>'        , api.tree.change_root_to_node                                , opts('CD'))
  -- vim.keymap.set('n', ']d'                    , api.node.navigate.diagnostics.next                          , opts('Next Diagnostic'))
  -- vim.keymap.set('n', '[d'                    , api.node.navigate.diagnostics.prev                          , opts('Prev Diagnostic'))
  -- vim.keymap.set('n', 'm'                     , api.marks.toggle                                            , opts('Toggle Bookmark'))
end

require('nvim-tree').setup({
  on_attach = on_attach,
  remove_keymaps = true,
  view = {
    adaptive_size = 30,
  },
})

-- '<,'>s/vim\.keymap\.set(\([^}]\+},\) *\([^,]\+,\) *\([^,]\+,\) *\([^)]\+\))/\=printf("vim.keymap.set(%-20s %-24s %-64s %s)", submatch(1), submatch(2), submatch(3), submatch(4))

vim.keymap.set({ 'n', 'v' },        '<leader>;',             ':<c-u>NvimTreeToggle<cr>',                                      { silent = true })
vim.keymap.set({ 'n', 'v' },        '<leader>l',             ':<c-u>NvimTreeFindFileToggle<cr>',                              { silent = true })
vim.keymap.set({ 'n', 'v' },        '<leader><leader>l',     ':<c-u>NvimTreeOpen <c-r>=getcwd()<cr><cr>',                     { silent = true })
