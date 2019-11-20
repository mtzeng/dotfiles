" vim: set foldmethod=marker foldlevel=0:
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================

language C
syntax on

set encoding=utf-8
set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

if has('win32') || has('win64')
  set runtimepath=~/.vim,$VIMRUNTIME
  set viminfo+=n$USERPROFILE
endif

if has("gui_running")
  set guioptions=gmrLt
else
  set t_Co=256
  set mouse=
endif

set lazyredraw
set ttyfast

" disable sounds
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set nobackup cursorline ruler showcmd nowrap hlsearch incsearch
set nu cindent ts=4 sw=4
set completeopt=menu
set updatetime=1200
"set diffopt+=vertical
set laststatus=2
" eliminating delays on ESC in vim and zsh
set timeout timeoutlen=1000 ttimeoutlen=0
set backspace=indent,eol,start

set listchars=tab:»·,trail:·
"set list
"hi SpecialKey ctermbg=red guibg=red

" set buffer hidden when unloaded
set hidden

set colorcolumn=80


" }}}
" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================

silent! if plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" {{{
command! PFiles call fzf#run(fzf#wrap({'source': 'cat ' . current_project . '/cscope.files'}))
command! -bang -nargs=* BLines
  \ call fzf#vim#buffer_lines(<q-args>,
  \                           {'options': '--multi --bind alt-a:select-all,alt-d:deselect-all'},
  \                           <bang>0)
" }}}
Plug 'easymotion/vim-easymotion'

Plug 'mhinz/vim-signify'
" {{{
let g:signify_vcs_list = [ 'svn', 'git' ]
" }}}
Plug 'mhinz/vim-grepper'
" {{{
let g:grepper = {}            " initialize g:grepper with empty dictionary
runtime plugin/grepper.vim    " initialize g:grepper with default values
let g:grepper.highlight = 1
let g:grepper.quickfix = 0
let g:grepper.open = 0
let g:grepper.switch = 0
let g:grepper.jump = 1
let g:grepper.tools = ['rg', 'ag', 'grep']
let g:grepper.rg = {
    \ 'grepprg':    'rg --ignore-file ~/.ignore -H --no-heading --column --color never' . (has('win32') ? ' $* .' : ''),
    \ 'grepformat': '%f:%l:%c:%m',
    \ 'escape':     '\^$.*+?()[]{}|',
    \ }
let g:grepper.ag = {
    \ 'grepprg':    'ag --path-to-ignore ~/.ignore --nogroup --nocolor --column',
    \ 'grepformat': '%l:%m,%f:%l:%m',
    \ 'escape':     '\^$.*+?()[]{}|',
    \ }
command! -nargs=1 GrepperBuffer Grepper -buffer -noprompt -query <args>
" }}}
"Plug 'airblade/vim-gitgutter'
"Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
"Plug 'gregsexton/gitv'

Plug 'majutsushi/tagbar'
" {{{
let g:tagbar_sort = 0
let g:tagbar_type_vimwiki = {
\ 'ctagstype' : 'vimwiki',
\ 'kinds' : [ 'h:header' ],
\ 'sort' : 0
\ }
hi TagbarHighlight guifg=black guibg=red ctermfg=black ctermbg=red
" }}}
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" {{{
let NERDTreeQuitOnOpen = 1
let NERDTreeShowBookmarks = 1
" }}}
"Plug 'scrooloose/nerdcommenter'
"Plug 'scrooloose/syntastic'
" {{{
let g:syntastic_auto_loc_list = 0           " location-list not be opened or closed automatically
" }}}
"Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }
Plug 'Valloric/ListToggle'
" {{{
let g:lt_location_list_toggle_map = '<f9>'
let g:lt_quickfix_list_toggle_map = '<s-f9>'
let g:lt_height = 12
" }}}
"Plug 'bling/vim-airline'
Plug 'itchyny/lightline.vim'
" {{{
let g:lightline = {
\ 'active': {
\   'left': [ [ 'mode', 'paste', 'ignorecase' ],
\             [ 'readonly', 'modified', 'filename', 'tagbar' ] ]
\ },
\ 'component': {
\   'ignorecase': '%{&ignorecase?"IGNORECASE":""}',
\   'tagbar': '%{tagbar#currenttag("%s", "", "f")}',
\ }
\}
" }}}
Plug 'dimasg/vim-mark'
"Plug 'sjl/gundo.vim'
Plug 'vimwiki/vimwiki'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/DirDiff.vim', { 'on': 'DirDiff' }
" {{{
let g:DirDiffExcludes = ".svn,.git,.*.swp,*.o,*.o.cmd,tags,cscope.*,*.rej,*.orig"
let g:DirDiffIgnore = "Id:,Revision:,Date:"
" }}}

Plug 'vim-scripts/vcscommand.vim'
" {{{
let VCSCommandDisableMappings = 1
let VCSCommandDeleteOnHide = 1
augroup VCSCommand
autocmd User VCSBufferCreated silent! nmap <unique> <buffer> q :bwipeout<cr>
autocmd User VCSVimDiffFinish wincmd p
augroup VCSCommand

function! s:vcs_vertical_annotate()
	let orientation_changed = 0
	if !exists("g:VCSCommandSplit") || g:VCSCommandSplit == 'horizontal'
		let g:VCSCommandSplit='vertical'
		let orientation_changed = 1
	endif

	VCSAnnotate
	set scrollbind
	wincmd p
	set scrollbind
	wincmd p

	if orientation_changed != 0
		let g:VCSCommandSplit='horizontal'
	endif
endfunction
command! VCSVerticalAnnotate call s:vcs_vertical_annotate()
" }}}
"Plug 'ZoomWin'
Plug 'vim-scripts/LargeFile'

"Plug 'tomasr/molokai'
Plug 'sk1418/last256'
"Plug 'w0ng/vim-hybrid'
"Plug 'chriskempson/base16-vim/'
"Plug 'chriskempson/vim-tomorrow-theme'

call plug#end()
endif


" }}}
" ============================================================================
" COLOR SCHEME {{{
" ============================================================================
colorscheme last256

" }}}
" ============================================================================
" AUTOCMD {{{
" ============================================================================

autocmd BufNewFile,BufRead *.aidl   setf java		" android interface definition language
autocmd FileType java set et nu
autocmd FileType c,cpp,asm,make set nu
autocmd BufEnter \c*.c,\c*.cc,\c*.cpp,\c*.h,\c*.s call s:set_project() " '\c' to igonre case
" Remember the line I was on when I repone a file
" http://askubuntu.com/questions/202075/how-do-i-get-vim-to-remember-the-line-i-was-on-when-i-reopen-a-file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Status line not appear sometimes with lazyredraw enabled
" https://stackoverflow.com/questions/39595011/vim-status-line-wont-immediately-appear-unless-i-press-a-key
autocmd VimEnter * redraw


" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

" set leader to ','
let mapleader=','
let g:mapleader=','

map <leader>tp :if &paste == '' <bar> set paste <bar> echo 'paste on' <bar> else <bar> set nopaste <bar> echo 'paste off' <bar> endif<cr>
map <leader>te :if &et == '' <bar> set et <bar> echo 'expandtab on' <bar> else <bar> set noet <bar> echo 'expandtab off' <bar> endif<cr>
map <leader>th :if &hls == '' <bar> set hls <bar> echo 'hlsearch on' <bar> else <bar> set nohls <bar> echo 'hlsearch off' <bar> endif<cr>
map <leader>tl :if &list == '' <bar> set list <bar> echo 'list mode on' <bar> else <bar> set nolist <bar> echo 'list mode off' <bar> endif<cr>
map <leader>tm :if &mouse == '' <bar> set mouse=a <bar> echo 'mouse on' <bar> else <bar> set mouse= <bar> echo 'mouse off' <bar> endif<cr>
map <leader>tn :if &nu == '' <bar> set nu <bar> echo 'line number on' <bar> else <bar> set nonu <bar> echo 'line number off' <bar> endif<cr>
map <leader>ti :if &ic == '' <bar> set ic <bar> echo 'ignore case' <bar> else <bar> set noic <bar> echo 'case sensitive' <bar> endif<cr>
map <leader>td :if &diff == '' <bar> diffthis <bar> echo 'diff on' <bar> else <bar> diffoff <bar> echo 'diff off' <bar> endif<cr>

nnoremap <silent> <f4>   :close<cr>
nnoremap <silent> <f5>   :NERDTreeToggle %:p:h<cr>
"nnoremap <silent> <f6>   :let &hlsearch = !&hlsearch<cr>
nnoremap <silent> <f7>   :lprevious<cr>
nnoremap <silent> <s-f7> :cprevious<cr>
nnoremap <silent> <f8>   :lnext<cr>
nnoremap <silent> <s-f8> :cnext<cr>
nnoremap <silent> <f12>  :TagbarToggle<cr>
nnoremap <silent> <c-]>  :tjump<cr>
"nnoremap <silent> <c-k>  :execute (line('.')-1>line('w0')) ? (line('.')+line('w0'))/2 : line('.')-1<cr>
"nnoremap <silent> <c-j>  :execute (line('.')+1<line('w$')) ? (line('.')+line('w$'))/2 : line('.')+1<cr>
nnoremap <silent> <s-w>  :let tmp_reg=@/<cr>/\<<cr>:let @/=tmp_reg<cr>	" search for next word
nnoremap <silent> <s-b>  :let tmp_reg=@/<cr>?\<<cr>:let @/=tmp_reg<cr>	" search for previous word
"nnoremap <silent> <c-w>o :if &diff == '' <bar> only <bar> else <bar> wincmd p <bar> close <bar> endif<cr>
nnoremap <silent> <c-w>o :only <bar> if &diff != '' <bar> diffoff <bar> endif<cr>
" Bash like keys for the command line
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <m-b> <s-left>
cnoremap <m-f> <s-right>
" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv
nnoremap gb :ls<CR>:b<Space>

" fzf
nnoremap <silent> <leader>ff	:PFiles<CR>
nnoremap <silent> <leader>ft	:BTags<CR>
nnoremap <silent> <leader>fgt	:Tags<CR>
nnoremap <silent> <leader>f/	:BLines<CR>

" easymotion
nmap s <Plug>(easymotion-s2)
nmap t <Plug>(easymotion-t2)

nmap <leader>vd :VCSVimDiff<cr>
nmap <leader>va :VCSVerticalAnnotate<cr>
nmap <leader>vl :VCSLog <c-r>=matchstr(getline('.'), '^\s*\(\d\+\)')<cr><cr>

" Setup meta keys
" {{{
" Fix meta-keys that break out of Insert mode
" https://vim.fandom.com/wiki/Fix_meta-keys_that_break_out_of_Insert_mode
if has("unix")
  execute "set <M-1>=\e1"
  execute "set <M-2>=\e2"
  execute "set <M-3>=\e3"
  execute "set <M-4>=\e4"
  execute "set <M-5>=\e5"
  execute "set <M-6>=\e6"
  execute "set <M-7>=\e7"
  execute "set <M-8>=\e8"
  execute "set <M-9>=\e9"
  execute "set <M-0>=\e0"
  execute "set <M-,>=\e,"
  execute "set <M-.>=\e."
  execute "set <M-b>=\eb"
  execute "set <M-f>=\ef"
elseif has("win32")
  execute "set <M-1>=±"
  execute "set <M-2>=²"
  execute "set <M-3>=³"
  execute "set <M-4>=´"
  execute "set <M-5>=µ"
  execute "set <M-6>=¶"
  execute "set <M-7>=·"
  execute "set <M-8>=¸"
  execute "set <M-9>=¹"
  execute "set <M-0>=°"
  execute "set <M-,>=¬"
  execute "set <M-.>=®"
endif

" The alt (option) key on macs now behaves like the 'meta' key. This means we
" can now use <m-x> or similar as maps. This is buffer local, and it can easily
" be turned off when necessary (for instance, when we want to input special
" characters) with :set nomacmeta.
if has("gui_macvim")
  set macmeta
endif
" }}}
" }}}
" ============================================================================
" PROJECT SETTINGS {{{
" ============================================================================

nnoremap <C-]>  :lcs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-[>s :lcs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-[>g :lcs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-[>d :lcs find d <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-[>c :lcs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-[>t :lcs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-[>e :lcs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-[>f :lcs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-[>i :lcs find i <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-[>a :lcs find a <C-R>=expand("<cword>")<CR><CR>

let current_project = ''
let projects = []
" global or gtags not support caller search (only support reference search)
" So, you can search where a function be called (referenced), but don't know
" which function calls the searched function
let use_cscope = 1 " 1: cscope; 0: gtags

if (g:use_cscope == 1)
  let cs_prg = "cscope"
  let cs_db = "cscope.out"
else
  let cs_prg = "gtags-cscope"
  let cs_db = "GTAGS"
endif

execute "set cscopeprg=" . g:cs_prg
execute "set cscopequickfix=s-,c-,d-,i-,t-,e-"
execute "set cscopetag"
execute "set cscopetagorder=0"
execute "cs kill -1"

function! s:set_project() " {{{
  "let path = substitute(expand("%:p:h"), "\\", "/", "g")
  let path = resolve(expand("%:p:h"))

  " igonre existing project
  for project in g:projects
    if (path =~ project)
      return
    endif
  endfor

  " search a readable database
  let db_found = 0
  while (isdirectory(path))
    if filereadable(path . '/' . g:cs_db)
      let db_found = 1
      break
    elseif (path == '/')
      break
    endif
    let path = fnamemodify(path, ":h")
  endwhile

  if (db_found)
    let g:current_project = path
    call add(g:projects, g:current_project)

    execute "set tags+=" . g:current_project . "/tags"
    execute "cs add " . g:current_project . '/' . g:cs_db
  endif
endfunction " }}}


" }}}
" ============================================================================
" TAB SETTINGS {{{
" ============================================================================

noremap <M-1> 1gt
noremap <M-2> 2gt
noremap <M-3> 3gt
noremap <M-4> 4gt
noremap <M-5> 5gt
noremap <M-6> 6gt
noremap <M-7> 7gt
noremap <M-8> 8gt
noremap <M-9> 9gt
noremap <M-0> 10gt
noremap <M-,> :execute "silent! tabmove " . (tabpagenr()-2)<cr>
noremap <M-.> :execute "silent! tabmove " . (tabpagenr()+1)<cr>

noremap th :tabprevious<cr>
noremap tl :tabnext<cr>
noremap tn :tabnew<cr>
noremap tc :tabclose<cr>
noremap ts :tab split <bar> if &diff != '' <bar> diffoff <bar> endif<cr>

" }}}
" ============================================================================
