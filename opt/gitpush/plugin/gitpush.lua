local p = require("plenary.path")

local gitpush_path = p:new(vim.fn.expand('<sfile>')):parent():parent()

local git_init = gitpush_path:joinpath('autoload', 'git_init.bat').filename

local rep = function(path)
  path, _ = string.gsub(path, '\\', '/')
  return path
end

local get_fname_tail = function(fname)
  fname = rep(fname)
  local fpath = p:new(fname)
  if fpath:is_file() then
    fname = fpath:_split()
    return fname[#fname]
  elseif fpath:is_dir() then
    fname = fpath:_split()
    if #fname[#fname] > 0 then
      return fname[#fname]
    else
      return fname[#fname - 1]
    end
  end
  return ''
end

local cmd = ''
local cmd2 = ''
local prompt = ''
local prompt2 = ''
local dir = ''

local run = function(params)
  if not params or #params == 0 then
    return
  end
  local cc = ''
  cmd = params[1]
  if cmd == "add_commit" then
    prompt = 'commit info (Add all and commit): '
    prompt2 = 'Sure to add all and commit? (Empty for yes): '
    cmd2 = 'AsyncRun cd %s && git add -A && git status && git commit -m "%s"'
  elseif cmd == "add_commit_push" then
    prompt = 'commit info (Add all and push): '
    prompt2 = 'Sure to add all and push? (Empty for yes): '
    cmd2 = 'AsyncRun cd %s && git add -A && git status && git commit -m "%s" && git push'
  elseif cmd == "commit_push" then
    prompt = 'commit info (Just push): '
    prompt2 = 'Sure to just push? (Empty for yes): '
    cmd2 = 'AsyncRun cd %s && git commit -m "%s" && git push'
  elseif cmd == "git_init" then
    cc = git_init
  elseif cmd == "just_commit" then
    prompt = 'commit info (Just commit): '
    prompt2 = 'Sure to just commit? (Empty for yes): '
    cmd2 = 'AsyncRun cd %s && git commit -m "%s"'
  elseif cmd == "just_push" then
    prompt = 'Just push[yes/force]: '
  end
  if cmd == "git_init" then
    local fname = vim.api.nvim_buf_get_name(0)
    local p1 = p:new(fname)
    if not p1:is_file() then
      vim.cmd('ec "not file"')
      return
    end
    local d = {}
    for _ = 1, 24 do
      p1 = p1:parent()
      local name = p1.filename
      name = rep(name)
      table.insert(d, name)
      if not string.match(name, '/') then
        break
      end
    end
    vim.ui.select(d, { prompt = 'git init' }, function(choice)
      if not choice then
        return
      end
      local dpath = choice
      local remote_dname = get_fname_tail(dpath)
      if remote_dname == '' then
        return
      end
      remote_dname = '.git-' .. remote_dname
      vim.fn.system(string.format('cd %s && start cmd /c "%s %s"', dpath, cc, remote_dname))
      fname = dpath .. '/.gitignore'
      local p3 = p.new(fname)
      if p3:is_file() then
        local lines = vim.fn.readfile(fname)
        if vim.tbl_contains(lines, remote_dname) == false then
          vim.fn.writefile({ remote_dname }, fname, "a")
        end
      else
        vim.fn.writefile({ remote_dname }, fname, "a")
      end
    end)
  else
    dir = p:new(vim.api.nvim_buf_get_name(0)):parent().filename
    local h = io.popen(string.format('cd %s && git status -s', dir))
    local r = h:read("*a")
    h:close()
    if #r > 0 then
      vim.cmd(string.format('AsyncRun cd %s && git status --show-stash', dir))
      vim.cmd('copen')
      vim.cmd('wincmd J')
      vim.cmd([[au User AsyncRunStop lua GitPush(); vim.cmd('au! User AsyncRunStop')]])
    else
      print('no changes.')
    end
  end
end

GitPush = function()
  vim.api.nvim_win_set_height(0, vim.fn.line('$'))
  local input = vim.fn.input(prompt)
  local ok = nil
  if #input > 0 then
    if cmd == "just_push" then
      ok = 1
    else
      if #vim.fn.input(prompt2) == 0 then
        ok = 1
      end
    end
  end
  if ok then
    vim.loop.new_timer():start(400, 0, function()
      vim.schedule(function()
        vim.cmd([[au User AsyncRunStop lua vim.notify('AsyncRun Done.'); vim.cmd('au! User AsyncRunStop')]])
        vim.cmd(string.format(cmd2, dir, input))
      end)
    end)
  end
  vim.cmd('cclose')
end

vim.api.nvim_create_user_command('GitpusH', function(params)
  run(params['fargs'])
end, { nargs = '*', })

-- mappings

-- '<,'>s/vim\.keymap\.set(\([^}]\+},\) *\([^,]\+,\) *\([^,]\+,\) *\([^)]\+\))/\=printf("vim.keymap.set(%-20s %-24s %-64s %s)", submatch(1), submatch(2), submatch(3), submatch(4))

vim.keymap.set({ 'n', 'v' }, '<leader>g1', ':<c-u>GitpusH add_commit_push<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>g2', ':<c-u>GitpusH commit_push<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>g3', ':<c-u>GitpusH just_push<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>g4', ':<c-u>GitpusH add_commit<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>g5', ':<c-u>GitpusH just_commit<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>gI', ':<c-u>GitpusH git_init<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>g<f1>',
  [[:silent exe '!start cmd /c "git log --all --graph --decorate --oneline && pause"'<cr>]], { silent = true })
