""" REGULAR CONFIG """
set shell=/bin/bash
set mouse=nicr
set number
set tabstop=2
set shiftwidth=2
set expandtab
set background=dark
set conceallevel=1
"set colorcolumn=80

syntax enable
colorscheme solarized
"colorscheme gruvbox
setlocal spell
set spelllang=en_us
hi Normal guibg=NONE ctermbg=NONE

""" PLUG PACKAGE MANAGER """
" begin plugin list
call plug#begin('~/.vim/plugged')
"" UltiSnips engine and snippets ""
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

"" VimTeX ""
Plug 'lervag/vimtex'

"" TeX-conceal ""
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}

"" Extra TeX snips ""
Plug 'gillescastel/latex-snippets'

"" NERDTree "" Plug 'scrooloose/nerdtree' "" Airline ""
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"" Solarize color scheme ""
Plug 'altercation/vim-colors-solarized'

"" GruvBox color scheme ""
Plug 'morhetz/gruvbox'

"" Markdown ""
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

"" VimWiki ""
Plug 'vimwiki/vimwiki', {'branch': 'dev'}

"" Taskwiki ""
Plug 'tbabej/taskwiki'

" end plugin list, initialize system
call plug#end()

""" PACKAGE CONFIG """
"" UltiSnips configuration ""
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsEditSplit="vertical"

"" VimTex configuration ""
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
let g:vimtex_quickfix_mode=0

"" TeX-conceal configuration ""
let g:tex_conceal='abdmg'

"" NERDTree config ""
let NERDTreeMinimalUI=1

"" Markdown formatting ""
let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1
highlight Comment cterm=italic

"" Vim-markdown plugin config ""
let g:vim_markdown_folding_disabled = 1


"" VimWiki config ""
let g:vimwiki_list = [{'path': '~/Nextcloud/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md',
                      \ 'links_space_char': '-'}]
let g:vimwiki_global_ext = 0

"" Taskwiki config ""
let g:taskwiki_markup_syntax = 'markdown'
