"--- Common setting --- {{{
set tabstop=4          " number of visual spaces per TAB
set shiftwidth=4
set softtabstop=4      " number of spaces in tab when editing
set expandtab          " tabs are spaces
set number             " show line numbers
set autowrite
set showcmd            " show command in bottom bar
set wildmenu           " visual autocomplete for command menu
set clipboard+=unnamed " sync clipboard with system's
set undofile           " use an undo file
set incsearch          " search as characters are entered
set hidden             " improve vim-ctrlspace overall experience
"-- Set a directory to store the undo history
set undodir=~/.vimundo/
"-- Disable auto start a comment line
" autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
au FileType c,cpp setlocal comments-=:// comments+=f://
"-- Set file encoding
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
"-- Auto paste mode {{{
if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function! XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
    cmap <Esc>[200~ <nop>
    cmap <Esc>[201~ <nop>
endif
" }}}
"-- Vimscript file settings
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

"--- Slow down perform setting --- {{{
"-- Syntax highlighting items specify folds, will slow vim down
set foldmethod=syntax
set foldlevel=100
" set foldcolumn=5     " set fold width
" }}}

"--- Vundle setting --- {{{
"-- Be iMproved
set nocompatible
"-- Required!
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"-- let Vundle manage Vundle
"-- ($ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle)
"-- Required!
Bundle 'gmarik/vundle'
"-- My Bundles here
"-- Original GitHub repos
"-- Search Plugin
Bundle 'kien/ctrlp.vim'
Bundle 'rking/ag.vim'
Bundle 'Shougo/unite.vim'
"-- Explorer
Bundle 'sjl/gundo.vim'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdtree'
Plugin 'szw/vim-ctrlspace'
" Call-Tree Explorer
Plugin 'hari-rangarajan/CCTree'
"-- Dispaly
Plugin 'airblade/vim-gitgutter'
Bundle 'scrooloose/syntastic'
Bundle 'Yggdroot/indentLine'
" nathanaelkane/vim-indent-guides uses listchar as indent guide
" Bundle 'nathanaelkane/vim-indent-guides'
" automatically adjusts 'shiftwidth' and 'expandtab'
Plugin 'tpope/vim-sleuth'
" All tailing whitespace charecters to be highlighten
Bundle 'ntpeters/vim-better-whitespace'
"-- Edit helper
"-- Legacy snipMate repo.
" Bundle 'vim-scripts/snipMate'
"-- snipmate dependent
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Rip-Rip/clang_complete'
Bundle 'terryma/vim-multiple-cursors'
" automatic closing of quotes, parenthesis, brackets, etc.
Bundle 'Raimondi/delimitMate'
" Aligning text
Plugin 'godlygeek/tabular'
" A Git wrapper
Plugin 'tpope/vim-fugitive'
"--- color scheme
Plugin 'nanotech/jellybeans.vim'
Plugin 'tomasr/molokai'
Bundle 'croaker/mustang-vim'

"-- Vim-script repos
" Bundle 'OmniCppComplete'
Bundle 'surround.vim'
Bundle 'tComment'
"-- FuzzyFinder dependent
" Bundle 'L9'
" Bundle 'FuzzyFinder'
" Bundle 'Align'
Bundle 'a.vim'
Plugin 'DoxygenToolkit.vim'
Bundle 'SuperTab'
Plugin 'gtags.vim'
Bundle 'DrawIt'

"-- Slow-down vim plugin {{{
"--- Legacy powerline repo
" Bundle 'Lokaltog/vim-powerline'
Plugin 'bling/vim-airline'
" Bundle 'taglist.vim'
"}}}

filetype plugin indent on     " Required!

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
" }}}

"--- Color scheme setting --- {{{
se t_Co=256
" let g:solarized_termcolors=256
set background=dark
colorscheme mustang
highlight ColorColumn ctermfg=yellow ctermbg=bg guibg=#2c2d27
" set colorcolumn=80
let &colorcolumn=join(range(81,999),",")
set textwidth=80
"-- Useful to align text.
" set cursorcolumn
" }}}

"--- Cscope setting --- {{{
if has("cscope")
"-- Specifies the command to execute cscope.
	set csprg=/usr/bin/cscope
"-- Determines search order.
	set csto=0
"-- Search database as well as tag files.
	set cst
"-- Specifies wherher to use quickfix to show cscope results
	set cscopequickfix=s-,c-,d-,i-,t-,e-
	set nocsverb
"-- Add cscope database if exist
	if filereadable("cscope.out")
		cs add cscope.out
"-- else add the database pointed by enviroment
	elseif $CSCOPE_DB != ""
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
" }}}

"--- Clang Complete Settings --- {{{
let g:clang_use_library = 1
"-- CentOS install clang manually before use below path.
" let g:clang_library_path = '/usr/local/lib'
"-- Ubuntu (# apt-get install libclang-dev) before use below path.
"-- Use ($ locate libclang) to locate libclang after install,
"-- and (# updatedb) to update the database locate depend on,
"-- or ($ find /usr -name libclang*)
if has("unix")
    let s:issue = system("cat /etc/issue | awk '$1 {print $1}'")
    if s:issue == "Ubuntu\n"
	let g:clang_library_path = '/usr/lib/llvm-3.4/lib/'
    else
	let g:clang_library_path = '/usr/local/lib'
    endif
endif
let g:clang_complete_copen = 1
let g:clang_complete_macros = 1
"let g:clang_complete_patterns = 1
"-- Remove -std=c++11 if you don't use C++ for everything like I do.
"let g:clang_user_options='-std=c++11 || exit 0'
let g:clang_auto_select = 1
let g:clang_snippets = 1
let g:clang_conceal_snippets = 1
let g:clang_snippets_engine = 'clang_complete'
set concealcursor=inv
set conceallevel=2

"-- If you prefer the Omni-Completion tip window to close when a selection is
"-- made, these lines close it on movement in insert mode or when leaving
"-- insert mode
autocmd CursorMovedI * if pumvisible() == 0 && bufname("%") != "[Command Line]"|pclose|endif
autocmd InsertLeave * if pumvisible() == 0 && bufname("%") != "[Command Line]"|pclose|endif

" Troubleshootings
" Q: The completion works with the clang executable but when I use the clang
"    library I have the following error message: 'User defined completion
"    (^U^N^P) Pattern not found'
" A: Most of the time this is due to a compilation error. To identify the
"    problem do :call g:ClangUpdateQuickFix() followed by :copen. If you do not
"    see any compilation problem and you still have '... Pattern not found'
"    check that the clang library's is correctly loaded (put some debug messages
"    in libclang.py to understand what happens).
" }}}

"--- Plugin setting --- {{{
"-- Taglist setting
"--- Real-time update tags
let Tlist_Process_File_Always=1
"--- Automatically close the tags tree for inactive files
let Tlist_File_Fold_Auto_Close=1
let Tlist_Close_On_Select = 1
let Tlist_GainFocus_On_ToggleOpen = 1
"-- CtrlP
let g:ctrlp_max_files=0
" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in
" version control. It also supports works with .svn.
let g:ctrlp_working_path_mode = 'r'
"-- Powerline
set laststatus=2
"-- airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tagbar#enabled = 0
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" Minimum number of tabs needed to show the tabline
let g:airline#extensions#tabline#tab_min_count = 2
" Don't show buffers names if opened only one file
" let g:airline#extensions#tabline#buffer_min_count = 2
" show_buffers treats buffer as tab, count as well.
let g:airline#extensions#tabline#show_buffers = 0

"-- DoxygenToolkit
let g:DoxygenToolkit_briefTag_pre="Synopsis: "
let g:DoxygenToolkit_paramTag_pre="Param: "
let g:DoxygenToolkit_returnTag="Returns: "
let g:DoxygenToolkit_authorName="beebingoo"
let g:DoxygenToolkit_authorTag="Author: "
let g:DoxygenToolkit_fileTag="File: "
let g:DoxygenToolkit_dateTag="Date: "
let g:DoxygenToolkit_versionTag="Version: "
"-- syntastic
" let g:syntastic_c_include_dirs=['/usr/local/include/libxml2']
"-- SuperTab completion fall-back
let g:SuperTabDefaultCompletionType = '<c-x><c-u><c-p>'
"-- indentLine
let g:indentLine_enabled = 0
"-- ctrl-space
let g:airline_exclude_preview = 1
" }}}

"--- Key binding --- {{{
"-- Insert time stamp
imap <silent> <C-D><C-D> <C-R>=strftime("%Y-%b-%e")<CR>
imap <silent> <C-T><C-T> <C-R>=strftime("%l:%M %p")<CR>

"-- Gtags key mapping
nmap <leader>d :Gtags <C-r><C-w><CR>
nmap <leader>c :Gtags -r <C-r><C-w><CR>
nmap <leader>t :Gtags -g <C-r><C-w><CR>

"-- <tab> in snipmate conflict with clang_complete
imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

"-- F11 toggle NERDTree
nnoremap <silent> <F11> :NERDTreeToggle<CR>     " open nerdtree

"-- F10 Toggle Gundo
nnoremap <F10> :GundoToggle<CR>

"-- F9 toggle taglist
" nnoremap <silent> <F9> :TlistToggle<CR>
nnoremap <silent> <F9> :TagbarToggle<CR>

"-- F8 Highlight matches without moving
nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

"-- F7 Toggle indentline
nnoremap <F7> :IndentLinesToggle<CR>

"-- F5 delete all trailing whitespace
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

"-- F4 disable auto indent
nnoremap <F4> :setl noai nocin nosi inde=<CR>

"-- F3 temporary disable auto comment
nnoremap <silent> <f3> :setlocal comments-=:// comments+=f://<CR>

"-- F2 Toggle paste mode
set pastetoggle=<F2>

"-- F5 previous tab
" nnoremap <silent> <F5> :tabp<CR>
"-- F4 show clang output
" nnoremap <F4> :call g:ClangUpdateQuickFix()<CR>
"-- F7 create a new tab
" nnoremap <silent> <F7> :tabnew<CR>
"-- F6 next tab
" nnoremap <silent> <f6> :tabn<CR>

" }}}
