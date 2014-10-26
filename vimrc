set t_Co=256        " 256 colors enabled
set ls=2            " allways show status line #powerline plugin
set tabstop=4       " numbers of spaces of tab character
set shiftwidth=4    " numbers of spaces to (auto)indent
set scrolloff=3     " keep 3 lines when scrolling
set showcmd         " display incomplete commands
set hlsearch        " highlight searches
set number          " show line numbers
set numberwidth=5   " number of spaces in line number
set background=dark " adapt colors for background
set mouse=a         " enable mouse (fix mouse scrolling in urxvt)
set showmatch
set cursorline      " Enable CursorLine
set nocompatible    " be iMproved
set encoding=utf-8
set nocscopeverbose " Workaround to fix duplicated message


set bs=2            " This influences the behavior of the backspace option. It is fairly complex so see :help 'bs' for more details.
"set wrapmargin=8    " This is the number of characters from the right window border where wrapping starts.
set ruler           " This makes vim show the current row and column at the bottom right of the screen.


if &t_Co == 256
	highlight CursorLine   ctermbg=235 ctermfg=NONE cterm=NONE
	highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
	highlight WARN ctermbg=red

	" Change Color when entering Insert Mode
	autocmd InsertEnter * highlight  CursorLine ctermbg=17 ctermfg=NONE

	" Revert Color to default when leaving Insert Mode
	autocmd InsertLeave * highlight  CursorLine ctermbg=235 ctermfg=NONE
endif


" Toggle “invisible” characters
function! ToggleInvisible()
	if &list
		set lcs=
		set nolist
	else
		set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
		set list
	endif
endfunction

map <F7> :call ToggleInvisible()<CR>

syntax on

" force to save if not have permissions
cmap w!! %!sudo tee > /dev/null %

" enable ctrl+c
vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>


inoremap jk <esc>

match WARN /\s\+$/
autocmd FileType c,cpp match WARN /\s\+$\|\%>80v.\+/

" for python
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4

" call gcc directly if a Makefile is not found
if !filereadable("Makefile")
	setlocal makeprg=gcc\ -Wall\ -Wextra\ -o\ %<\ %
endif

if filereadable(".make")
	setlocal makeprg=.\ .make
endif

map <F5> :make<CR><CR>

"""" GNU Coding Standards

function! GnuIndent()
	setlocal cindent
	setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
	setlocal expandtab
	setlocal shiftwidth=2
	setlocal tabstop=8
	setlocal softtabstop=2
	setlocal textwidth=80
	setlocal fo-=ro fo+=cql
endfunction

"autocmd FileType c,cpp call GnuIndent()
"autocmd BufEnter */grub*/* call GnuIndent()
autocmd BufEnter */grub*/**/*.{c,h} call GnuIndent()


"""" 80 Columns

set colorcolumn=80
"let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27


"""" Templates

augroup templates
  au!
  " read in templates files
  autocmd BufNewFile *.* silent! execute '0r ~/.vim/templates/skeleton.'.expand("<afile>:e")
augroup END


"""" Vundle

filetype off                  " required!
filetype plugin indent on     " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'ctags.vim'

Bundle 'cscope_macros.vim'
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

Bundle 'scrooloose/nerdtree'
map <F3> :NERDTreeToggle<CR>

Bundle 'scrooloose/nerdcommenter'

Bundle 'vim-scripts/vimwiki'
let g:vimwiki_list = [{'path': '~/Dropbox/Wiki/'}, {'path': '~/ibm/wiki/'}]

Bundle 'AutoComplPop'

Bundle 'a.vim'

Bundle 'SpellCheck'

Bundle 'po.vim'

Bundle 'mru.vim'
map <F4> :MRU<CR>

Bundle 'fugitive.vim'

Bundle 'Lokaltog/vim-powerline'
"let g:Powerline_symbols = 'fancy'

Bundle 'powerman/vim-plugin-viewdoc'

Bundle 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

Bundle 'kien/ctrlp.vim'

Bundle 'gnupg.vim'

Bundle 'vcscommand.vim'

Bundle 'Shougo/unite.vim'
nnoremap <space>/ :Unite grep:.<CR>
nnoremap <space>y :Unite history/yanks<cr>
nnoremap <space>s :Unite -quick-match buffer<cr>

Bundle 'tpope/vim-fugitive'
