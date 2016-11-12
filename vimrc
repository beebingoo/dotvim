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
set hidden             " improve vim-ctrlspace overall experience
set nowrap             " use zl zh to Scrolling horizontally
" Or
" set backspace=2
"-- Set a directory to store the undo history
set undodir=~/.vimundo/
"-- Disable auto start a comment line
" autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
au FileType c,cpp setlocal comments-=:// comments+=f://
"-- Auto read files when sensory external changes
set autoread
au CursorHold,CursorHoldI * checktime
"-- Set file encoding
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
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

call plug#begin()

" Make sure you use single quotes

"-- Original GitHub repos
"-- Search Plug
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'mileszs/ack.vim'
Plug 'Shougo/unite.vim'

"-- Explorer
Plug 'sjl/gundo.vim'
Plug 'majutsushi/tagbar', { 'on':  'TagbarToggle' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" load nerdtree-git-plugin before vim-devicons loads
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'szw/vim-ctrlspace'
" Call-Tree Explorer
Plug 'hari-rangarajan/CCTree', { 'for': ['c', 'cpp'] }

"-- Dispaly
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
function! Installjshint(info)
  if a:info.status == 'installed' || a:info.force
    !npm install -g jshint
  endif
endfunction
Plug 'scrooloose/syntastic', { 'do': function('Installjshint') }
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-sensible'
" nathanaelkane/vim-indent-guides uses listchar as indent guide
" Plug 'nathanaelkane/vim-indent-guides'
" automatically adjusts 'shiftwidth' and 'expandtab'
Plug 'tpope/vim-sleuth'
" All tailing whitespace charecters to be highlighten
" An alternative way to highlight tailing whitespace
" highlight ExtraWhitespace ctermbg=darkgreen guibg=bg
" match ExtraWhitespace /\s\+$/
Plug 'ntpeters/vim-better-whitespace'
Plug 'ryanoasis/vim-devicons'

"-- Edit helper
Plug 'ludovicchabant/vim-gutentags'
Plug 'scrooloose/nerdcommenter'
Plug 'Rip-Rip/clang_complete'
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer
  endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'terryma/vim-multiple-cursors'
" automatic closing of quotes, parenthesis, brackets, etc.
Plug 'Raimondi/delimitMate'
" Appends, subsitutes or removes a comma or a semi-colon
Plug 'lfilho/cosco.vim'
" Aligning text
Plug 'godlygeek/tabular'
" A Git wrapper
Plug 'tpope/vim-fugitive'
" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" HTML css JS
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
function! BuildTern(info)
  if a:info.status == 'installed' || a:info.force
    !npm install
  endif
endfunction
Plug 'marijnh/tern_for_vim', { 'do': function('BuildTern'), 'for': 'jacascript' }

"--- color scheme
Plug 'sickill/vim-monokai'

"-- Vim-script repos
" Plug 'OmniCppComplete'
Plug 'surround.vim'
Plug 'tComment'

"-- FuzzyFinder dependent
" Plug 'L9'
" Plug 'FuzzyFinder'
" Plug 'Align'
Plug 'a.vim'
Plug 'DoxygenToolkit.vim'
" Plug 'SuperTab'
Plug 'gtags.vim'
Plug 'DrawIt'

"-- Slow-down vim plugin {{{
"--- Legacy powerline repo
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'taglist.vim'
call plug#end()
"}}}

filetype plugin indent on     " Required!

 " Brief help
 " :PluginList          - list configured bundles
 " :PluginInstall(!)    - install(update) bundles
 " :PluginSearch(!) foo - search(or refresh cache first) for foo
 " :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Plugin command are not allowed..

syntax enable
syntax on
" }}}

"--- Color scheme setting --- {{{
se t_Co=256
" let g:solarized_termcolors=256
set background=dark
" colorscheme monokai
" set colorcolumn=80
highlight OverLength ctermfg=yellow ctermbg=NONE guibg=#2c2d27
2match OverLength /\%81v.*/
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
	let g:clang_library_path = '/usr/lib/llvm-3.8/lib/'
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

"--- YouCompleteMe setting --- {{{
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_select_completion = ['<TAB>', '<c-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
"-- ultisnips trigger configuration
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"-- syntastic
let g:syntastic_always_populate_loc_list = 1
"-- SuperTab completion fall-back
" let g:SuperTabDefaultCompletionType = '<c-x><c-u><c-p>'
" }}}

"--- Plugin setting --- {{{
"-- CtrlP
let g:ctrlp_max_files=0
" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in
" version control. It also supports works with .svn.
let g:ctrlp_working_path_mode = 'rw'

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

"-- tagbar
let g:tagbar_autoclose = 1

"-- DoxygenToolkit
let g:DoxygenToolkit_authorName="beebingoo"

"-- indentLine
let g:indentLine_enabled = 0

"-- ctrl-space
let g:airline_exclude_preview = 1

"-- cosco
au FileType c,cpp,css,html,jacascript nnoremap <silent> <Leader>; :call cosco#commaOrSemiColon()<CR>
au FileType c,cpp,css,html,jacascript inoremap <silent> <Leader>; :call cosco#commaOrSemiColon()<CR>

"-- vim-javascript-syntax
au FileType javascript call JavaScriptFold()

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

au VimEnter * call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
au VimEnter * call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
au VimEnter * call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
au VimEnter * call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
au VimEnter * call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
au VimEnter * call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
au VimEnter * call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
au VimEnter * call NERDTreeHighlightFile('rb', 'Red', 'none', '#ffa500', '#151515')
au VimEnter * call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
au VimEnter * call NERDTreeHighlightFile('h', 'green', 'none', 'green', '#151515')
au VimEnter * call NERDTreeHighlightFile('Makefile', 'blue', 'none', '#3366FF', '#151515')

"-- nerdtree-git-plugin
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
" }}}

"--- Key binding --- {{{
"-- Insert time stamp
imap <silent> <C-D><C-D> <C-R>=strftime("%Y-%b-%e")<CR>
imap <silent> <C-T><C-T> <C-R>=strftime("%l:%M %p")<CR>

"-- Gtags key mapping
nmap <leader>d :Gtags <C-r><C-w><CR>
nmap <leader>c :Gtags -r <C-r><C-w><CR>
nmap <leader>t :Gtags -g <C-r><C-w><CR>

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
"-- F7 create a new tab
" nnoremap <silent> <F7> :tabnew<CR>

"-- F6 next tab
nnoremap <silent> <F6> :tabn<CR>
"
"-- F5 previous tab
nnoremap <silent> <F5> :tabp<CR>
"-- F5 delete all trailing whitespace
" nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

"-- F4 disable auto indent
nnoremap <F4> :setl noai nocin nosi inde=<CR>

"-- F3 temporary disable auto comment
nnoremap <silent> <f3> :setlocal comments-=:// comments+=f://<CR>

"-- F2 Toggle paste mode
set pastetoggle=<F2>

" }}}
