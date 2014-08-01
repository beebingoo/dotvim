"--- Common setting ---
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number
" use an undo file
set undofile
" set a directory to store the undo history
set undodir=~/.vimundo/
" disable auto start a comment line
" autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
au FileType c,cpp setlocal comments-=:// comments+=f://

"--- Color scheme setting ---
se t_Co=256
" let g:solarized_termcolors=256
set background=light
colorscheme desert256
set colorcolumn=80
" hi ColorColumn guibg=#354248

"--- Set file encoding ---
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

"--- Fold setting ---
set foldmethod=syntax               " Syntax highlighting items specify folds.
set foldlevel=100
" set foldcolumn=5                  " set fold width

"--- Taglist setting ---
let Tlist_Process_File_Always=1     " real-time update tags
let Tlist_File_Fold_Auto_Close=1    " automatically close the tags tree for inactive files
let Tlist_Close_On_Select = 1
let Tlist_GainFocus_On_ToggleOpen = 1

"--- Vundle setting ---
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" required! 
Bundle 'gmarik/vundle'
" My Bundles here
" original GitHub repos
Bundle 'kien/ctrlp.vim'
" Bundle 'scrooloose/nerdtree'
" Legacy snipMate repo.
" Bundle 'vim-scripts/snipMate'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'
Bundle 'Rip-Rip/clang_complete'

" vim-script repos
" Bundle 'OmniCppComplete'
Bundle 'surround.vim'
Bundle 'taglist.vim'
Bundle 'tComment'
Bundle 'L9'
Bundle 'FuzzyFinder'

filetype plugin indent on     " required!
 
 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..

syntax enable
syntax on

"--- Cscope setting ---
if has("cscope")
	set csprg=/usr/bin/cscope      " specifies the command to execute cscope.
	set csto=0                     " determines search order.
	set cst                        " search database as well as tag files.
	set cscopequickfix=s-,c-,d-,i-,t-,e- " specifies wherher to use quickfix to show cscope results
	set nocsverb
	if filereadable("cscope.out")  " add cscope database if exist
		cs add cscope.out          
	elseif $CSCOPE_DB != ""        " else add the database pointed by enviroment
		cs add $CSCOPE_DB
	endif
	set csverb
endif

nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i <C-R>=expand("<cfile>")<CR><CR> :copen<CR><CR>

"--- Clang Complete Settings ---
let g:clang_use_library = 1
" CentOS install clang manually before use below path.
" let g:clang_library_path = '/usr/local/lib'
" Ubuntu apt-get install libclang-dev before use below path.
" Use $locate libclang to locate libclang after install,
" or find /usr -name libclang*
let g:clang_library_path = '/usr/lib/'
let g:clang_complete_copen = 1
let g:clang_complete_macros = 1
"let g:clang_complete_patterns = 1
" Remove -std=c++11 if you don't use C++ for everything like I do.
"let g:clang_user_options='-std=c++11 || exit 0'
let g:clang_auto_select = 1
let g:clang_snippets = 1
let g:clang_conceal_snippets = 1
set concealcursor=inv
set conceallevel=2

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0 && bufname("%") != "[Command Line]"|pclose|endif
autocmd InsertLeave * if pumvisible() == 0 && bufname("%") != "[Command Line]"|pclose|endif

"--- Key binding ---
" <tab> in snipmate conflict with clang_complete
imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

" F9 open taglist
nnoremap <silent> <F9> :TlistToggle<CR>

" F8 assignment
" nnoremap <silent> <F8> :NERDTreeToggle<CR>     " open nerdtree
" Highlight matches without moving
nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" F7 create a new tab
nnoremap <F7> :setl noai nocin nosi inde=<CR>
" nnoremap <silent> <F7> :tabnew<CR>

" F6 next tab
" nnoremap <silent> <f6> :tabn<CR>
nnoremap <silent> <f6> :setlocal comments-=:// comments+=f://<CR>

" F5 delete all trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" F5 previous tab
" nnoremap <silent> <F5> :tabp<CR>
