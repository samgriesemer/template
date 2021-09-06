"
" wiki/templates.vim: autocmd template injection for wiki subsystems
"
" Author: Sam Griesemer
"

" generate template string from filename and metadata options
function TemplateList(fname, tag, src, sum, toc, jrn)
    let template_base = "
        \---\n
        \Title: %s\n
        \Date: %s\n
        \Modified: %s\n
        \Datelink: %s"

    " break down path components
    let head = fnamemodify(a:fname, ':p:h')
    let fname = fnamemodify(a:fname, ':p:t:r')
    let dname = FnameToString(fname)

    " get date and journal link
    let date = strftime("%Y-%m-%d")
    let rel_date_path = g:wiki_journal.name.'/'.date
    let rel_date_link = WrapLink(rel_date_path)

    " format base string
    let template = printf(template_base, dname, date, date, rel_date_link)

    " conditional template addons
    if a:tag
        let template = template."\nTags:"
    endif
    if a:src
        let template = template."\nSource:"
    endif
    if a:sum
        let template = template."\nSummary:"
    endif

    " end frontmatter
    let template = template."\n---"

    if a:toc
        let template = template."\n[TOC]"
    endif

    if a:jrn
        let template = template."\n\n
            \# TODO | due:".date."T23:59:59 -event\n\n
            \# [Log](../wiki/Log)\n\n
            \# [Thoughts](../wiki/Thoughts)"
    endif

    return split(template, '\n')
endfunction

function! InsertTemplate(...)
    let template = TemplateList(expand('%'),a:1,a:2,a:3,a:4,a:5) 
    call append(0, template)
endfunction


" metadata template for all new files (broken down by note type)
execute "au BufNewFile ".g:wiki_root."/wiki/*.md call InsertTemplate(1,0,1,1,0)"
execute "au BufNewFile ".g:wiki_root."/feed/*.md call InsertTemplate(1,1,0,0,0)"
execute "au BufNewFile ".g:wiki_root."/zettels/*.md call InsertTemplate(1,0,1,1,0)"
execute "au BufNewFile ".g:wiki_root."/".g:wiki_journal.name."/*.md  call InsertTemplate(0,0,0,0,1)"
" modified time update on file save
"function! s:update_modtime()
    "let save_view = winsaveview()
    ":silent 0r !$HOME/Nextcloud/vwbin/modtime_update.sh '%'
    ":e
    "call winrestview(save_view)
"endfunction

"au BufWritePost *.md :call s:update_modtime()

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
