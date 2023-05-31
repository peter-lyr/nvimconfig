return {
  'preservim/nerdcommenter',
  lazy = true,
  event = { 'CursorMoved', },
  config = function()
    require('config.commenter')
  end,
}
