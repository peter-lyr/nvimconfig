return {
  "luukvbaal/statuscol.nvim",
  lazy = true,
  event = { 'FocusLost', 'CursorMoved', },
  config = function()
    require('config.statuscol')
  end,
}
