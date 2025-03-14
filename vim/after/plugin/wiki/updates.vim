"
" wiki/updates.vim: simple autocmd updates to wiki files
"
" Author: Sam Griesemer
"

" update wiki files "modified time" attribute
autocmd BufWritePre,FileWritePre *.md call LastMod()

function LastMod()
  let save_view = winsaveview()
  if line("$") > 20
    let l = 20
  else
    let l = line("$")
  endif
  silent exe "1," . l . "g/Modified: /s/Modified: .*/Modified: " . strftime("%Y-%m-%d")
  silent exe "1," . l . "g/modified: /s/modified: .*/modified: " . strftime("%Y-%m-%d")
  call winrestview(save_view)
endfunction

"[cache().vwtask[i] for i in util.selected_line_numbers()]
"VimwikiTask.from_line(cache, task)
"cache = cache_module.CacheRegistry()
"cache.load_current()
"tw = cache.warriors[match.group('source') or 'default']
"VimwikiTask(cache, uuid, tw)
