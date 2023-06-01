local builtin = require("statuscol.builtin")

local function setup()
  require("statuscol").setup({
    bt_ignore = { "terminal", "nofile" },
    relculright = true,
    segments = {
      { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
      {
        sign = { name = { "Diagnostic" }, maxwidth = 2, colwidth = 1, auto = true },
        click = "v:lua.ScSa"
      },
      {
        sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, wrap = true, auto = true },
        click = "v:lua.ScSa"
      },
      { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
      -- {text = {"│"}}
    },
  })
end

setup()

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function()
    setup()
  end,
})
