" ----------------------------------------------------------------------------
"  Vundle setup
" ----------------------------------------------------------------------------
set nocompatible  " because that's why!
filetype off      " Required for Vundle

set rtp+=~/.vim/bundle/vundle/  " Add vundle to the RuntimePath
call vundle#rc()

" Let Vundle manage Vundle. Required!
Bundle 'gmarik/vundle'

" Language-specific syntax files
Bundle 'elzr/vim-json'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-git'
Bundle 'hail2u/vim-css-syntax'
Bundle 'mattn/zencoding-vim'

" Various editing plugins
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'godlygeek/tabular'
Bundle 'tsaleh/vim-matchit'
Bundle 'vim-scripts/closetag.vim'
Bundle 'kana/vim-textobj-user'
Bundle 'glts/vim-textobj-comment'
Bundle 'Valloric/YouCompleteMe'
Bundle 'csexton/trailertrash.vim'

" misc
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/LaTeX-Box'

" statusline
Bundle 'bling/vim-airline'
Bundle 'bling/vim-bufferline'
let g:airline_theme = 'hybrid'

" Syntax check on buffer save
Bundle 'scrooloose/syntastic'

" Colorschemes
"Bundle 'flazz/vim-colorschemes'
Bundle 'w0ng/vim-hybrid'

filetype plugin indent on     " required!

" ----------------------------------------------------------------------------
"  moving around, searching and patterns
" ----------------------------------------------------------------------------
"set nostartofline   " keep cursor in same column for long-range motion cmds
set incsearch       " Highlight pattern matches as you type
set ignorecase      " ignore case when using a search pattern
set smartcase       " override 'ignorecase' when pattern
                    " has upper case character
nnoremap j gj
nnoremap k gk
nnoremap K gk

" ----------------------------------------------------------------------------
"  displaying text
" ----------------------------------------------------------------------------
set scrolloff=3       " number of screen lines to show around
                      " the cursor

set linebreak         " For lines longer than the window,
                      " wrap intelligently. This doesn't
                      " insert hard line breaks.

set sidescrolloff=2   " min # of columns to keep left/right of cursor
set display+=lastline " show last line, even if it doesn't fit in the window

"set cmdheight=2      " # of lines for the command window
                      " cmdheight=2 helps avoid 'Press ENTER...'
                      " prompts

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
    "set listchars=tab:‣\ ,eol:¬,trail:~
  endif
endif

"set number           " show line numbers

" ----------------------------------------------------------------------------
"  syntax, highlighting and spelling
" ----------------------------------------------------------------------------
syntax enable
set background=dark

if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif
if &t_Co == 256
  " settings for pretty 256-color theme
  "colorscheme ir_black
  "colorscheme zenburn
  let g:hybrid_use_Xresources = 1
  colorscheme hybrid
endif

set cursorline "highlight current line

set hlsearch            " highlight the last searched term
"set colorcolumn=80    " display a line in column 80 to show you
                      " when to line break.

let g:tex_comment_nospell=1

" ----------------------------------------------------------------------------
"  multiple windows
" ----------------------------------------------------------------------------

set hidden "enable switching buffers without saving first

set laststatus=2 "show status line

set splitbelow "new split is below current
set splitright

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
"set mouse=a

" ----------------------------------------------------------------------------
"  messages and info
" ----------------------------------------------------------------------------
"TODO try this
"set showcmd          " In the status bar, show incomplete commands
                    " as they are typed

set ruler           " Always display the current cursor position in
                    " the Status Bar

" ----------------------------------------------------------------------------
"  selecting text
" ----------------------------------------------------------------------------
"set clipboard=unnamed  " Yank to the system clipboard by default

" ----------------------------------------------------------------------------
"  editing text
" ----------------------------------------------------------------------------
set backspace=indent,eol,start  "backspace over everything

"TODO try
"set showmatch            " when inserting a bracket, briefly jump to its
                        " match

" ----------------------------------------------------------------------------
"  tabs and indenting
" ----------------------------------------------------------------------------
"set smarttab              " <TAB> in front of line inserts 'shiftwidth' blanks
set shiftround            " round to 'shiftwidth' for "<<" and ">>"

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set cindent
set cinkeys-=0#
set cinkeys-=:

" ----------------------------------------------------------------------------
"  folding
" ----------------------------------------------------------------------------
"set nofoldenable       " When opening files, all folds open by default
set foldenable "enable folding
set foldlevelstart=10 " open most folds by default

" ----------------------------------------------------------------------------
"  diff mode
" ----------------------------------------------------------------------------

" ----------------------------------------------------------------------------
"  mapping
" ----------------------------------------------------------------------------
"
let mapleader = "\<space>"

"map escape to 'jj' in insert mode
inoremap jj <esc>

"cancel higlighting
nmap <leader>n :nohlsearch<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

nmap <leader>a :set paste!<CR>

nmap <leader>w :w<CR>

"copy/paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"sudo write
cnoremap w!! w !sudo tee % > /dev/null<CR>
nmap <leader>W :!sudo tee % > /dev/null<CR>

"disable help popping up on F1"
nnoremap <F1> <nop>
inoremap <F1> <nop>

" ----------------------------------------------------------------------------
"  reading and writing files
" ----------------------------------------------------------------------------
set autoread          " Automatically re-read files changed outside
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
set history=200     " Save more commands in history
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
"  zencoding
let g:user_zen_expandabbr_key = '<c-e>'
let g:use_zen_complete_tag = 1
let g:user_zen_leader_key = '<c-k>'

" do not hide quotes in JSON
"set conceallevel=0 "incompatible with tyrande, move to local

set gdefault                    " For :substitute, use the /g flag by default

"enable modeline
set modelines=5
set modeline

nnoremap <leader>rr :source ~/.vimrc<CR>
nnoremap <leader>re :tabnew ~/.vimrc<CR>
nnoremap <leader>rz :tabnew ~/.zshrc<CR>
nnoremap <leader>ra :tabnew ~/.config/awesome/rc.lua<CR>

" ----- my old stuff
au BufNewFile,BufRead *.ics set filetype=ics

" ----------------------------------------------------------------------------
" Allow overriding these settings
" ----------------------------------------------------------------------------
if filereadable(expand("~/.vim_local"))
  source ~/.vim_local
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

command! Strip call <SID>StripTrailingWhitespaces()

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

" Compatible with ranger 1.4.2 through 1.6.*
"
" Add ranger as a file chooser in vim
"
" If you add this code to the .vimrc, ranger can be started using the command
" ":RangerChooser" or the keybinding "<leader>r". Once you select one or more
" files, press enter and ranger will quit again and vim will open the selected
" files.

function! RangeChooser()
  let temp = tempname()
" The option "--choosefiles" was added in ranger 1.5.1. Use the next line
" with ranger 1.4.2 through 1.5.0 instead.
"exec 'silent !ranger --choosefile=' . shellescape(temp)
  exec 'silent !ranger --choosefiles=' . shellescape(temp)
  if !filereadable(temp)
" Nothing to read.
    return
  endif
  let names = readfile(temp)
  if empty(names)
" Nothing to open.
    return
  endif
" Edit the first item.
  exec 'edit ' . fnameescape(names[0])
" Add any remaning items to the arg list/buffer list.
  for name in names[1:]
    exec 'argadd ' . fnameescape(name)
  endfor
endfunction
command! -bar RangerChooser call RangeChooser()

nnoremap <leader>o :<C-U>RangerChooser<CR><C-L>

"vim: set expandtab:
