vim.g.mapleader = " "

local pack = vim.fn.expand("$VIMRUNTIME") .. '\\pack\\'

local lazypath = pack .. "lazy\\start\\lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  vim.opt.rtp:prepend(lazypath)
end

local root = pack .. "lazy\\plugins"
local readme = pack .. "lazy\\readme"
local lockfile = pack .. "nvimconfig\\lazy-lock.json"

local sta, lazy = pcall(require, 'lazy')

if not sta then
  print(lazy)
  return
end

lazy.setup({
  spec = {
    { import = 'plugins' }
  },
  root = root,
  readme = {
    root = readme,
  },
  default = {
    lazy = true,
  },
  lockfile = lockfile,
  performance = {
    rtp = {
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "tarPlugin",
        "tohtml",
        "tutor",
        -- "zipPlugin",
      },
    },
  },
  checker = {
    enabled = false,
  },
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
