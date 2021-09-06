"
" markdown.vim: After filetype config options to apply for Markdown files
"

" specific `formatoptions` and `comments`; allow
" comments to be reformatted with `gq` (q, already
" a default), and recognize numbered lists (n). For
" comments, allows "#" in Markdown to be nested and
" thus prevents oddities when reformatting
set fo+=qn
set comments+=n:#

