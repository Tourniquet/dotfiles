call pathogen#infect()

filetype plugin indent on
autocmd FileType php set keywordprg=~/code/php/phpdoc.sh

" set ai                  " auto indenting
set history=100         " keep 100 lines of history
set ruler               " show the cursor position
syntax on               " syntax highlighting
color ir_black
set hlsearch            " highlight the last searched term
filetype plugin on      " use the file type plugins
au BufNewFile,BufRead *.ics set filetype=ics
" set nu			" Line Numbers
set tabstop=2
set softtabstop=2
set shiftwidth=2		" tab = 4 spaces
set noexpandtab
"set autoindent
set cindent
set cinkeys-=0#
set cinkeys-=:

"search case
set ignorecase 
set smartcase 

set listchars=tab:‣\ ,eol:¬,trail:~

set encoding=utf-8

"map escape to 'jj' in insert mode
:inoremap jj <esc>
:nnoremap <space> :noh

"mouse support
set mouse=a

"enabling deleting of stuff not entered in this insert session
set backspace=2

"enable modeline
set modelines=5
set modeline

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

nmap <leader>p :set paste!<CR>

"improved % - match xml tags
"source ~/.vim/plugin/matchit.vim
filetype plugin on

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

