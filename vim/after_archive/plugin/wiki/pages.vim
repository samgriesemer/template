"
" Author: Sam Griesemer
"

" command to create wiki file
command! WikiCreateFile call WikiCreateFile()

" Create wiki file from input
function! WikiCreateFile()
    " query user for filename (relative to wiki root)
    let fname = input('Enter new file name: ')

    if empty(fname)
        echom "wiki error: File name must not be empty"
        return
    endif

    " basic processing to convert input to filename
    let fname = StringToFname(fname)
    let fname = fname.'.md'

    " create and go to file
    execute ':e '.g:wiki_root.'/'.fname
endfunction
