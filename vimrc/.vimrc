" Syntax highlighting on
syntax on

nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')

nnoremap <silent> <leader>lg :LazyGit<CR>

set spelllang=en_us
set spell

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

" views can only be fully collapsed with the global statusline
set laststatus=3

" Enable mouse mode
set mouse=a

set undofile

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

set scrolloff=8
