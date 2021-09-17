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

function HuhGrepPreview(cmd, pat, loc, qry, prm, nth, bng, pny, snk, ...)
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
    echo spec['options']
    if a:0 > 0
        let pos = index(spec['options'], '--preview')
        let spec.options[pos+1] = a:1
    endif
    if a:0 > 1
        let pos = index(spec['options'], '--bind')
        let spec.options[pos+1] = a:2
    end

    call extend(spec, {
    \   'sink*': funcref('s:'.a:snk),
    \ })

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

    try
        if call(get(g:, 'wiki_file_handler', ''), [], {'path':l:fname,'page':l:page})
            return
        endif
    catch /E117:/
      " Pass
    endtry

    execute 'edit '.l:fname
    execute l:lnum
endfunction

function! s:accept_page(lines) abort "{{{1
  if len(a:lines) < 2 | return | endif

  if len(a:lines) == 2 || !empty(a:lines[1])
    let l:target = a:lines[0]
  else
    let l:target = a:lines[2]

    try
        if call(get(g:, 'wiki_file_handler', ''), [], {'path':l:target})
            return
        endif
    catch /E117:/
      " Pass
    endtry
  endif

  execute 'edit '.l:target
endfunction


" DirFzfFiles - search current directory filenames and go to file
command! -bang -nargs=* DirFzfFiles
    \ call HuhGrepPreview(
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
let rg_colors = ' --colors ''path:fg:108,113,196'' '.
              \ ' --colors ''line:fg:211,54,130'' '.
              \ ' --colors ''column:fg:113,158,7'' '.
              \ ' --colors ''match:fg:220,50,47'' '
let s:rga_base = 'rga --column --line-number --no-heading --color=always --smart-case'.rg_colors.' -- %s'
command! -bang -nargs=* DirFzfLines
    \ call HuhGrepPreview(
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
