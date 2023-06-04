local sha256 = require("sha2")
local p = require("plenary.path")

local pp = p:new(vim.g.boot_lua):parent():parent():parent():parent():joinpath('opt', 'markdownimage', 'autoload')
local get_clipboard_image_ps1 = pp:joinpath('GetClipboardImage.ps1').filename
local update_markdown_image_src_py = pp:joinpath('update_markdown_image_src.py').filename
local pipe_txt_path = p:new(vim.fn.expand('$TEMP')):joinpath('image_pipe.txt')

local human_readable_fsize = function(sz)
  if sz >= 1073741824 then
    sz = string.format("%.1f", sz / 1073741824.0) .. "G"
  elseif sz >= 10485760 then
    sz = string.format("%d", sz / 1048576) .. "M"
  elseif sz >= 1048576 then
    sz = string.format("%.1f", sz / 1048576.0) .. "M"
  elseif sz >= 10240 then
    sz = string.format("%d", sz / 1024) .. "K"
  elseif sz >= 1024 then
    sz = string.format("%.1f", sz / 1024.0) .. "K"
  else
    sz = sz
  end
  return sz
end

local rep = function(path)
  path, _ = string.gsub(path, '/', '\\')
  return path
end

local rep_reverse = function(path)
  path, _ = string.gsub(path, '\\', '/')
  return path
end

local replace = function(str)
  local arr = {}
  for _ in string.gmatch(str, "[^/]+") do
    table.insert(arr, "..")
  end
  return table.concat(arr, "/")
end

local getimage = function(sel_jpg)
  local fname = vim.api['nvim_buf_get_name'](0)
  local projectroot_path = p:new(vim.fn['projectroot#get'](fname))
  if projectroot_path.filename == '' then
    print('not projectroot:', fname)
    return false
  end
  local datetime = os.date("%Y%m%d-%H%M%S-")
  local imagetype = sel_jpg == 'sel_jpg' and 'jpg' or 'png'
  local image_name = vim.fn.input(string.format('Input %s image name (no extension needed!): ', imagetype), datetime)
  if #image_name == 0 then
    print('get image canceled!')
    return false
  end
  local ft = vim.opt.ft:get()
  local cur_winid = vim.fn.win_getid()
  local linenr = vim.fn.line('.')
  local absolute_image_dir_path = projectroot_path:joinpath('saved_images')
  if not absolute_image_dir_path:exists() then
    vim.fn.system(string.format('md "%s"', absolute_image_dir_path.filename))
    print("created ->", rep(absolute_image_dir_path.filename))
  end
  local only_image_name = image_name .. '.' .. imagetype
  local raw_image_path = absolute_image_dir_path:joinpath(only_image_name)
  if raw_image_path:exists() then
    print("existed:", rep(raw_image_path.filename))
    return false
  end
  pipe_txt_path:write('', 'w')
  local cmd = string.format('%s "%s" "%s" "%s"', get_clipboard_image_ps1, rep(raw_image_path.filename), sel_jpg,
    rep(pipe_txt_path.filename))
  TerminalSend('powershell', cmd, 0)
  local timer = vim.loop.new_timer()
  local timeout = 0
  timer:start(100, 100, function()
    vim.schedule(function()
      timeout = timeout + 1
      local pipe_content = pipe_txt_path:_read()
      local find = string.find(pipe_content, 'success')
      if find then
        timer:stop()
        local raw_image_data = raw_image_path:_read()
        print('save one image:', rep(raw_image_path.filename))
        local absolute_image_hash = sha256.sha256(raw_image_data)
        local _md_path = absolute_image_dir_path:joinpath('_.md')
        _md_path:write(
          string.format('![%s-(%d)%s{%s}](%s)\n', only_image_name, #raw_image_data,
            human_readable_fsize(#raw_image_data),
            absolute_image_hash, only_image_name), 'a')
        if ft ~= 'markdown' then
          return false
        end
        local projectroot = rep_reverse(projectroot_path.filename)
        local file_dir = rep_reverse(p:new(fname):parent().filename)
        local rel = string.sub(file_dir, #projectroot + 1, -1)
        rel = replace(rel)
        local image_rel_path
        if #rel > 0 then
          image_rel_path = rel .. '/saved_images/' .. only_image_name
        else
          image_rel_path = 'saved_images/' .. only_image_name
        end
        if cur_winid ~= vim.fn.win_getid() then
          vim.fn.win_gotoid(cur_winid)
        end
        vim.fn.append(linenr, string.format('![%s{%s}](%s)', only_image_name, absolute_image_hash, image_rel_path))
      end
      if timeout > 30 then
        print('get image timeout 3s')
        timer:stop()
      end
    end)
  end)
end

local get_saved_images_dirname = function(fname)
  local dir = p:new(fname):parent()
  local cnt = #dir.filename
  while 1 do
    cnt = #dir.filename
    local path = dir:joinpath('saved_images')
    if path:exists() then
      return dir.filename
    end
    dir = dir:parent()
    if cnt < #dir.filename then
      break
    end
  end
  return nil
end

local updatesrc = function()
  local fname = vim.api.nvim_buf_get_name(0)
  if #fname == 0 then
    print('no fname')
    return
  end
  local saved_images_dirname = get_saved_images_dirname(fname)
  if not saved_images_dirname then
    print('no saved_images dir')
    return
  end
  local cmd = string.format('python %s "%s" "%s"', rep_reverse(update_markdown_image_src_py),
    rep_reverse(saved_images_dirname), rep_reverse(fname))
  TerminalSend('cmd', cmd, 0)
end

local dragimage = function(sel_jpg, dragimagename)
  local fname = vim.api['nvim_buf_get_name'](0)
  local projectroot_path = p:new(vim.fn['projectroot#get'](fname))
  if projectroot_path.filename == '' then
    print([[not projectroot:]], fname)
    return false
  end
  local datetime = os.date("%Y%m%d-%H%M%S-")
  local imagetype = sel_jpg == 'sel_jpg' and 'jpg' or 'png'
  local image_name = vim.fn['input'](string.format('Input %s image name (no extension needed!): ', imagetype), datetime)
  if #image_name == 0 then
    print('get image canceled!')
    return false
  end
  local cur_winid = vim.fn.win_getid()
  local linenr = vim.fn.line('.')
  local absolute_image_dir_path = projectroot_path:joinpath('saved_images')
  if not absolute_image_dir_path:exists() then
    vim.fn.system(string.format('md "%s"', absolute_image_dir_path.filename))
    print("created ->", rep(absolute_image_dir_path.filename))
  end
  local only_image_name = image_name .. '.' .. imagetype
  local raw_image_path = absolute_image_dir_path:joinpath(only_image_name)
  if raw_image_path:exists() then
    print("existed:", rep(raw_image_path.filename))
    return false
  end
  vim.fn.system(string.format('copy "%s" "%s"', dragimagename, rep(raw_image_path.filename)))
  local raw_image_data = raw_image_path:_read()
  local absolute_image_hash = sha256.sha256(raw_image_data)
  local _md_path = absolute_image_dir_path:joinpath('_.md')
  _md_path:write(string.format('![%s-(%d)%s{%s}](%s)\n', only_image_name, #raw_image_data,
    human_readable_fsize(#raw_image_data), absolute_image_hash, only_image_name), 'a')
  local projectroot = rep_reverse(projectroot_path.filename)
  local file_dir = rep_reverse(p:new(fname):parent().filename)
  local rel = string.sub(file_dir, #projectroot + 1, -1)
  rel = replace(rel)
  local image_rel_path
  if #rel > 0 then
    image_rel_path = rel .. '/saved_images/' .. only_image_name
  else
    image_rel_path = 'saved_images/' .. only_image_name
  end
  if cur_winid ~= vim.fn.win_getid() then
    vim.fn.win_gotoid(cur_winid)
  end
  vim.fn.append(linenr, string.format('![%s{%s}](%s)', only_image_name, absolute_image_hash, image_rel_path))
  print(linenr, string.format('![%s{%s}](%s)', only_image_name, absolute_image_hash, image_rel_path))
end

vim.keymap.set({ 'n', 'v' }, '<f3>p', function() getimage('sel_png') end,  { silent = true })
vim.keymap.set({ 'n', 'v' }, '<f3>j', function() getimage('sel_jpg') end,  { silent = true })
vim.keymap.set({ 'n', 'v' }, '<f3>u', function() updatesrc() end,  { silent = true })

-- ===========================================================================================

local gobackbufnr
local lastbufnr
local getimagealways
local dragimagename
local cancelopen

local ft = {
  'jpg', 'png',
}

vim.api.nvim_create_autocmd({ 'BufReadPre' }, {
  callback = function()
    local cur_fname = vim.api.nvim_buf_get_name(0)
    local extension = string.match(cur_fname, '.+%.(%w+)$')
    if vim.tbl_contains(ft, extension) == true then
      local last_extension = vim.bo[lastbufnr].ft
      if last_extension == 'markdown' then
        local lastbufname = vim.api.nvim_buf_get_name(lastbufnr)
        local projectroot_path = p:new(vim.fn['projectroot#get'](lastbufname))
        if projectroot_path.filename == '' then
          gobackbufnr = lastbufnr
          cancelopen = true
          print('not projectroot:', lastbufname)
          print('cancelopen')
          return
        end
        if getimagealways then
          gobackbufnr = lastbufnr
        else
          local input = vim.fn.input('get image? [y(es)/a(lwayse)/o(pen)]: ', 'y')
          if vim.tbl_contains({ 'y', 'Y' }, input) == true then
            gobackbufnr = lastbufnr
          elseif vim.tbl_contains({ 'a', 'A' }, input) == true then
            gobackbufnr = lastbufnr
            getimagealways = true
          elseif input == '' then
            gobackbufnr = lastbufnr
            cancelopen = true
          end
        end
        dragimagename = cur_fname
      else
        getimagealways = nil
      end
    end
  end,
})

local sel_jpg = 'sel_png'

vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  callback = function()
    if gobackbufnr then
      local curbufnr = vim.fn.bufnr()
      vim.cmd('b' .. gobackbufnr)
      gobackbufnr = nil
      if cancelopen then
        cancelopen = nil
        vim.cmd('bw! ' .. curbufnr)
        return
      end
      if sel_jpg and vim.tbl_contains({ 'sel_png', 'sel_jpg' }, sel_jpg) == true then
        dragimage(sel_jpg, dragimagename)
        vim.cmd 'w!'
        vim.cmd('bw! ' .. curbufnr)
      else
        vim.ui.select({ 'sel_png', 'sel_jpg' }, { prompt = 'sel png or jpg' }, function(choice, _)
          local sel_jpg_tmp = choice
          dragimage(sel_jpg_tmp, dragimagename)
          vim.cmd 'w!'
          vim.cmd('bw! ' .. curbufnr)
        end)
      end

    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function()
    lastbufnr = vim.fn.bufnr()
  end,
})
