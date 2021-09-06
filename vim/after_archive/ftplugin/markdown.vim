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

" Add syntax groups and clusters for links
"for [s:group, s:rx; s:contained] in [
"      \ ['wikiLinkUrl',       'url',         'wikiLinkUrlConceal'],
"      \ ['wikiLinkUrl',       'shortcite'],
"      \ ['wikiLinkWiki',      'wiki',        'wikiLinkWikiConceal'],
"      \ ['wikiLinkRef',       'ref_single'],
"      \ ['wikiLinkRefTarget', 'ref_target',  'wikiLinkUrl'],
"      \ ['wikiLinkRef',       'ref_double',  'wikiLinkRefConceal'],
"      \ ['wikiLinkMd',        'md',          'wikiLinkMdConceal'],
"      \ ['wikiLinkDate',      'date'],
"      \]
"  execute 'syntax cluster wikiLink  add=' . s:group
"  execute 'syntax match' s:group
"        \ '/' . wiki#link#get_matcher_opt(s:rx, 'rx') . '/'
"        \ 'display contains=@NoSpell'
"        \ . (empty(s:contained) ? '' : ',' . join(s:contained, ','))
"
"  call filter(s:contained, 'v:val !~# ''Conceal''')
"  execute 'syntax match' s:group . 'T'
"        \ '/' . wiki#link#get_matcher_opt(s:rx, 'rx') . '/'
"        \ 'display contained contains=@NoSpell'
"        \ . (empty(s:contained) ? '' : ',' . join(s:contained, ','))
"endfor
"
"syntax match wikiLinkUrlConceal
"      \ `\%(///\=[^/ \t]\+/\)\zs\S\+\ze\%([/#?]\w\|\S\{15}\)`
"      \ cchar=~ contained transparent contains=NONE conceal
"syntax match wikiLinkWikiConceal /\[\[\%(\/\|#\)\?\%([^\\\]]\{-}|\)\?/
"      \ contained transparent contains=NONE conceal
"syntax match wikiLinkWikiConceal /\]\]/
"      \ contained transparent contains=NONE conceal
""syntax match wikiLinkMdConceal /\[/
"      \ contained transparent contains=NONE conceal
"syntax match wikiLinkMdConceal /\]([^\\]\{-})/
"      \ contained transparent contains=NONE conceal
"syntax match wikiLinkRefConceal /[\]\[]\@<!\[/
"      \ contained transparent contains=NONE conceal
"syntax match wikiLinkRefConceal /\]\[[^\\\[\]]\{-}\]/
"      \ contained transparent contains=NONE conceal
"
"highlight default link wikiLinkUrl ModeMsg
"highlight default link wikiLinkWiki Underlined
"highlight default link wikiLinkMd Underlined
"
"unlet s:group s:rx s:contained
