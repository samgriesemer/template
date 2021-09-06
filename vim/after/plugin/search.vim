"
" search.vim: search methods and commands for general purpose use
"
" Author: Sam Griesemer
"
" NOTE: fzf#vim#preview() arguments
" - First argument: {'options': <options_dict>, 'right/left/up/down': '<perc>%'}
" - Second argument: 'right/left/up/down': <perc>% [for preview window location]
"

" define useful base values
let rg_base = 'rg --column --line-number --no-heading --color=always --smart-case'

function FzfGrepPreview(cmd, pat, loc, qry, prm, nth, bng, pny, snk, ...)
    let spec = fzf#vim#with_preview({
    \       'options': [
    \           '--prompt', a:prm,
    \           '--ansi',
    \           '--extended',
    \           '--delimiter=:',
    \           '--nth='.a:nth,
    \           '--with-nth=1,2,4..',
    \           '--query='.a:qry,
    \           '--print-query',
    \       ]})

    if a:pny
        call add(spec.options, '--phony')
    endif

    if a:0 > 0
        let pos = index(spec['options'], '--preview')
        let spec.options[pos+1] = a:1
    endif
    if a:0 > 1
        let pos = index(spec['options'], '--bind')
        let spec.options[pos+1] = a:2
    end

    call extend(spec, {
    \       'sink*': funcref('s:'.a:snk),
    \   })

    call fzf#vim#grep(a:cmd.' '.a:pat.' '.a:loc, 1, spec, a:bng)
endfunction

function! s:accept_line(lines) abort "{{{1
    if len(a:lines) < 2 | return | endif

    let l:fname = ''
    if len(a:lines) == 2 || !empty(a:lines[1])
        let l:fname = a:lines[0]
        return
    endif

    let l:comp = split(a:lines[2], ':')
    let l:fname = l:comp[0]
    let l:lnum  = l:comp[1]
    let l:page = 1

    if len(l:comp) >= 4
        if match(l:comp[3], '^Page \d\+$') == 0
            let l:page = substitute(l:comp[3], '^Page \(\d\+\)$', '\1', '')
        endif
    endif

    execute 'edit '.l:fname
    execute l:lnum
endfunction

function! s:accept_page(lines) abort "{{{1
  if len(a:lines) < 2 | return | endif

  if len(a:lines) == 2 || !empty(a:lines[1])
    let l:target = a:lines[0]
  else
    let l:target = a:lines[2]
  endif

  execute 'edit '.l:target
endfunction


" DirFzfFiles - search current directory filenames and go to file
command! -bang -nargs=* DirFzfFiles
    \ call FzfGrepPreview(
    \   'rg --files',
    \   shellescape(<q-args>),
    \   '*',
    \   <q-args>,
    \   'dFiles> ',
    \   '..',
    \   <bang>0,
    \   0,
    \   'accept_page',
    \   '/home/smgr/.vim/plugged/vim-roam-search/autoload/roam_search/preview-rga.sh ''{..}'' {q}'
    \ )


" DirFzfLines - search lines in all files located in the current directory
" (recursive) and go to file. Following FZF session has a prefilled query
" using the first argument, which is a string used for the initial ripgrep
" exact search.
let s:rga_base = 'rga --column --line-number --no-heading --color=always --smart-case -- %s'
command! -bang -nargs=* DirFzfLines
    \ call FzfGrepPreview(
    \   printf(s:rga_base, shellescape(<q-args>)),
    \   '',
    \   '',
    \   <q-args>,
    \   'dLines> ',
    \   '..',
    \   <bang>0,
    \   0,
    \   'accept_line',
    \   '/home/smgr/.vim/plugged/vim-roam-search/autoload/roam_search/preview-rga.sh ''{..2}'' {q}'
    \ )
