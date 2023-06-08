local Path = require("plenary.path")

local datapath = Path:new(vim.fn.expand("$VIMRUNTIME") .. "\\my-neovim-data")

if not datapath:exists() then
  vim.fn.mkdir(datapath.filename)
end

local sessionpath = datapath:joinpath("Session")
if not sessionpath:exists() then
  vim.fn.mkdir(sessionpath.filename)
end

local session = sessionpath:joinpath("session_cwd_branch_fname.txt")
if not session:exists() then
  session:touch()
end

local newcnt = 0

local getbuffers = function()
  local fname
  local fpath
  local cwd
  local branch
  local new = {}
  newcnt = 0
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.fn.buflisted(bufnr) == 0 or vim.api.nvim_buf_is_loaded(bufnr) == false then
      goto continue
    end
    if vim.fn.getbufvar(bufnr, '&readonly') == 1 then
      goto continue
    end
    fname = string.gsub(vim.api.nvim_buf_get_name(bufnr), '\\', '/')
    fname = vim.fn.tolower(fname)
    if #fname == 0 then
      goto continue
    end
    fpath = Path:new(fname)
    if fpath:exists() ~= true or fpath:is_dir() then
      goto continue
    end
    vim.fn['gitbranch#detect'](fpath:parent().filename)
    cwd = vim.fn['projectroot#get'](fname)
    if #cwd == 0 then
      cwd = '-'
      branch = '-'
    else
      branch = vim.fn['gitbranch#name']()
    end
    newcnt = newcnt + 1
    if not vim.tbl_contains(vim.tbl_keys(new), cwd) then
      local f1 = { fname }
      local b1 = {}
      b1[branch] = f1
      new[cwd] = b1
    else
      if not vim.tbl_contains(vim.tbl_keys(new[cwd]), branch) then
        new[cwd][branch] = { fname }
      else
        table.insert(new[cwd][branch], fname)
      end
    end
    ::continue::
  end
  return new
end

local savesession = function()
  local old = loadstring('return ' .. session:read())()
  local new = getbuffers()
  if old then
    for cwd, v1 in pairs(old) do
      if not vim.tbl_contains(vim.tbl_keys(new), cwd) then
        new[cwd] = v1
      else
        for branch, fnames in pairs(v1) do
          if not vim.tbl_contains(vim.tbl_keys(new[cwd]), branch) then
            new[cwd][branch] = fnames
            -- else
            --   for _, fname in ipairs(fnames) do
            --     if not vim.tbl_contains(new[cwd][branch], fname) then
            --       table.insert(new[cwd][branch], fname)
            --       print("fname:", vim.inspect(fname))
            --     end
            --   end
          end
        end
      end
    end
  end
  local newcontent = tostring(vim.inspect(new))
  session:write(newcontent, 'w')
  print('save ' .. #vim.tbl_keys(new) .. ' cwd, ' .. newcnt .. ' opened files')
end

local bwande = function(cwd, fnames)
  cwd = vim.fn.tolower(cwd)
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local fname = string.gsub(vim.api.nvim_buf_get_name(bufnr), '\\', '/')
    local curcwd = vim.fn['projectroot#get'](fname)
    curcwd = vim.fn.tolower(curcwd)
    if curcwd == cwd then
      local fpath = Path:new(fname)
      if not fpath:is_dir() then
        if not vim.tbl_contains(fnames, fname) then
          vim.cmd('bw! ' .. fname)
        end
      end
    end
  end
  for _, fname in ipairs(fnames) do
    vim.cmd('e ' .. fname)
  end
  vim.fn['tabline#restorehidden']()
end

local loadsession = function()
  local cwds = loadstring('return ' .. session:read())()
  local ok = nil
  for k, _ in pairs(cwds) do
    if k ~= '-' and not Path:new(k):exists() then
      cwds[k] = nil
      ok = 1
    end
  end
  if ok then
    session:write(vim.inspect(cwds), 'w')
  end
  vim.ui.select(vim.fn.sort(vim.tbl_keys(cwds)), { prompt = 'cwd' }, function(cwd, _)
    local branches = cwds[cwd]
    if #vim.tbl_keys(branches) == 1 then
      for _, fnames in pairs(branches) do
        bwande(cwd, fnames)
      end
    else
      vim.ui.select(vim.fn.sort(vim.tbl_keys(branches)), { prompt = 'branch' }, function(branch, _)
        local fnames = branches[branch]
        bwande(cwd, fnames)
      end)
    end
  end)
end

local deletesession = function()
  local cwds = loadstring('return ' .. session:read())()
  vim.ui.select(vim.fn.sort(vim.tbl_keys(cwds)), { prompt = 'cwd' }, function(cwd, _)
    cwds[cwd] = nil
    session:write(vim.inspect(cwds), 'w')
  end)
end

-- mappings

vim.keymap.set({ 'n', 'v' }, '<leader>bi', function()
  savesession()
  vim.fn['tabline#savesession']()
end, { silent = true })

vim.keymap.set({ 'n', 'v' }, '<leader>bu', loadsession, { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>b<del>', deletesession, { silent = true })
