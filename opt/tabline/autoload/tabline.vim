" bwipeout

let g:bwdict = {}

fu! tabline#bwpush(name)
  let name = tolower(substitute(a:name, '\', '/', 'g'))
  let cwd = tolower(substitute(getcwd(), '\', '/', 'g'))
  if !has_key(g:bwdict, cwd)
    let g:bwdict[cwd] = [name]
  else
    if index(g:bwdict[cwd], name) == -1
      let g:bwdict[cwd] += [name]
    endif
  endif
endfu

fu! tabline#bwwatcher(bufnr)
  if bufnr() != a:bufnr
    try
      call timer_stop(g:tabline_bw_timer)
    catch
    endtry
    try
      if getbufvar(a:bufnr, '&readonly') != 1
        call tabline#bwpush(nvim_buf_get_name(a:bufnr))
        try
          exe 'bw!' . a:bufnr
        catch
        endtry
        let g:tabline_done = 0
      endif
    catch
    endtry
  endif
endfu

fu! tabline#bw(bufnr)
  if bufnr() == a:bufnr
    try
      exe 'b' . g:nextbufnr
      let g:tabline_bw_timer = timer_start(10, { -> tabline#bwwatcher(a:bufnr) }, { 'repeat': -1})
    catch
    endtry
  else
    call tabline#bwwatcher(a:bufnr)
  endif
  let g:tabline_done = 0
endfu

fu! tabline#bwall()
  let cwd = tolower(substitute(getcwd(), '\', '/', 'g'))
  for bufnr in nvim_list_bufs()
    let name = substitute(nvim_buf_get_name(bufnr), '\', '/', 'g')
    if name == '' || match(tolower(name), cwd) == -1
      continue
    endif
    if buflisted(bufnr) && nvim_buf_is_loaded(bufnr) && filereadable(name)
      if getbufvar(bufnr, '&readonly') != 1
        call tabline#bwpush(name)
      endif
    endif
    try
      exe 'bw!' . bufnr
    catch
    endtry
  endfor
  let g:tabline_done = 0
endfu

fu! tabline#bwothers()
  let cwd = tolower(substitute(getcwd(), '\', '/', 'g'))
  for bufnr in nvim_list_bufs()
    let name = substitute(nvim_buf_get_name(bufnr), '\', '/', 'g')
    if name == '' || match(tolower(name), cwd) == -1 || bufnr == s:curbufnr
      continue
    endif
    if nvim_buf_is_loaded(bufnr) && filereadable(name)
      if getbufvar(bufnr, '&readonly') != 1
        call tabline#bwpush(name)
      endif
      try
        exe 'bw!' . bufnr
      catch
      endtry
    endif
  endfor
  let g:tabline_done = 0
  let s:cnt = 19
endfu

fu! tabline#bwright()
  let cwd = tolower(substitute(getcwd(), '\', '/', 'g'))
  for bufnr in nvim_list_bufs()
    if bufnr <= s:curbufnr
      continue
    endif
    let name = substitute(nvim_buf_get_name(bufnr), '\', '/', 'g')
    if name == '' || match(tolower(name), cwd) == -1
      continue
    endif
    if nvim_buf_is_loaded(bufnr) && filereadable(name)
      if getbufvar(bufnr, '&readonly') != 1
        call tabline#bwpush(name)
      endif
      try
        exe 'bw!' . bufnr
      catch
      endtry
    endif
  endfor
  let g:tabline_done = 0
  let s:cnt = 19
endfu

fu! tabline#bwleft()
  let cwd = tolower(substitute(getcwd(), '\', '/', 'g'))
  for bufnr in nvim_list_bufs()
    if bufnr >= s:curbufnr
      break
    endif
    let name = substitute(nvim_buf_get_name(bufnr), '\', '/', 'g')
    if name == '' || match(tolower(name), cwd) == -1
      continue
    endif
    if nvim_buf_is_loaded(bufnr) && filereadable(name)
      if getbufvar(bufnr, '&readonly') != 1
        call tabline#bwpush(name)
      endif
      try
        exe 'bw!' . bufnr
      catch
      endtry
    endif
  endfor
  let g:tabline_done = 0
  let s:cnt = 19
endfu

fu! tabline#bwfiletypelist(A, L, P)
  return s:fts
endfu

command! -complete=customlist,tabline#bwfiletypelist -nargs=* BwFileType call tabline#bwfiletypedo('<args>')

fu! tabline#bwfiletype()
  let cwd = tolower(substitute(getcwd(), '\', '/', 'g'))
  let s:fts = []
  for bufnr in nvim_list_bufs()
    let name = substitute(nvim_buf_get_name(bufnr), '\', '/', 'g')
    if name == '' || match(tolower(name), cwd) == -1 || bufnr == s:curbufnr
      continue
    endif
    if nvim_buf_is_loaded(bufnr) && filereadable(name)
      let ft = split(split(name, '/')[-1], '\.')[-1]
      if index(s:fts, ft) == -1
        let s:fts += [ft]
      endif
    endif
  endfor
  if len(s:fts) == 0
    echomsg 'no other filetypes to bw'
    return
  endif
  call feedkeys(":\<c-u>BwFileType ")
endfu

fu! tabline#bwfiletypedo(ft)
  let ft = split(trim(tolower(substitute(a:ft, '\s\+', ' ', 'g'))), ' ')
  let cwd = tolower(substitute(getcwd(), '\', '/', 'g'))
  for bufnr in nvim_list_bufs()
    let name = substitute(nvim_buf_get_name(bufnr), '\', '/', 'g')
    if name == '' || match(tolower(name), cwd) == -1 || bufnr == s:curbufnr
      continue
    endif
    if nvim_buf_is_loaded(bufnr) && filereadable(name)
      if index(ft, split(split(name, '/')[-1], '\.')[-1]) != -1
        if getbufvar(bufnr, '&readonly') != 1
          call tabline#bwpush(name)
        endif
        try
          exe 'bw!' . bufnr
        catch
        endtry
      endif
    endif
  endfor
  let g:tabline_done = 0
  let s:cnt = 19
endfu

" 重新打开bwipeout的buffer

fu! tabline#updatedict(cwd, names)
  let g:bwdict[a:cwd] = a:names
endfu

fu! tabline#bwpopmore()
  lua << EOF
    local cwds = {}
    for k, _ in pairs(vim.g.bwdict) do
      table.insert(cwds, k)
    end
    if #cwds > 0 then
      vim.ui.select(cwds, { prompt = 'bwipeout cwd' }, function(cwd, _)
        local fnames = {}
        for _, v in pairs(vim.g.bwdict[cwd]) do
          table.insert(fnames, v)
        end
        vim.ui.select(fnames, { prompt = 'open' }, function(choice, index)
          vim.cmd(string.format('e %s', choice))
          table.remove(fnames, index)
          vim.fn['tabline#updatedict'](cwd, fnames)
        end)
      end)
    end
EOF
endfu

fu! tabline#bwpop()
  let cwd = tolower(substitute(getcwd(), '\', '/', 'g'))
  if has_key(g:bwdict, cwd)
    lua << EOF
      local fnames = {}
      local cwd = string.gsub(vim.fn['getcwd'](), '\\', '/')
      cwd = vim.fn['tolower'](cwd)
      for _, v in pairs(vim.g.bwdict[cwd]) do
        if vim.fn['filereadable'](v) == 1 then
          table.insert(fnames, v)
        end
      end
      if #fnames > 0 then
        vim.ui.select(fnames, { prompt = 'open' }, function(_, index)
          vim.cmd(string.format('e %s', fnames[index]))
          table.remove(fnames, index)
          vim.fn['tabline#updatedict'](cwd, fnames)
        end)
      end
EOF
  endif
endfu

" 恢复其他隐藏的项目

fu! tabline#restorehidden()
  let projectroots = []
  let projectrootstemp = []
  for bufnr in nvim_list_bufs()
    if !buflisted(bufnr) && !nvim_buf_is_loaded(bufnr)
      continue
    endif
    let name = substitute(nvim_buf_get_name(bufnr), '\', '/', 'g')
    if name == '' || !filereadable(name)
      continue
    endif
    if getbufvar(bufnr, '&readonly') == 1
      continue
    endif
    let projectroot = tolower(substitute(projectroot#get(name), '\', '/', 'g'))
    if len(name) > 0 && index(projectrootstemp, projectroot) == -1
      let projectroots += [[projectroot, name]]
      let projectrootstemp += [projectroot]
    endif
  endfor
  let curtabpagenr = tabpagenr()
  for i in range(tabpagenr('$'))
    let buflist = tabpagebuflist(i + 1)
    let winnr = tabpagewinnr(i + 1)
    let bufname = nvim_buf_get_name(buflist[winnr-1])
    try
      let projectroot = tolower(substitute(projectroot#get(bufname), '\', '/', 'g'))
      let idx = index(projectrootstemp, projectroot)
      if idx != -1
        call remove(projectroots, idx)
        call remove(projectrootstemp, idx)
      endif
    catch
      continue
    endtry
  endfor
  let openprojects = []
  let tocloseprojects = []
  for i in range(tabpagenr('$'))
    let buflist = tabpagebuflist(i + 1)
    let winnr = tabpagewinnr(i + 1)
    let bufname = nvim_buf_get_name(buflist[winnr-1])
    try
      let projectroot = tolower(substitute(projectroot#get(bufname), '\', '/', 'g'))
      let idx = index(openprojects, projectroot)
      if idx == -1
        let openprojects += [projectroot]
      else
        if index(tocloseprojects, i + 1) == -1
          let tocloseprojects += [i + 1]
        endif
      endif
    catch
    endtry
  endfor
  for proj in tocloseprojects
    exe printf("tabclose %d", proj)
  endfor
  exe 'norm ' . string(tabpagenr('$')) . "gt"
  for projectroot in projectroots
    tabnew
    exe printf("e %s", projectroot[1])
  endfor
  let g:tabline_done = 0
  try
    exe 'norm ' . string(curtabpagenr) . "gt"
  catch
  endtry
endfu

" 鼠标wipeout或切换buffer

fu! tabline#gobuffer(minwid, _clicks, _btn, _modifiers)
  if a:_clicks == 1 && a:_btn == 'l'
    exe 'b' . a:minwid
  elseif a:_clicks == 2 && a:_btn == 'm'
    call tabline#bw(a:minwid)
  endif
endfu

" 项目目录缩写

fu! tabline#uniqueprefix(strings)
  let strings = a:strings
  if len(strings) == 1
    return [strings[0][0] . '…']
  endif
  let new_strings = []
  for string in strings
    let ok = 1
    let substrings = []
    for ch in string
      if len(substrings) == 0
        let substrings += [ch]
      else
        let substrings += [substrings[-1] . ch]
      endif
    endfor
    let yes = 0
    for substring in substrings
      if substring == string || yes
        if substring == string
          let new_strings += [substring]
        else
          let new_strings += [substring . '…']
        endif
        break
      endif
      let ok = 1
      for fullstring in strings
        if fullstring == string
          continue
        endif
        if match(fullstring, substring) == 0
          let ok = 0
          break
        endif
      endfor
      if ok
        if substring == string
          let new_strings += [substring]
        else
          let yes = 1
          continue
        endif
        break
      endif
    endfor
    if !ok
      let new_strings += [string]
    endif
  endfor
  return new_strings
endfu

" tabline

let g:tabline_done = 1
let g:tablinehi = {}
let s:cnt = 19
let s:curbufnr = 0
let s:showtablineright = 1
let s:tabline_string = ''
let s:tabpagecnt = 0

fu! tabline#tabline()
  if s:curbufnr == bufnr() && s:tabpagecnt == tabpagenr() && g:tabline_done
    return s:tabline_string
  endif
  let s:tabpagecnt = tabpagenr()
  let g:tabline_done = 1
  let s:curbufnr = bufnr()
  let curname = substitute(nvim_buf_get_name(0), '\', '/', 'g')
  let cwd = tolower(substitute(getcwd(), '\', '/', 'g'))
  let cnt = 0
  let curcnt = 0
  let L = {}
  for i in range(s:cnt)
    if i + 1 < 10
      let b1 = i + 1
    else
      let b1 = '`' . string(i + 1 - 10)
    endif
    try
      exe 'unmap <buffer> <leader>' . b1
      exe 'unmap <buffer> <leader>x' . b1
    catch
    endtry
  endfor
  let s2 = ''
  if s:showtablineright
    let projectroots = []
    let curtabpgnr = tabpagenr()
    for i in range(tabpagenr('$'))
      let buflist = tabpagebuflist(i + 1)
      let winnr = tabpagewinnr(i + 1)
      let bufname = nvim_buf_get_name(buflist[winnr-1])
      if i + 1 == curtabpgnr
        let curtabpageidx = i
        try
          let curext = split(bufname, '\.')[-1]
        catch
        endtry
      endif
      if len(trim(bufname)) == 0
        let projectroots += ['+']
      else
        try
          let project = projectroot#get(bufname)
        catch
          let project = bufname
        endtry
        let project = substitute(project, '\', '/', 'g')
        let project = split(project, '/')
        if len(project) > 0
          let projectroots += [project[-1]]
        else
          let projectroots += ['-']
        endif
      endif
    endfor
    let curprojectroot = projectroots[curtabpageidx]
    let projectroots = tabline#uniqueprefix(projectroots)
    for i in range(len(projectroots))
      let buflist = tabpagebuflist(i + 1)
      let winnr = tabpagewinnr(i + 1)
      let bufname = nvim_buf_get_name(buflist[winnr-1])
      try
        let ext = split(bufname, '\.')[-1]
        let s2 ..= printf('%%#MyTabline%s#', ext)
      catch
        let s2 ..= '%#TablineDim#'
      endtry
      try
      catch
      endtry
      let s2 ..= '▎'
      let projectroot = projectroots[i]
      let s2 ..= '%' .. (i + 1) .. 'T'
      if i == curtabpageidx
        try
          let s2 ..= printf('%%#MyTabline%s#', curext)
        catch
          let s2 ..= '%#TablineDim#'
        endtry
      else
        let s2 ..= '%#TablineDim#'
      endif
      let s2 ..= string(i+1) . ' '
      if i == curtabpageidx
        let s2 ..= curprojectroot
      else
        let s2 ..= projectroot
      endif
      let s2 ..= ' '
    endfor
  else
    let s2 ..= printf("  %d/%d", tabpagenr(), tabpagenr('$'))
  endif
  let temps2 = substitute(s2, '%#.\{-}#', '', 'g')
  let temps2 = substitute(temps2, '%\d\{-}T', '', 'g')
  let temps2 = temps2 . ' '
  for bufnr in nvim_list_bufs()
    if !buflisted(bufnr) && !nvim_buf_is_loaded(bufnr)
      continue
    endif
    let name = substitute(nvim_buf_get_name(bufnr), '\', '/', 'g')
    if name == '' || !filereadable(name) || match(tolower(name), cwd) == -1 || cwd != tolower(substitute(projectroot#get(name), '\', '/', 'g'))
      continue
    endif
    let names = split(name, '/')
    let name = names[-1]
    if bufnr == s:curbufnr
      let curcnt = cnt
    else
    endif
    let L[cnt] = [bufnr, name]
    let cnt += 1
  endfor
  let length = len(L)
  let mincnt = 0
  let maxcnt = length - 1
  let S1 = []
  let cnt = 0
  for i in range(mincnt, maxcnt)
    let temps1 = ''
    let key = L[i]
    let bufnr = key[0]
    let name = key[1]
    let cnt += 1
    let ext = split(name, '\.')[-1]
    let temps1 ..= '▎'
    let temps1 ..= cnt
    if i == curcnt && length >= 7
      let temps1 ..= '/'
      let temps1 ..= length
    endif
    let temps1 ..= ' '
    try
      let temps1 ..= join(split(name, '\.')[0:-2], '\.')
      let ic = g:tablinehi[ext][0]
      let temps1 ..= ' ' .. ic
    catch
      let temps1 ..= name
    endtry
    let temps1 ..= ' '
    let S1 += [temps1]
  endfor
  let s1 = ''
  if len(S1)
    let columns = &columns
    let w1 = columns - strdisplaywidth(temps2)
    let c1 = strdisplaywidth(S1[curcnt])
    if curcnt > 0
      for i1 in range(curcnt - 1, 0, -1)
        if c1 + strdisplaywidth(S1[i1]) > w1 / 2
          break
        endif
        let c1 += strdisplaywidth(S1[i1])
      endfor
    endif
    let c2 = 0
    let x2 = 0
    if curcnt < length - 1
      for i2 in range(curcnt + 1, len(S1) - 1)
        if c2 + strdisplaywidth(S1[i2]) > w1 - c1
          break
        endif
        let c2 += strdisplaywidth(S1[i2])
        let x2 += 1
      endfor
    endif
    let maxcnt = curcnt + x2
    let mincnt = max([curcnt - (18 - x2), 0])
    let cnt = 0
    if !filereadable(curname)
      let curcnt = -1
    endif
    for i in range(mincnt, maxcnt)
      let key = L[i]
      let bufnr = key[0]
      let name = key[1]
      let cnt += 1
      if cnt < 10
        let b1 = cnt
      else
        let b1 = '`' . string(cnt-10)
      endif
      exe 'nnoremap <buffer><silent><nowait> <leader>' . b1 ' :b' . bufnr .'<cr>'
      exe 'nnoremap <buffer><silent><nowait> <leader>x' . b1 ' :call tabline#bw(' . bufnr .')<cr>'
      if i + 1 == curcnt
        exe 'nnoremap <buffer><silent><nowait> <leader>- :b' . L[i][0] .'<cr>'
        exe 'nnoremap <buffer><silent><nowait> <c-h> :b' . L[i][0] .'<cr>'
        exe 'nnoremap <buffer><silent><nowait> <leader>x- :call tabline#bw(' . L[i][0] .')<cr>'
        exe 'nnoremap <buffer><silent><nowait> <c-bs> :b' . L[i][0] .'<cr>'
        if i + 1 == length - 1
          let g:nextbufnr = L[i][0]
        endif
      elseif i - 1 == curcnt
        exe 'nnoremap <buffer><silent><nowait> <leader>= :b' . L[i][0] .'<cr>'
        exe 'nnoremap <buffer><silent><nowait> <c-l> :b' . L[i][0] .'<cr>'
        exe 'nnoremap <buffer><silent><nowait> <leader>x= :call tabline#bw(' . L[i][0] .')<cr>'
        exe 'nnoremap <buffer><silent><nowait> <bs> :b' . L[i][0] .'<cr>'
        let g:nextbufnr = L[i][0]
      elseif i == curcnt
        exe 'nnoremap <buffer><silent><nowait> <leader>x<bs> :call tabline#bw(' . bufnr .')<cr>'
        exe 'nnoremap <buffer><silent><nowait> <c-del> :call tabline#bw(' . bufnr .')<cr>'
      endif
      let ext = split(name, '\.')[-1]
      let s1 ..= '%' . bufnr
      let s1 ..= '@tabline#gobuffer@'
      if i == curcnt
        try
          let ic = g:tablinehi[ext][0]
          let s1 ..= printf('%%#MyTabline%s#▎', ext)
        catch
          let s1 ..= '%#TablineHi#▎'
        endtry
        let s1 ..= cnt
      else
        let s1 ..= '%#TablineDim#▎'
        let s1 ..= cnt
      endif
      if i == curcnt && length >= 7
        let s1 ..= '/'
        let s1 ..= length
      endif
      let s1 ..= ' '
      if i != curcnt
        let s1 ..= '%#TablineDim#'
      endif
      try
        let ic = g:tablinehi[ext][0]
        let s1 ..= join(split(name, '\.')[0:-2], '\.')
        let s1 ..= printf('%%#MyTabline%s#', ext)
        let s1 ..= ' ' .. ic
      catch
        let s1 ..= name
      endtry
      let s1 ..= ' '
    endfor
    let s:cnt = cnt
    let s1 = trim(s1)
    if length == curcnt + 1
      if index(keys(L), '0') != -1
        exe 'nnoremap <buffer><silent><nowait> <leader>= :b' . L[0][0] .'<cr>'
        exe 'nnoremap <buffer><silent><nowait> <c-l> :b' . L[0][0] .'<cr>'
        exe 'nnoremap <buffer><silent><nowait> <leader>x= :call tabline#bw(' . L[0][0] .')<cr>'
        exe 'nnoremap <buffer><silent><nowait> <bs> :b' . L[0][0] .'<cr>'
      endif
    elseif 0 == curcnt
      if index(keys(L), string(length-1)) != -1
        exe 'nnoremap <buffer><silent><nowait> <leader>- :b' . L[length-1][0] .'<cr>'
        exe 'nnoremap <buffer><silent><nowait> <c-h> :b' . L[length-1][0] .'<cr>'
        exe 'nnoremap <buffer><silent><nowait> <leader>x- :call tabline#bw(' . L[length-1][0] .')<cr>'
        exe 'nnoremap <buffer><silent><nowait> <c-bs> :b' . L[length-1][0] .'<cr>'
      endif
    endif
  endif
  if len(s1) == 0
    let s1 ..= '%#TablineDim#'
    let s1 ..= '%' . s:curbufnr
    let s1 ..= '@tabline#gobuffer@'
    let s1 ..= ' 1 empty name '
  else
    exe 'nnoremap <buffer><silent><nowait> <leader>0 :b' . bufnr .'<cr>'
    exe 'nnoremap <buffer><silent><nowait> <leader>x0 :call tabline#bw(' . bufnr .')<cr>'
  endif
  let s1 ..= '%#TablineDim#%T'
  let s1 ..= "%="
  let s1 ..= '%#TablineDim#'
  let s = s1 .. s2
  let s:tabline_string = trim(s) . ' '
  return s:tabline_string
endfu

" 按项目保存或恢复打开过的buffers

let datadir = expand("$VIMRUNTIME") . "\\my-neovim-data"

if !isdirectory(datadir)
  call mkdir(datadir)
endif

let sessiondir = datadir . "\\Session"
if !isdirectory(sessiondir)
  call mkdir(sessiondir)
endif

let s:sessionname = sessiondir . "\\session.txt"

fu! tabline#savesession()
  let names = []
  for bufnr in nvim_list_bufs()
    if !buflisted(bufnr) && !nvim_buf_is_loaded(bufnr)
      continue
    endif
    if getbufvar(bufnr, '&readonly') == 1
      continue
    endif
    let name = substitute(nvim_buf_get_name(bufnr), '\', '/', 'g')
    if name == '' || !filereadable(name)
      continue
    endif
    let names += [name]
  endfor
  if len(names) > 0
    call writefile(names, s:sessionname)
  endif
endfu

fu! tabline#restoresession()
  let lines = readfile(s:sessionname)
  for line in lines
    if filereadable(line)
      exe 'e ' . line
    endif
  endfor
  call tabline#restorehidden()
endfu

" 切换是否显示tabline

fu! tabline#toggleshowtabline()
  if &showtabline == 0
    set showtabline=2
  else
    set showtabline=0
  endif
endfu

" 切换是否显示tabline右半部分

fu! tabline#toggleshowtablineright()
  let g:tabline_done = 0
  if s:showtablineright
    let s:showtablineright = 0
  else
    let s:showtablineright = 1
  endif
endfu

" mapping

nnoremap <silent><nowait> <leader>xa :call tabline#bwall()<cr>
nnoremap <silent><nowait> <leader>xf :call tabline#bwfiletype()<cr>
nnoremap <silent><nowait> <leader>xh :call tabline#bwleft()<cr>
nnoremap <silent><nowait> <leader>xl :call tabline#bwright()<cr>
nnoremap <silent><nowait> <leader>xo :call tabline#bwothers()<cr>

nnoremap <silent><nowait> <leader>bp :call tabline#bwpop()<cr>
nnoremap <silent><nowait> <leader>bP :call tabline#bwpopmore()<cr>

nnoremap <silent><nowait> <leader>be :call tabline#restorehidden()<cr>

nnoremap <silent><nowait> <leader>bo :call tabline#restoresession()<cr>

nnoremap <silent><nowait> <leader>b< :call tabline#toggleshowtabline()<cr>
nnoremap <silent><nowait> <leader>b> :call tabline#toggleshowtablineright()<cr>
