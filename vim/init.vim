set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
"source ~/.vimrc

""""""""""""""""""
" REGULAR CONFIG "
""""""""""""""""""
set shell=/bin/bash
set mouse=nicr
set number
set tabstop=4
set shiftwidth=4
set expandtab
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
"set hidden
set shortmess-=S
set textwidth=90
set display+=lastline
set fillchars+=vert:\▏
filetype plugin on
filetype indent off

set termguicolors
set background=dark

colorscheme solr
let g:solr_italic=1
let g:airline_theme='solr'


syntax enable
set spell
set spelllang=en_us


""""""""""""""""""""""""
" PLUG PACKAGE MANAGER "
""""""""""""""""""""""""
" begin plugin list
call plug#begin('~/.vim/plugged')

"" vim-fugitive ""
Plug 'tpope/vim-fugitive'

"" vim-obsession ""
Plug 'tpope/vim-obsession'

"" UltiSnips engine and snippets ""
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

"" VimTeX ""
Plug 'lervag/vimtex'

"" Extra TeX snips ""
Plug 'gillescastel/latex-snippets'

"" TeX-conceal ""
Plug 'KeitaNakamura/tex-conceal.vim', {'for': ['tex','md']}

"" NERDTree ""
"Plug 'scrooloose/nerdtree'
" nah, CHADTree
Plug 'ryanoasis/vim-devicons'
"Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}

"" nvim LSP ""
Plug 'neovim/nvim-lspconfig'
"Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'hrsh7th/cmp-buffer'
"Plug 'hrsh7th/cmp-path'
"Plug 'hrsh7th/cmp-cmdline'
"Plug 'hrsh7th/nvim-cmp'


"" Airline ""
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"" Solarized color scheme ""
"Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'

"" GruvBox color scheme ""
Plug 'morhetz/gruvbox'

"" Markdown ""
Plug 'godlygeek/tabular'
Plug 'https://git.samgriesemer.com/samgriesemer/vim-roam-md'

"" Lists ""
Plug 'dkarter/bullets.vim'

"" Wiki ""
Plug 'skywind3000/asyncrun.vim'
Plug 'https://git.samgriesemer.com/samgriesemer/wiki.vim'
Plug 'https://git.samgriesemer.com/samgriesemer/vim-roam'
Plug 'https://git.samgriesemer.com/samgriesemer/vim-roam-search'

"" Taskwiki ""
Plug 'samgriesemer/vim-roam-task'

"" fzf ""
Plug '~/.fzf' "make sure fzf installed (along with ripgrep)
Plug 'junegunn/fzf.vim'

Plug 'dhruvasagar/vim-table-mode'

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
let g:UltiSnipsEditSplit = 'vertical'

"" VimTex configuration ""
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode = 0

"" TeX-conceal configuration ""
let g:tex_conceal='abdmg'

"" NERDTree config ""
let NERDTreeMinimalUI=1

"" Vim-markdown plugin config ""
let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

"" Base markdown settings (tpope) ""
let g:markdown_folding = 1

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
let g:wiki_map_create_page = 'StringToFname'  " used through with `wn`
let g:wiki_map_file2link = 'FnameToString'    " file to link map, for renaming & vim-roam link reverse
let g:wiki_resolver = 'WikiResolver'          " transform link to filename
let g:wiki_file_handler = 'WikiFileOpen'      " handle wiki `file:` opening
let g:wiki_post_page_open = 'WikiPostOpen'    " callback after page open

function! StringToFname(str)
    return substitute(a:str,' ','_','g')
endfunction

function! FnameToString(fname)
    return substitute(a:fname,'_',' ','g')
endfunction

function! WikiResolver(fname, origin)
  if empty(a:fname) | return a:origin | endif

  let l:file = StringToFname(a:fname)
  let l:file = simplify(wiki#get_root().'/'.l:file)
  let l:ext  = fnamemodify(l:file, ':e')

  if l:ext == 'md'
    return l:file
  elseif l:ext == 'pdf'
    eval call('WikiFileOpen', [], {'path': l:file})
  else
    if filereadable(l:file.'.md')
      return l:file.'.md'
    elseif filereadable(l:file.'.pdf')
      eval call('WikiFileOpen', [], {'path': l:file.'.pdf'})
    else
      " final default behavior, open new Markdown file
      return l:file.'.md'
    endif
  endif
  return a:origin
endfunction

function! WikiFileOpen(...) abort dict
  if self.path =~# 'pdf$'
    let l:cmd = '!nohup zathura '.fnameescape(self.path)
    if get(self, 'page')
        let l:cmd .= ' -P '.string(self.page)
    endif
    silent execute l:cmd.' &'
    redraw!
    return 1
  endif
  return 0
endfunction

function! WikiPostOpen(fname)
    let l:fnew = !filereadable(expand('%'))
    "let l:fnew = filereadable(a:fname)

    " snippets for new files
    " nvim note: a space is added after the snip for this to work
    if l:fnew
      if a:fname =~# 'task-[a-z0-9]\{8\}.md'
        normal! iwn 
        call UltiSnips#ExpandSnippet()
      endif
      if a:fname =~# '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}'
        normal! iwj 
        call UltiSnips#ExpandSnippet()
      endif
    endif
endfunction


"" Vim-roam ""
let g:roam_search_wrap_link = 'WrapLink'

function! WrapLink(lines)
    let l:link = join(a:lines)
    let l:link = FnameToString(l:link)
    if fnamemodify(l:link, ':e') == 'pdf'
        let l:link = '[['.l:link.']]'
    else
        let l:link = '[['.fnamemodify(l:link,':r').']]'
    endif

    if getcurpos()[2]+strlen(l:link) > &tw
        let l:spacing = repeat(' ', &tw - getcurpos()[2])
        let l:link = l:spacing . l:link
    endif

    " get link string for path (assumed relative to wiki root)
    return l:link
endfunction

let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

"" Taskwiki config ""
let g:taskwiki_markup_syntax = 'markdown'
let g:taskwiki_sort_order = 'status-,urgency-'
let g:taskwiki_task_note_metadata = 1
let g:taskwiki_disable_concealcursor = 1
"let g:taskwiki_task_root = 'tasks'
"let g:taskwiki_dont_preserve_folds = 1
"


" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

"""

" Tree setup
"let g:nvim_tree_gitignore = 1 "0 by default
"let g:nvim_tree_quit_on_open = 0 "0 by default, closes the tree when you open a file
"let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
"let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
"let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
"let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
"let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
"let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
"let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
"let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
"let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
"let g:nvim_tree_create_in_closed_folder = 0 "1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
"let g:nvim_tree_refresh_wait = 500 "1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
"let g:nvim_tree_window_picker_exclude = {
"    \   'filetype': [
"    \     'notify',
"    \     'packer',
"    \     'qf'
"    \   ],
"    \   'buftype': [
"    \     'terminal'
"    \   ]
"    \ }
"" Dictionary of buffer option names mapped to a list of option values that
"" indicates to the window picker that the buffer's window should not be
"" selectable.
"let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
"let g:nvim_tree_show_icons = {
"    \ 'git': 1,
"    \ 'folders': 0,
"    \ 'files': 0,
"    \ 'folder_arrows': 0,
"    \ }
""If 0, do not show the icons for one of 'git' 'folder' and 'files'
""1 by default, notice that if 'files' is 1, it will only display
""if nvim-web-devicons is installed and on your runtimepath.
""if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
""but this will not work when you set indent_markers (because of UI conflict)
"
"" default will show icon by default if no icon is provided
"" default shows no icon by default
"let g:nvim_tree_icons = {
"    \ 'default': '',
"    \ 'symlink': '',
"    \ 'git': {
"    \   'unstaged': "✗",
"    \   'staged': "✓",
"    \   'unmerged': "",
"    \   'renamed': "➜",
"    \   'untracked': "★",
"    \   'deleted': "",
"    \   'ignored': "◌"
"    \   },
"    \ 'folder': {
"    \   'arrow_open': "",
"    \   'arrow_closed': "",
"    \   'default': "",
"    \   'open': "",
"    \   'empty': "",
"    \   'empty_open': "",
"    \   'symlink': "",
"    \   'symlink_open': "",
"    \   }
"    \ }
"
""nmap <leader>d :NvimTreeToggle<CR>
""nnoremap <leader>r :NvimTreeRefresh<CR>
""nnoremap <leader>n :NvimTreeFindFile<CR>
"" NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize are also available if you need them
"
"" a list of groups can be found at `:help nvim_tree_highlight`
"highlight NvimTreeFolderIcon guibg=blue


"" LSP bindings ""
lua << EOF
local nvim_lsp = require('lspconfig')
local coq = require('coq')

--local vim.g.coq_settings.keymap.pre_select = true

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd', 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }))
end


--local use = require('packer').use
--require('packer').startup(function()
--  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
--  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
--  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
--end)

---- Add additional capabilities supported by nvim-cmp
--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = require('coq').lsp_ensure_capabilities(capabilities)
--
---- Enable some language servers with the additional completion capabilities offered by nvim-cmp
--local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
--for _, lsp in ipairs(servers) do
--  nvim_lsp[lsp].setup {
--    -- on_attach = my_custom_on_attach,
--    capabilities = capabilities,
--  }
--end
--
---- Set completeopt to have a better completion experience
--vim.o.completeopt = 'menuone,noselect'
--
---- luasnip setup
----local luasnip = require 'luasnip'
--
---- nvim-cmp setup
--local cmp = require 'cmp'
--cmp.setup {
--  mapping = {
--    ['<C-p>'] = cmp.mapping.select_prev_item(),
--    ['<C-n>'] = cmp.mapping.select_next_item(),
--    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--    ['<C-f>'] = cmp.mapping.scroll_docs(4),
--    ['<C-Space>'] = cmp.mapping.complete(),
--    ['<C-e>'] = cmp.mapping.close(),
--    ['<CR>'] = cmp.mapping.confirm {
--      behavior = cmp.ConfirmBehavior.Replace,
--      select = true,
--    },
--  },
--  sources = {
--    { name = 'nvim_lsp' },
--  },
--}

-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}


EOF

" small coq settings
let g:coq_settings = {'keymap.pre_select' : v:true}


""""""""""""""""""""""
" POST PLUGIN CONFIG "
""""""""""""""""""""""
" Markdown indentation
au BufRead,BufNewFile *.md filetype indent off
au BufRead,BufNewFile *.md setlocal spell
au FileType markdown setlocal foldlevel=99

" general appearance
highlight clear LineNr
highlight clear CursorLineNr
highlight CursorLineNr cterm=bold
highlight clear SignColumn
highlight clear VertSplit

highlight clear SpellCap
highlight clear SpellBad
highlight clear SpellRare
highlight clear SpellLocal

highlight SpellBad cterm=underline gui=underline

" Transparent bg to match terminal, comes at end to ensure hi isn't overwritten
"highlight Normal guibg=NONE ctermbg=NONE

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

" fix bad mouse things
"noremap <LeftDrag> <LeftMouse>
"noremap! <LeftDrag> <LeftMouse>

" window movement remap
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" term map
nmap <Leader>z :bo 12split term://zsh<CR>i
" and to conveniently get back to normal mode; nvm too invasive rn
"tnoremap <Esc> <C-\><C-n>


" NERDTree map
"nmap <Leader>d :NERDTreeToggle<CR>
"nmap <Leader>d :CHADopen<CR>
nmap <Leader>d :NvimTreeToggle<CR>


" general search, commands from `.vim/after`
nmap <Leader>df :DirFzfFiles<CR>
nmap <Leader>dl :DirFzfLines<CR>

" tabular formatted tables
inoremap <silent> <Bar>   <Bar><Esc>:call TableAlign()<CR>a

" easy copying
vmap <C-c> "+y

" open current page name as HTML file using `xdg-open`
nmap <Leader>wo :call system('xdg-open "http://localhost:8000/' . expand('%:p:t:r') . '.html"')<CR>

inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.g:wiki_rootroot.'/figures/pdf_tex/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.g:wiki_root.'/figures/pdf_tex" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
