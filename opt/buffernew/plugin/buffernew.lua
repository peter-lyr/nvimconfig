local buffernew = require('buffernew')

vim.api.nvim_create_user_command('BufferneW', function(params)
  buffernew.run(params['fargs'])
end, { nargs = '*', })
