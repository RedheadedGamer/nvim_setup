"  _   _                 _
" | \ | | ___  _____   _(_)_ __ ___
" |  \| |/ _ \/ _ \ \ / / | '_ ` _ \
" | |\  |  __/ (_) \ V /| | | | | | |
" |_| \_|\___|\___/ \_/ |_|_| |_| |_|
"
" by Stephan Raabe (2023)
" -----------------------------------------------------

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
set showcmd
set ignorecase              " case insensitive
set mouse=v                 " middle-click paste with
set smartindent
set hlsearch                " highlight search
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set ruler
set relativenumber
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
" set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set spell                 " enable spell check (may need to download language package)
set noswapfile            " disable creating swap file
set backupdir=~/.cache/vim " Directory to store backup files.
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"
let &t_SR = "\e[2 q"
set termguicolors
set statusline=%l,%c
set noexpandtab

" --- Filetype detection and settings for .wistl files (Vimscript version) ---
augroup wistl_filetype
  autocmd!
  autocmd BufReadPost,BufNewFile *.wistl setfiletype wistl
  autocmd FileType wistl setlocal autoindent
  autocmd FileType wistl setlocal expandtab
  autocmd FileType wistl setlocal shiftwidth=4
  autocmd FileType wistl setlocal softtabstop=4
  autocmd FileType wistl setlocal tabstop=4
  autocmd FileType wistl setlocal textwidth=80
augroup END
set grepprg=rg\ --vimgrep\ --hidden\ --smart-case 
set grepformat=%f:%l:%c:%m

call plug#begin()

Plug 'olimorris/onedarkpro.nvim'
Plug 'sainnhe/everforest'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'rktjmp/lush.nvim'
Plug 'Scysta/pink-panic.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'
Plug 'numToStr/Comment.nvim'

call plug#end()

colorscheme onedark_dark

autocmd VimEnter * if !filereadable("tags") | silent! !ctags -R . | endif
autocmd VimEnter *
  \ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) |
  \   PlugInstall --sync | source $MYVIMRC |
  \ endif
autocmd VimEnter * CocStart

" --- Transparent background highlight groups ---
hi NonText ctermbg=none guibg=NONE
hi Normal guibg=NONE ctermbg=NONE
hi NormalNC guibg=NONE ctermbg=NONE
hi SignColumn ctermbg=NONE ctermfg=NONE guibg=NONE
hi Pmenu ctermbg=NONE ctermfg=NONE guibg=NONE
hi FloatBorder ctermbg=NONE ctermfg=NONE guibg=NONE
hi NormalFloat ctermbg=NONE ctermfg=NONE guibg=NONE
hi TabLine ctermbg=None ctermfg=None guibg=None
hi LineNr guibg=NONE ctermbg=NONE
hi CursorLineNr guibg=NONE ctermbg=NONE
hi StatusLine guibg=NONE ctermbg=NONE
hi StatusLineNC guibg=NONE ctermbg=NONE

" Always use utf-8 and avoid backup files
set encoding=utf-8
set nobackup
set nowritebackup

" Faster updatetime for better UX
set updatetime=300

" Always show signcolumn for diagnostics
set signcolumn=yes

" Tab and Shift-Tab for completion navigation
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Enter key for completion confirm
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Trigger completion with Ctrl-@
inoremap <silent><expr> <c-@> coc#refresh()

" Go to previous/next diagnostic
nmap [g <Plug>(coc-diagnostic-prev)
nmap ]g <Plug>(coc-diagnostic-next)

" Basic GoTo mappings
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)

" Show documentation in preview window
nnoremap K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight symbol under cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
lua require('Comment').setup()

" Code actions
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>qf <Plug>(coc-fix-current)

let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

filetype plugin indent on

" Statusline integration
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

set textwidth=80
set formatoptions+=t

lua require'nvim-treesitter.configs'.setup{highlight={enable=true}} 

