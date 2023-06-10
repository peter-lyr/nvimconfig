return {
  'simrat39/symbols-outline.nvim',
  lazy = true,
  event = { 'LspAttach', },
  config = function()
    require('config.symbolsoutline')
  end,
}
