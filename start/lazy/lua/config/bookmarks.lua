local actions = require "bookmarks.actions"
local bm = require("bookmarks")

local rep = function(path)
  path, _ = string.gsub(path, '\\', '/')
  return path
end

local fn = function(f)
  f()
  actions.saveBookmarks()
end

local setup = function()
  local curcwd = vim.fn.tolower(rep(vim.fn['projectroot#get'](vim.api.nvim_buf_get_name(0))))
  local path = (#curcwd > 0 and curcwd or vim.fn.expand("$HOME")) .. "/.bookmarks"
  require('bookmarks').setup({
    -- sign_priority = 8,  --set bookmark sign priority to cover other sign
    save_file = path, -- bookmarks save file path
    keywords = {
      ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
      ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
      ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
      ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
    },
    on_attach = function(bufnr)
      if vim.api.nvim_buf_is_valid(bufnr) == false or vim.fn.filereadable(vim.api.nvim_buf_get_name(bufnr)) == 0 then
        pcall(vim.keymap.del, "n", "mm")
        pcall(vim.keymap.del, "n", "mi")
        pcall(vim.keymap.del, "n", "mc")
        pcall(vim.keymap.del, "n", "ms")
        pcall(vim.keymap.del, "n", "mw")
        pcall(vim.keymap.del, "n", "ml")
        return
      end
      actions.refresh()
      vim.keymap.set("n", "mm", function() fn(bm.bookmark_toggle) end) -- add or remove bookmark at current line
      vim.keymap.set("n", "mi", function() fn(bm.bookmark_ann) end)    -- add or edit mark annotation at current line
      vim.keymap.set("n", "mc", function() fn(bm.bookmark_clean) end)  -- clean all marks in local buffer
      vim.keymap.set("n", "ms", bm.bookmark_next)                      -- jump to next mark in local buffer
      vim.keymap.set("n", "mw", bm.bookmark_prev)                      -- jump to previous mark in local buffer
      vim.keymap.set("n", "ml", bm.bookmark_list)                      -- show marked file list in quickfix window
    end
  })
  vim.fn.timer_start(200, function() actions.refresh() end)
end

vim.api.nvim_create_autocmd({ 'BufEnter', }, {
  callback = setup
})

setup()

require('telescope').load_extension('bookmarks')

local _ = function()
  -- vim.cmd('Telescope bookmarks list')
  -- vim.cmd([[call feedkeys("\<esc>\<esc>")]])
  vim.keymap.set({ 'n', 'v' }, '<a-m>', ':<c-u>Telescope bookmarks list<cr>', { silent = true })
  vim.fn.timer_start(50, function() vim.cmd([[call feedkeys(":Telescope bookmarks list\<cr>")]]) end)
end

vim.keymap.set({ 'n', 'v' }, '<a-m>', _, { silent = true })
