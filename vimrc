" ----------------------------------------------------------------------------
"  Vundle setup
" ----------------------------------------------------------------------------
filetype off 			" Required for Vundle

set rtp+=~/.vim/bundle/vundle/	" Add vundle to the RuntimePath
call vundle#rc()

" Let Vundle manage Vundle. Required!
Bundle 'gmarik/vundle'

" Language-specific syntax files
Bundle 'elzr/vim-json'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-git'

" Various editing plugins
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'godlygeek/tabular'
Bundle 'tsaleh/vim-matchit'
Bundle 'vim-scripts/closetag.vim'

" Git plugins
Bundle 'tpope/vim-fugitive'

" Syntax check on buffer save
Bundle 'scrooloose/syntastic'

" Colorschemes
"Bundle 'altercation/vim-colors-solarized'

filetype plugin indent on     " required!

" ----------------------------------------------------------------------------
"  moving around, searching and patterns
" ----------------------------------------------------------------------------
"set nostartofline   " keep cursor in same column for long-range motion cmds
set incsearch			  " Highlight pattern matches as you type
set ignorecase			" ignore case when using a search pattern
set smartcase			  " override 'ignorecase' when pattern
                    " has upper case character

" ----------------------------------------------------------------------------
"  displaying text
" ----------------------------------------------------------------------------
set scrolloff=3       " number of screen lines to show around
                      " the cursor

set linebreak			    " For lines longer than the window,
                      " wrap intelligently. This doesn't
                      " insert hard line breaks.

set sidescrolloff=2		" min # of columns to keep left/right of cursor
set display+=lastline " show last line, even if it doesn't fit in the window

"set cmdheight=2 		  " # of lines for the command window
                      " cmdheight=2 helps avoid 'Press ENTER...'
                      " prompts

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
    "set listchars=tab:‣\ ,eol:¬,trail:~
  endif
endif

"set number			      " show line numbers

" ----------------------------------------------------------------------------
"  syntax, highlighting and spelling
" ----------------------------------------------------------------------------
syntax enable
set background=dark
colorscheme ir_black

set hlsearch            " highlight the last searched term
"set colorcolumn=80    " display a line in column 80 to show you
                      " when to line break.

" ----------------------------------------------------------------------------
"  multiple windows
" ----------------------------------------------------------------------------

set hidden

set laststatus=2 "show status line

set statusline=
set statusline+=b%-1.3n\ >                    " buffer number
set statusline+=\ %{fugitive#statusline()}:
set statusline+=\ %F
set statusline+=\ %M
set statusline+=%R
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%=
set statusline+=\ %Y
set statusline+=\ <\ %{&fenc}
set statusline+=\ <\ %{&ff}
set statusline+=\ <\ %p%%
set statusline+=\ %l:
set statusline+=%02.3c  

" jamessan's statusline
"set statusline=   " clear the statusline for when vimrc is reloaded
"set statusline+=%-3.3n\                      " buffer number
"set statusline+=%f\                          " file name
"set statusline+=%h%m%r%w                     " flags
"set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
"set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
"set statusline+=%{&fileformat}]              " file format
"set statusline+=%=                           " right align
"set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
"set statusline+=%b,0x%-8B\                   " current char
"set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" ----------------------------------------------------------------------------
"  multiple tab pages
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
"  terminal
" ----------------------------------------------------------------------------
set ttyfast

" ----------------------------------------------------------------------------
"  using the mouse
" ----------------------------------------------------------------------------
set mouse=a

" ----------------------------------------------------------------------------
"  messages and info
" ----------------------------------------------------------------------------
"TODO try this
"set showcmd			    " In the status bar, show incomplete commands 
                    " as they are typed

set ruler			      " Always display the current cursor position in
                    " the Status Bar

" ----------------------------------------------------------------------------
"  selecting text
" ----------------------------------------------------------------------------
"set clipboard=unnamed	" Yank to the system clipboard by default

" ----------------------------------------------------------------------------
"  editing text
" ----------------------------------------------------------------------------
set backspace=indent,eol,start  "backspace over everything

"TODO try
"set showmatch  			    " when inserting a bracket, briefly jump to its
                        " match

" ----------------------------------------------------------------------------
"  tabs and indenting
" ----------------------------------------------------------------------------
"set smarttab              " <TAB> in front of line inserts 'shiftwidth' blanks
set shiftround            " round to 'shiftwidth' for "<<" and ">>" 

set tabstop=2
set softtabstop=2
set shiftwidth=2	
set noexpandtab

set cindent
set cinkeys-=0#
set cinkeys-=:

" ----------------------------------------------------------------------------
"  folding
" ----------------------------------------------------------------------------
set nofoldenable 		  " When opening files, all folds open by default

" ----------------------------------------------------------------------------
"  diff mode
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
"  mapping
" ----------------------------------------------------------------------------
"map escape to 'jj' in insert mode
:inoremap jj <esc>

"space cancels higlighting
:nnoremap <space> :noh

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

nmap <leader>p :set paste!<CR>

"sudo write
cnoremap w!! w !sudo tee % > /dev/null

" ----------------------------------------------------------------------------
"  reading and writing files
" ----------------------------------------------------------------------------
set autoread			    " Automatically re-read files changed outside
                      " of Vim

" ----------------------------------------------------------------------------
"  the swap file
" ----------------------------------------------------------------------------

"if has("win32") || has("win64")
"  set directory=$TEMP
"else
"  " Vim will try this ordered list of directories for .swp files
"  set directory=~/tmp,.,/var/tmp,/tmp
"endif

" ----------------------------------------------------------------------------
"  command line editing
" ----------------------------------------------------------------------------
set history=200 		" Save more commands in history
                    " See Practical Vim, by Drew Neil, pg 68

set wildmode=list:longest,full

" File tab completion ignores these file patterns
set wildignore+=*.exe,*.swp,.DS_Store
set wildmenu

" Add guard around 'wildignorecase' to prevent terminal vim error
if exists('&wildignorecase')
  set wildignorecase
endif

" ----------------------------------------------------------------------------
"  executing external commands
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
"  running make and jumping to errors
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
"  language specific
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
"  multi-byte characters
" ----------------------------------------------------------------------------
set encoding=utf-8

" ----------------------------------------------------------------------------
"  various
" ----------------------------------------------------------------------------
set gdefault                    " For :substitute, use the /g flag by default

"enable modeline
set modelines=5
set modeline

" ----- my old stuff
au BufNewFile,BufRead *.ics set filetype=ics

" ----------------------------------------------------------------------------
" Allow overriding these settings
" ----------------------------------------------------------------------------
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" ----------------------------------------------------------------------------
" Autocmds
" ----------------------------------------------------------------------------

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

command Strip call <SID>StripTrailingWhitespaces()

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction
  
function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

