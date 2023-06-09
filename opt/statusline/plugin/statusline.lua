vim.fn['statusline#watch']()

vim.api.nvim_create_autocmd({ 'RecordingEnter','RecordingLeave', 'BufEnter', 'WinEnter', 'VimResized', 'WinResized', }, {
  callback = function()
    vim.fn['statusline#watch']()
  end,
})

local timer = vim.loop.new_timer()
timer:start(1000, 1000, function()
  vim.schedule(function()
    vim.opt.ro = vim.opt.ro:get()
  end)
end)

local light = require("nvim-web-devicons-light")

local by_filename = light.icons_by_filename

Colors = {}

for _, v in pairs(by_filename) do
  table.insert(Colors, v['color'])
end

MyHi = {
  "MyHiLiBufNr",
  "MyHiLiDate",
  "MyHiLiTime",
  "MyHiLiWeek",
  "MyHiLiFnameHead",
  "MyHiLiFileType",
  "MyHiLiFileFormat",
  "MyHiLiFileEncoding",
  "MyHiLiLineCol",
  "MyHiLiBotTop",
  "MyHiLiCwd",
  "MyHiLiMem",
  "MyHiLiRecoding",
}

local statuslinecolor = function()
  for _, hiname in ipairs(MyHi) do
    local color = Colors[math.random(#Colors)]
    local opt = { fg = color }
    vim.api.nvim_set_hl(0, hiname, opt)
  end
  vim.cmd[[
    hi MyHiLiInActive          gui=NONE guifg=#3a3a3a guibg=NONE
    hi MyHiLiFnameTailActive   gui=bold guifg=#ff9933 guibg=NONE
    hi MyHiLiFnameTailInActive gui=NONE guifg=#996633 guibg=NONE
    hi MyHiLiBranchName        gui=bold guifg=#77e4a2 guibg=NONE
    hi StatusLine              gui=NONE guibg=NONE guifg=NONE
    hi StatusLineNC            gui=NONE guibg=NONE guifg=gray
  ]]
end

vim.api.nvim_create_autocmd({ 'ColorScheme', }, {
  callback = function()
    statuslinecolor()
  end,
})

statuslinecolor()
