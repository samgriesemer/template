" Command toggle helpers. Mostly designed for spinning off an async process with a
" keybind, then opening the result in some way. For now centered primarily around PDF buld
" processes.


" make homework mappings
let s:hw_enabled=0

function! MakeHomework(file, open)
    let l:opt = {}
    if a:open
        let l:opt = {'post': 'call OpenHomework()'}
    endif

    if s:hw_enabled
        call asyncrun#run('', l:opt, 'source /home/smgr/.zshrc && mkhw '.a:file)
    endif
endfunction

function! ToggleHomework()
    if s:hw_enabled
        let s:hw_enabled = 0
    else
        let s:hw_enabled = 1
        call MakeHomework(expand('%'), 1)
    endif
endfunction

function! OpenHomework()
    silent exe '!zathura '.expand('%:r').'.pdf &'
    redraw!
endfunction

nmap <Leader>hw :call ToggleHomework()<CR>
autocmd BufWritePost *.md call MakeHomework(expand('%'), 0)


" slide test
let s:slides_enabled=0

function! MakeSlides(file, open)
    let l:opt = {}
    if a:open
        let l:opt = {'post': 'call OpenSlides()'}
    endif

    if s:slides_enabled
        echo 'source /home/smgr/.zshrc && cd /home/smgr/Documents/notes && md2beam '.expand('%:t').' && mv '.expand('%:t:r').'.pdf /home/smgr/Documents/notes/docs/slides/'
        " need to first build, then move to preserve possible image links
        call asyncrun#run('', l:opt, 'source /home/smgr/.zshrc && cd /home/smgr/Documents/notes && md2beam '.expand('%:t').' && mv '.expand('%:t:r').'.pdf /home/smgr/Documents/notes/docs/slides/')
    endif
endfunction

function! ToggleSlides()
    if s:slides_enabled
        let s:slides_enabled = 0
    else
        let s:slides_enabled = 1
        call MakeSlides(expand('%'), 1)
    endif
endfunction

function! OpenSlides()
    silent exe '!zathura /home/smgr/Documents/notes/docs/slides/'.expand('%:t:r').'.pdf &'
    redraw!
endfunction

nmap <Leader>wms :call ToggleSlides()<CR>
autocmd BufWritePost *.md call MakeSlides(expand('%'), 0)

