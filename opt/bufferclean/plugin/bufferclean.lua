local rep = function(path)
  path, _ = string.gsub(path, '/', '\\')
  return path
end

local run = function(params)
  if not params or #params == 0 then
    return
  end
  local cur_fname = rep(vim.api.nvim_buf_get_name(0))
  local cur_wnr = vim.fn.winnr()
  local ids = {}
  if params[1] == 'cur' then
    for wnr = 1, vim.fn.winnr('$') do
      if wnr ~= cur_wnr then
        local bnr = vim.fn.winbufnr(wnr)
        if vim.fn.getbufvar(bnr, '&buftype') ~= 'nofile' then
          local fname = rep(vim.api.nvim_buf_get_name(bnr))
          if cur_fname == fname then
            table.insert(ids, vim.fn.win_getid(wnr))
          end
        end
      end
    end
    for _, v in ipairs(ids) do
      vim.api.nvim_win_hide(v)
    end
  else
    local nms = {}
    for wnr = 1, vim.fn.winnr('$') do
      local bnr = vim.fn.winbufnr(wnr)
      if vim.fn.getbufvar(bnr, '&buftype') ~= 'nofile' then
        local fname = rep(vim.api.nvim_buf_get_name(bnr))
        if wnr ~= cur_wnr then
          if vim.tbl_contains(nms, fname) == true or cur_fname == fname then
            table.insert(ids, vim.fn.win_getid(wnr))
          end
        end
        if not vim.tbl_contains(nms, fname) == true then
          table.insert(nms, fname)
        end
      end
    end
    for _, v in ipairs(ids) do
      vim.api.nvim_win_hide(v)
    end
  end
end

vim.api.nvim_create_user_command('BuffercleaN', function(params)
  run(params['fargs'])
end, { nargs = '*', })
