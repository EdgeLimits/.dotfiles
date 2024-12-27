" Syntax highlighting on
syntax on

" nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
" nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <silent> <leader>lg :LazyGit<CR>

nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

set spelllang = "en_us"
set spell

set syntax="ON"
set tabstop=2 softtabstop=0 shiftwidth=2 smarttab

" Expand tabs to spaces
set expandtab

" Show matching parentheses
set showmatch

" Highlight search matches
set hlsearch

" Show lineumbers
set number
set relativenumber

" Automatically indent on newline
set autoindent
set breakindent

" Ignore case when searching
set ignorecase
set smartcase

" Always show status line
set laststatus=2

" Enable mouse mode
set mouse=a

set undofile

set ignorecase
set smartcase

set signcolumn

set updatetime=250
set timeoutlen=300

set splitright
set splitbelow

" show cursor line
set cursorline

set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

" Make the autocompletion window more accessible
set completeopt=menu,menuone,noselect

"" Better movement through wrapped lines
noremap j gj
noremap k gk

set scrolloff=8
" Better Netrw
" let g:netrw_banner=0 " Hide banner
" let g:netrw_liststyle=3 " Tree-style view
" let g:netrw_browse_split=4 " Open in previous window
" let g:netrw_altv=1 " Open with right splitting
