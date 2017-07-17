"" Plugins

call plug#begin('~/.vim/plugged')

"" Shared
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-projectionist'
Plug 'benmills/vimux'
Plug 'janko-m/vim-test'

"" File Management
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'

"" Theming and UI tweaks
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'ntpeters/vim-better-whitespace'

"" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"" GitHub
Plug 'jaxbot/github-issues.vim'
Plug 'keith/gist.vim'

"" Autocomplete
Plug 'tpope/vim-endwise'
Plug 'ervandew/supertab'

"" Secrets!
Plug 'jamessan/vim-gnupg'

"" Clojure
Plug 'kien/rainbow_parentheses.vim'
Plug 'vim-scripts/paredit.vim'
Plug 'tpope/vim-fireplace'
Plug 'guns/vim-clojure-static'
" Plug 'venantius/vim-cljfmt'

"" Elixir
Plug 'elixir-lang/vim-elixir'

"" Go
Plug 'fatih/vim-go'

"" Obj-C / Swift
Plug 'keith/swift.vim'

"" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rake'

"" Rust
Plug 'rust-lang/rust.vim'

"" Python
Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'
call plug#end()

let python_highlight_all=1

"" Airline
:set laststatus=2 " Required to work without splits.

"" Basic

" Integrate with system keyboard on Unix Systems.
"" On macOS, this is the unnamed pasteboard, on other unix systems this is +
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    set clipboard=unnamed
  else
    set clipboard=unnamedplus
  endif
endif

" Sensible Backspace Support
:set backspace=indent,eol,start

" Formatting
set tabstop=2    " Use 2 spaces to a tab
set shiftwidth=2 " As above
set expandtab    " Expand tabs into spaces

autocmd FileType swift set tabstop=4
autocmd FileType swift set shiftwidth=4

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Map leader to ,
let mapleader=','

"" Save
nmap <leader>w :w!<cr>

" Move up and down on splitted lines (on small width screens)
map <Up> gk
map <Down> gj
map k gk
map j gj

"" Mousing
set mouse=a

"" Testing
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

"" Visual Settings
syntax enable
set ruler

" Line Numbering
set number

"" Automatically switch between relativenumber and regular numbering when
"" going in and out of insert mode.
nnoremap <silent><leader>1 :set rnu! rnu? <cr>
autocmd InsertEnter * silent! :set norelativenumber
autocmd InsertLeave,BufNewFile,VimEnter * silent! :set relativenumber

" Highlight all search matches
set hlsearch

"" Sometimes disabling this is really nice.
nnoremap <leader><space> :nohlsearch<CR>

" Highlight current line
set cursorline

" Enable line wrapping
set wrap linebreak nolist
set colorcolumn=80

" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

" Pretty Colours
set background=dark
colorscheme solarized
call togglebg#map("<F5>")

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Fira\ Code\ Retina:h14
  endif
endif

"" Abbreviations

" Nobody is happy until they have these
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wq wq
cnoreabbrev WQ wq

" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
set splitright

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" Make
nnoremap <Leader>m :make<CR>

" NERDTree configuration
let g:NERDTreeShowHidden=1
noremap <Leader>3 :NERDTreeToggle<CR>

if executable('rg')
  " Use rg instead of grep
  set grepprg=rg\ --column\ --color=never

  " Use rg for ctrlp for listing files
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'

  " rg is fast enough that we don't need caching
  let g:ctrlp_use_caching = 0
else
  "" This ignores the `.git` directory and submodules.
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
endif

"" Other

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

"" Clojure
let g:clojure_align_subforms = 1

" Make sure that .cljx files are recognised as Clojure.
autocmd BufNewFile,BufRead *.cljx setlocal filetype=clojure

" Rainbow parens for Clojure

" Remove Black Parens
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 15
autocmd Filetype clojure RainbowParenthesesActivate
autocmd Syntax clojure RainbowParenthesesLoadRound

"" Go specific configuration

" Easy Runnings
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>c <Plug>(go-coverage)

" Look ups and documentation
autocmd FileType go nmap <Leader>ds <Plug>(go-def-split)
autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
autocmd FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

" Enable syntax-highlighting for Functions, Methods and Structs
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Syntastic doesn't always play nicely with vim-go
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
