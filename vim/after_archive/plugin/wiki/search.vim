"
" wiki/search.vim: search methods and commands for the wiki
"
" Author: Sam Griesemer
"

" WikiFzfFiles - search wiki filenames and go to file
command! -bang -complete=dir WikiFzfFiles
    \ call fzf#vim#files(g:wiki_root, fzf#vim#with_preview({'right':'50%'}, 'down:50%:wrap'), <bang>0)

" WikiFzfLines - search lines in all wiki files and go to file. Following FZF
" session has a prefilled query using the first argument, which is a
" string used for the initial ripgrep exact search.
command! -bang -nargs=* WikiFzfLines
    \ call FzfGrepPreview(rg_base, shellescape(<q-args>), g:wiki_root, <q-args>, <bang>0)

" WikiFzfBacklinks - find backlinks for current file. Uses ripgrep to match
" exact filename link regex across all wiki lines, then prefill FZF session
" with filename.
command! -bang -nargs=* WikiFzfBacklinks
    \ call FzfGrepPreview(rg_base,
    \   '"\[[^\]]*\]\((.*/)*'.expand('%:t:r').'(#[^\)]*)*\)"',
    \   g:wiki_root,
    \   expand('%:t:r'),
    \   <bang>0)

" WikiFzfUnlinks - get fuzzy unlinked references related to current filename.
" Uses ripgrep to search all wiki lines for mentions of the filename, then
" prefills following FZF session with this name.
command! -bang -nargs=* WikiFzfUnlinks
    \ call FzfGrepPreview(rg_base,
    \   '".*"',
    \   g:wiki_root,
    \   expand('%:t:r'),
    \   <bang>0)

