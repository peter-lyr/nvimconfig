local p = require("plenary.path")

local pp = p:new(vim.g.boot_lua):parent():parent():parent():parent():joinpath('opt', 'markdown2pdfhtmldocx', 'autoload')
local markdown2pdfhtmldocx_py = pp:joinpath('main.py').filename
local markdown2pdfhtmldocx_recyclebin_exe = pp:joinpath('recyclebin.exe').filename

local filetypes = {
  'pdf',
  'html',
  'docx',
}

local scandir = function(directory)
  local files = {}
  local result = require("plenary.scandir").scan_dir(directory, { depth = 1, hidden = 1 })
  for _, file in ipairs(result) do
    local extension = file:gsub("^.*%.([^.]+)$", "%1")
    if vim.tbl_contains(filetypes, extension) == true then
      table.insert(files, file)
    end
  end
  return files
end

local get_dname = function(readablefile)
  if #readablefile == 0 then
    return ''
  end
  local fname = string.gsub(readablefile, "\\", '/')
  local path = p:new(fname)
  if path:is_file() then
    return path:parent()['filename']
  end
  return ''
end

vim.keymap.set({ 'n', 'v' }, '<F3>i', function()
  TerminalSend('cmd', 'python ' .. markdown2pdfhtmldocx_py .. ' ' .. vim.api.nvim_buf_get_name(0))
end,  { silent = true })

vim.keymap.set({ 'n', 'v' }, '<F3>o', function()
  local curdir = get_dname(vim.api.nvim_buf_get_name(0))
  local files = scandir(curdir)
  local cnt = 0
  for _, v in ipairs(files) do
    cnt = cnt + 1
    local curcmd = markdown2pdfhtmldocx_recyclebin_exe .. ' "' .. v .. '"'
    vim.fn.system(curcmd)
  end
  print('delete', cnt, 'file(s)')
end,  { silent = true })
