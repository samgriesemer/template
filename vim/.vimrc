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
set belloff=all

set wrap
set linebreak
set showbreak=..
set breakindent
set autoindent
set incsearch
set hlsearch
set hidden
set shortmess-=S
set textwidth=90
set display+=lastline
set fillchars+=vert:\▏
filetype plugin on
filetype indent off
colorscheme solarized
"colorscheme gruvbox

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
Plug 'https://git.samgriesemer.com/samgriesemer/vim-roam-md'

"" Lists ""
Plug 'dkarter/bullets.vim'

"" Wiki ""
Plug 'https://git.samgriesemer.com/samgriesemer/wiki.vim'
Plug 'https://git.samgriesemer.com/samgriesemer/vim-roam'
Plug 'https://git.samgriesemer.com/samgriesemer/vim-roam-search'

"" Taskwiki ""
Plug 'https://git.samgriesemer.com/samgriesemer/vim-roam-task'

"" fzf ""
Plug '~/.fzf' "make sure fzf installed (along with ripgrep)
Plug 'junegunn/fzf.vim'

"" coc.nvim ""
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['json', 'lua', 'vim', 'python']}
"Plug 'psf/black'

Plug 'dhruvasagar/vim-table-mode'

Plug 'skywind3000/asyncrun.vim'


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
let g:vimtex_view_method='zathura'
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
let g:wiki_write_on_nav = 1
let g:wiki_journal = {
      \ 'name' : '',
      \ 'frequency' : 'daily',
      \ 'date_format' : {
      \   'daily' : '%Y-%m-%d',
      \   'monthly' : '%Y-%m',
      \   'yearly' : '%Y',
      \ },
\}
let g:wiki_mappings_local = {
    \ '<plug>(wiki-link-toggle)' : '<Leader>wlt',
    \ '<plug>(wiki-fzf-toc)' : '<leader>wt',
    \ '<plug>(wiki-page-toc)' : '<Leader>wpt',
    \ '<plug>(wiki-journal-toweek)' : '<Leader>wjt',
   \ '<plug>(wiki-graph-find-backlinks)' : '<Leader>wlb',
\ }

let g:wiki_map_create_page = 'StringToFname'
"let g:wiki_map_link2file   = 'StringToFname'
function! StringToFname(str)
    return substitute(a:str,' ','_','g')
endfunction

let g:wiki_map_file2link   = 'FnameToString'
function! FnameToString(fname)
    return substitute(a:fname,'_',' ','g')
endfunction

let g:wiki_resolver = 'WikiResolver'
function! WikiResolver(fname, origin)
  if empty(a:fname) | return a:origin | endif

  let l:file = a:fname
  if fnamemodify(l:file, ':e') == 'md'
      let l:file = fnamemodify(l:file, ':r')
  endif
  let l:file = StringToFname(l:file)
  return simplify(wiki#get_root().'/'.l:file.'.md')
endfunction


" has to be actual file url type ie file:<>
let g:wiki_file_handler = 'WikiFileOpen'
function! WikiFileOpen(...) abort dict
  if self.path =~# 'pdf$'
    let l:cmd = '!zathura '.fnameescape(self.path)
    if get(self, 'page')
        let l:cmd .= ' -P '.string(self.page)
    endif
    silent execute l:cmd.' &'
    return 1
  endif
  return 0
endfunction

"" Vim-roam ""
let g:roam_search_wrap_link = 'WrapLink'
function! WrapLink(lines)
    "call feedkeys('A')
    let l:link = join(a:lines)
    let l:link = FnameToString(l:link)
    let l:link = '[['.l:link.']]'

    if getcurpos()[2]+strlen(l:link) > &tw
        let l:spacing = repeat(' ', &tw - getcurpos()[2])
        let l:link = l:spacing . l:link
    endif

    " get link string for path (assumed relative to wiki root)
    return l:link
endfunction



"" Taskwiki config ""
let g:taskwiki_markup_syntax = 'markdown'
let g:taskwiki_sort_order = 'status-,urgency-'
let g:taskwiki_task_path = 'tasks'
"let g:taskwiki_dont_preserve_folds = 1

"" coc.nvim ""
let g:coc_disable_startup_warning = 1
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
"" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

let g:coc_global_extensions = ['coc-pyright', 'coc-tsserver', 'coc-html', 'coc-omni'
            "\ 'coc-eslint', 'coc-prettier',
            "\ 'coc-css', 'coc-json', 'coc-yaml'
            \ ]

" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
let mapleader = "\<Space>"

" Use `lp` and `ln` for navigate diagnostics
nmap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ln <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>ld <Plug>(coc-definition)
nmap <silent> <leader>lt <Plug>(coc-type-definition)
nmap <silent> <leader>li <Plug>(coc-implementation)
nmap <silent> <leader>lf <Plug>(coc-references)

" Remap for rename current word
nmap <leader>lr <Plug>(coc-rename)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')

"""


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
hi Normal guibg=NONE ctermbg=NONE

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

" window movement remap
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" NERDTree map
nmap <Leader>d :NERDTreeToggle<CR>

" general search
nmap <Leader>df :DirFzfFiles<CR>
nmap <Leader>dl :DirFzfLines<CR>

" wiki search
"nmap <Leader>wf :WikiFzfFiles<CR>
"nmap <Leader>wl :WikiFzfLines<CR>
"nmap <Leader>wb :WikiFzfBacklinks<CR>
"nmap <Leader>wb :RoamBacklinkBuffer<CR>
"nmap <Leader>wu :WikiFzfUnlinks<CR>

" wiki in-page TOC search
"nmap <Leader>wt :WikiFzfToc<CR>

" tabular formatted tables
inoremap <silent> <Bar>   <Bar><Esc>:call TableAlign()<CR>a

" copy map
vmap <C-c> "+y

" open map (temporary, needs to be a site spec in vim-roam)
nmap <Leader>wo :call system('firefox -new-tab "localhost:8000/' . expand('%:p:t:r') . '.html"')<CR>

