""""""""""""""""""
" REGULAR CONFIG "
""""""""""""""""""
set shell=/bin/bash
set mouse=nicr
set number
set tabstop=4
set shiftwidth=4
set expandtab
set background=dark
set conceallevel=2
set timeoutlen=600
set ttimeoutlen=50

set wrap
set linebreak
set showbreak=..
set breakindent
set autoindent
set incsearch
set hlsearch
set textwidth=90
set display+=lastline
set fillchars+=vert:\▏
filetype plugin indent off
colorscheme solarized

syntax enable
set spell
set spelllang=en_us
highlight SpellBad cterm=underline


""""""""""""""""""""""""
" PLUG PACKAGE MANAGER "
""""""""""""""""""""""""
" begin plugin list
call plug#begin('~/.vim/plugged')

"" vim-fugitive ""
Plug 'tpope/vim-fugitive'

"" UltiSnips engine and snippets ""
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

"" VimTeX ""
Plug 'lervag/vimtex'

"" Extra TeX snips ""
Plug 'gillescastel/latex-snippets'

"" TeX-conceal ""
Plug 'KeitaNakamura/tex-conceal.vim', {'for': ['tex','md']}

"" NERDTree ""
Plug 'scrooloose/nerdtree'

"" Airline ""
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"" Solarized color scheme ""
Plug 'altercation/vim-colors-solarized'

"" GruvBox color scheme ""
Plug 'morhetz/gruvbox'

"" Markdown ""
Plug 'godlygeek/tabular'
Plug 'samgriesemer/vim-markdown'

"" Lists ""
Plug 'dkarter/bullets.vim'

"" Wiki ""
Plug 'samgriesemer/wiki.vim'
Plug 'samgriesemer/vim-roam'

"" Taskwiki ""
Plug 'samgriesemer/taskwiki'

"" fzf ""
Plug '~/.fzf' "make sure fzf installed (along with ripgrep)
Plug 'junegunn/fzf.vim'

"" coc.nvim ""
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['json', 'lua', 'vim', 'python']}
"Plug 'psf/black'

" end plugin list, initialize system
call plug#end()


""""""""""""""""""
" PACKAGE CONFIG "
""""""""""""""""""
"" Airline config ""
let g:airline#extensions#coc#enabled=1

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

"" Vim-markdown plugin config ""
let g:vim_markdown_math=1
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_auto_insert_bullets=0
let g:vim_markdown_new_list_item_indent=0

"" Base markdown settings (tpope) ""
let g:markdown_folding=1

"" Wiki ""
let g:wiki_root = '~/Documents/notes'
let g:wiki_filetypes = ['md']
"let g:wiki_map_create_page = 'StringToFname'
"let g:wiki_map_visit_link = 'StringToFname'
let g:wiki_write_on_nav = 1
let g:wiki_mappings_local = {
    \ '<plug>(wiki-graph-find-backlinks)' : '<Leader>wlb',
    \ '<plug>(wiki-link-toggle)' : '<Leader>wlt',
    \ '<plug>(wiki-page-toc)' : '<Leader>wpt'
\ }

let g:wiki_file_open = 'WikiFileOpen'

function! WikiFileOpen(...) abort dict
  if self.path =~# 'pdf$'
    silent execute '!zathura' fnameescape(self.path) '&'
    return 1
  endif
  return 0
endfunction

"" Taskwiki config ""
let g:taskwiki_markup_syntax = 'markdown'
let g:taskwiki_sort_order = 'status-,urgency-'
let g:taskwiki_dont_preserve_folds = 1

"" coc.nvim ""
let g:coc_disable_startup_warning = 1
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


""""""""""""""""""""""
" POST PLUGIN CONFIG "
""""""""""""""""""""""
" Markdown indentation
au BufRead,BufNewFile *.md filetype indent off
au BufRead,BufNewFile *.md setlocal spell
au FileType markdown setlocal foldlevel=99
highlight clear LineNr
highlight clear SignColumn
highlight VertSplit guibg=bg ctermbg=bg 

" Transparent bg to match terminal, comes at end to ensure hi isn't overwritten
"hi Normal guibg=NONE ctermbg=NONE

" Italic comments
highlight Comment cterm=italic
let &l:comments='fb:* [ ],fb:- [ ],nb:>,'.&comments


"""""""""""""""""""
" CUSTOM MAPPINGS "
"""""""""""""""""""
" redefine <Leader> to <space>
let mapleader = "\<Space>"

" enforce no arrows
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>

" NERDTree map
nmap <Leader>d :NERDTreeToggle<CR>

" general search
nmap <Leader>df :DirFzfFiles<CR>
nmap <Leader>dl :DirFzfLines<CR>

" wiki search
nmap <Leader>wf :WikiFzfFiles<CR>
nmap <Leader>wl :WikiFzfLines<CR>
"nmap <Leader>wb :WikiFzfBacklinks<CR>
nmap <Leader>wb :RoamBacklinkBuffer<CR>
nmap <Leader>wu :WikiFzfUnlinks<CR>

" wiki in-page TOC search
nmap <Leader>wt :WikiFzfToc<CR>

" tabular formatted tables
inoremap <silent> <Bar>   <Bar><Esc>:call TableAlign()<CR>a

" copy map
vmap <C-c> "+y

" open map (temporary, needs to be a site spec in vim-roam)
nmap <Leader>wo :call system('/Applications/Firefox.app/Contents/MacOS/firefox -new-tab "https://dev.smgr.io/' . expand('%:p:t:r') . '"')<CR>
