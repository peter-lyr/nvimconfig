return {
  'echasnovski/mini.bracketed',
  lazy = true,
  event = { 'CursorMoved', },
  config = function()
    require('mini.bracketed').setup({

      -- buffer     = { suffix = '', options = {} },
      -- comment    = { suffix = 'c', options = {} },
      -- conflict   = { suffix = 'x', options = {} },
      -- diagnostic = { suffix = 'd', options = {} },
      -- file       = { suffix = '', options = {} },
      -- indent     = { suffix = '', options = {} },
      -- jump       = { suffix = '', options = {} },
      -- location   = { suffix = '', options = {} },
      -- oldfile    = { suffix = '', options = {} },
      -- quickfix   = { suffix = '', options = {} },
      -- treesitter = { suffix = '', options = {} },
      -- undo       = { suffix = '', options = {} },
      -- window     = { suffix = '', options = {} },
      -- yank       = { suffix = '', options = {} },

      buffer     = { suffix = 'b', options = {} },
      comment    = { suffix = 'c', options = {} },
      conflict   = { suffix = 'x', options = {} },
      diagnostic = { suffix = 'd', options = {} },
      file       = { suffix = 'f', options = {} },
      indent     = { suffix = 'i', options = {} },
      jump       = { suffix = 'j', options = {} },
      location   = { suffix = 'l', options = {} },
      oldfile    = { suffix = 'o', options = {} },
      quickfix   = { suffix = 'q', options = {} },
      treesitter = { suffix = 't', options = {} },
      undo       = { suffix = 'u', options = {} },
      window     = { suffix = 'w', options = {} },
      yank       = { suffix = 'y', options = {} },

    })
  end,
}
