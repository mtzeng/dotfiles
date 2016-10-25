call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" {{{
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'easymotion/vim-easymotion'

Plug 'mhinz/vim-signify'
"Plug 'airblade/vim-gitgutter'
"Plug 'tpope/vim-fugitive'
"Plug 'gregsexton/gitv'

Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'scrooloose/nerdcommenter'
"Plug 'scrooloose/syntastic'
"Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }
"Plug 'Valloric/ListToggle'
"Plug 'bling/vim-airline'
Plug 'bootleq/vim-tabline'
"Plug 'bootleq/ShowMarks'
Plug 'dimasg/vim-mark'
"Plug 'sjl/gundo.vim'
"Plug 'vimwiki/vimwiki'
"Plug 'tomasr/molokai'
"Plug 'chriskempson/vim-tomorrow-theme'
"Plug 'chriskempson/base16-vim/'
"Plug 'w0ng/vim-hybrid'
Plug 'sk1418/last256'

Plug 'a.vim'
Plug 'DirDiff.vim'
Plug 'grep.vim'
Plug 'vcscommand.vim'
Plug 'ZoomWin'
Plug 'LargeFile'
" }}}

" Add plugins to &runtimepath
call plug#end()


language C
syntax on

set encoding=utf-8
set langmenu=none
"reload menu with UTF-8 encoding
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

if has("win32")
  set viminfo+=n$USERPROFILE
endif

if has("gui_running")
  set guioptions=gmrLt
else
  set t_Co=256
  set mouse=
endif

colorscheme last256

set lazyredraw
set ttyfast

" disable sounds
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set nobackup cursorline cursorcolumn ruler showcmd nowrap hlsearch incsearch
set nu cindent ts=4 sw=4
set completeopt=menu
set updatetime=1200
set diffopt+=vertical
set laststatus=2
" eliminating delays on ESC in vim and zsh
set timeout timeoutlen=1000 ttimeoutlen=0
set backspace=indent,eol,start

set listchars=tab:»·,trail:·
"set list
"hi SpecialKey ctermbg=red guibg=red

autocmd BufNewFile,BufRead *.aidl   setf java		" android interface definition language
autocmd FileType java set et nu
autocmd FileType c,cpp,asm,make set nu
autocmd BufEnter \c*.c,\c*.cc,\c*.cpp,\c*.h,\c*.java,\c*.aidl,\c*.s call s:set_project() " '\c' to igonre case
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" set leader to ,
let mapleader=","
let g:mapleader=","

map <leader>tp :if &paste == '' <bar> set paste <bar> echo 'paste on' <bar> else <bar> set nopaste <bar> echo 'paste off' <bar> endif<cr>
map <leader>te :if &et == '' <bar> set et <bar> echo 'expandtab on' <bar> else <bar> set noet <bar> echo 'expandtab off' <bar> endif<cr>
map <leader>th :if &hls == '' <bar> set hls <bar> echo 'hlsearch on' <bar> else <bar> set nohls <bar> echo 'hlsearch off' <bar> endif<cr>
map <leader>tl :if &list == '' <bar> set list <bar> echo 'list mode on' <bar> else <bar> set nolist <bar> echo 'list mode off' <bar> endif<cr>
map <leader>tm :if &mouse == '' <bar> set mouse=a <bar> echo 'mouse on' <bar> else <bar> set mouse= <bar> echo 'mouse off' <bar> endif<cr>
map <leader>tn :if &nu == '' <bar> set nu <bar> echo 'line number on' <bar> else <bar> set nonu <bar> echo 'line number off' <bar> endif<cr>
map <leader>ti :if &ic == '' <bar> set ic <bar> echo 'ignore case' <bar> else <bar> set noic <bar> echo 'case sensitive' <bar> endif<cr>

nnoremap <silent> <f4>   :close<cr>
nnoremap <silent> <f5>   :NERDTreeToggle %:p:h<cr>
"nnoremap <silent> <f6>   :let &hlsearch = !&hlsearch<cr>
nnoremap <silent> <f7>   :lprevious<cr>
nnoremap <silent> <f8>   :lnext<cr>
nnoremap <silent> <f9>   :QFix<cr>
nnoremap <silent> <f12>  :TagbarToggle<cr>
nnoremap <silent> <c-]>  :tjump<cr>
nnoremap <silent> <c-k>  :execute (line('.')-1>line('w0')) ? (line('.')+line('w0'))/2 : line('.')-1<cr>
nnoremap <silent> <c-j>  :execute (line('.')+1<line('w$')) ? (line('.')+line('w$'))/2 : line('.')+1<cr>
nnoremap <silent> <s-w>  :let tmp_reg=@/<cr>/\<<cr>:let @/=tmp_reg<cr>	" search for next word
nnoremap <silent> <s-b>  :let tmp_reg=@/<cr>?\<<cr>:let @/=tmp_reg<cr>	" search for previous word
" Bash like keys for the command line
cnoremap <c-a> <home>
cnoremap <c-e> <end>
" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

"nnoremap <silent> <leader>gv :Gitv<cr>
"nnoremap <silent> <leader>gV :Gitv!<cr>

" grep
nnoremap <leader>vv :execute "Grep \\<" . expand("<cword>") . "\\> " . expand("%:p:h") . "/*"<cr>
nnoremap <leader>va :execute "GrepAdd \\<" . expand("<cword>") . "\\> " . expand("%:p:h") . "/*"<cr>

let g:netrw_browse_split = 3
let g:tagbar_sort = 0
hi TagbarHighlight guifg=black guibg=red ctermfg=black ctermbg=red
let VCSCommandDisableMappings = 1
augroup VCSCommand
autocmd User VCSVimDiffFinish wincmd p
augroup VCSCommand
let NERDTreeQuitOnOpen = 1
let NERDTreeShowBookmarks = 1
let g:DirDiffExcludes = ".svn,.git,.*.swp,*.o,*.o.cmd,tags,cscope.*,*.rej,*.orig"
let g:DirDiffIgnore = "Id:,Revision:,Date:"

let g:syntastic_auto_loc_list = 0           " location-list not be opened or closed automatically
let g:signify_vcs_list = [ 'svn', 'git' ]

"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_key_list_select_completion = ['<c-n>', '<down>']
"let g:ycm_key_list_previous_completion = ['<c-p>', '<up>']
let g:EasyMotion_leader_key = '<Leader>'    " Default: '<Leader><Leader>'
let g:EasyMotion_mapping_n = '_n'           " avoid conflict with mark.vim

" Unite {{{
" TODO unite scriptnames
" TODO secondary default action
" TODO bookmark should convert slashes for different OSes
" TODO use vim-tabline for tabs
" TODO switch between ,ff and ,F buffer

" Launcher mappings {{{
nnoremap [unite] <Nop>
xnoremap [unite] <Nop>
nmap <Leader>f [unite]
xmap <Leader>f [unite]
imap <Leader>f <C-\><C-N>[unite]

"nnoremap <silent> [unite]f :<C-U>Unite
"      \ -input=<C-R>=fnamemodify(unite#helper#get_buffer_directory(bufnr('%')), ':p:.')<CR>
"      \ -buffer-name=files file file/new<CR>
nnoremap <silent> [unite]f :<C-U>Unite file_list:<C-R>=current_project . "/cscope.files"<CR><CR>
nnoremap <silent> [unite]F :<C-U>Unite
	  \ -input=<C-R>=fnamemodify(unite#helper#get_buffer_directory(bufnr('%')), ':p:.')<CR>
	  \ -buffer-name=files file file/new file_rec<CR>
nnoremap <silent> <Leader>F :<C-U>Unite -buffer-name=file_rec file_rec<CR>

nnoremap <silent> [unite]r :<C-U>Unite -profile-name=mru file_mru<CR>
nnoremap <silent> [unite]d :<C-U>Unite -buffer-name=mru directory_mru<CR>
nnoremap <silent> [unite]/ :<C-U>Unite -buffer-name=search line<CR>
nnoremap <silent> [unite]p :<C-U>Unite -buffer-name=registers -unique register<CR>
xnoremap <silent> [unite]p "_d:<C-U>Unite -buffer-name=register -unique register<CR>
nnoremap <silent> [unite]b :<C-U>Unite -no-start-insert bookmark<CR>
nnoremap <silent> [unite]m :<C-U>Unite mark<CR>
nnoremap <silent> [unite]h :<C-U>Unite -update-time=600 help<CR>
nnoremap <silent> [unite]o :<C-U>Unite -no-start-insert outline<CR>
nnoremap <silent> [unite]g :<C-U>Unite tab:no-current<CR>
nnoremap <silent> [unite]j :<C-U>Unite jump<CR>
nnoremap <silent> [unite]c :<C-U>Unite change<CR>
nnoremap <silent> [unite]y :<C-U>Unite -unique history/yank<CR>
nnoremap <silent> [unite]R :<C-U>Unite -input=rails/ source<CR>
nnoremap <silent> [unite]M :<C-U>Unite rails/model<CR>
nnoremap <silent> [unite]V :<C-U>Unite rails/view<CR>
nnoremap <silent> [unite]C :<C-U>Unite rails/controller<CR>
" }}}

" Configuration variables {{{
"let g:unite_data_directory = expand(s:rtp . '/.unite/')
let g:unite_source_rec_find_args = ['-type', 'd', '-name', '.svn', '-prune', '-o', '-name', 'builds', '-prune', '-o', '-print']
let g:unite_source_rec_unit = 10000

let g:unite_quick_match_table = {
	  \   'a': 0,  'b': 1,  'c': 2,  'd': 3,  'e': 4,  'f': 5,  'g': 6,  'h': 7,  'i': 8,  'j': 9,
	  \   'k': 10, 'l': 11, 'm': 12, 'n': 13, 'o': 14, 'p': 15, 'q': 16, 'r': 17, 's': 18, 't': 19,
	  \   'u': 20, 'v': 21, 'w': 22, 'x': 23, 'y': 24, 'z': 25, ';': 26, '.': 27, '/': 28, 'A': 29, 'B': 30
	  \ }
let g:unite_ignore_source_files = [
	  \   'window.vim',
	  \   'window_gui.vim',
	  \   'output.vim',
	  \   'command.vim',
	  \   'function.vim',
	  \   'mapping.vim',
	  \   'grep.vim',
	  \   'vimgrep.vim',
	  \   'launcher.vim',
	  \   'menu.vim',
	  \   'process.vim',
	  \   'runtimepath.vim',
	  \ ]

let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_limit = 40
let g:unite_source_history_yank_save_clipboard = 1
let g:unite_source_session_path = expand('~/.vim/session/')

let g:neomru#file_mru_limit = 800
let g:neomru#time_format = "%m/%d %T "
let g:neomru#directory_mru_limit = 80
" }}}

" In unite buffer setting {{{
function! s:unite_settings()
  nmap <buffer> <C-J> <Plug>(unite_loop_cursor_down)
  nmap <buffer> <C-K> <Plug>(unite_loop_cursor_up)
  imap <buffer> <C-J> <Plug>(unite_insert_leave)<C-J>
  imap <buffer> <C-K> <Plug>(unite_insert_leave)<C-K>
  nmap <buffer> <F5> <Plug>(unite_redraw)
  imap <buffer> <F5> <Plug>(unite_redraw)
  nmap <buffer> <C-U> <Plug>(unite_append_end)<Plug>(unite_delete_backward_line)
  nmap <buffer> <Leader>q <Plug>(unite_exit)
  imap <buffer> <Leader>q <Plug>(unite_exit)
  nmap <buffer> <Leader>Q <Plug>(unite_all_exit)
  imap <buffer> <Leader>Q <C-\><C-N><Plug>(unite_all_exit)

  imap <buffer> ; <Plug>(unite_delete_backward_word)
  imap <buffer> <Leader>; <Plug>(unite_delete_backward_path)
  imap <buffer> <Leader>u <Plug>(unite_delete_backward_line)
  inoremap <buffer><expr> <Leader>/ unite#do_action('narrow')

  nmap <buffer> <Leader>: <Plug>(unite_narrowing_input_history)
  imap <buffer> <Leader>e <Plug>(unite_quick_match_default_action)

  nmap <buffer> <Leader><C-K> <Plug>(unite_print_candidate)
  nmap <buffer> <Leader><C-A> <Plug>(unite_print_message_log)

  let unite = unite#get_current_unite()
  if index(unite.source_names, 'file') > -1 ||
		\   index(unite.source_names, 'file_mru') > -1 ||
		\   index(unite.source_names, 'file_rec') > -1
	nnoremap <silent><buffer><expr> <Leader><CR> unite#do_action('open')
	inoremap <silent><buffer><expr> <Leader><CR> unite#do_action('open')
  endif
  if index(unite.source_names, 'file_rec') > -1
	imap <buffer> <Leader>. <Plug>(unite_redraw)
  else
	inoremap <buffer> <Leader>.  **/
  endif
endfunction
autocmd FileType unite call s:unite_settings()
" }}}

" Sources customization {{{
call unite#custom#default_action('file, source/bookmark/jump_list', 'tabswitch')
call unite#custom#default_action('source/help/common', 'tabopen')

" File related
call unite#custom#source(
	  \ 'file, file_rec, buffer, file_mru',
	  \ 'matchers',
	  \ ['matcher_hide_hidden_files', 'matcher_fuzzy'])
"  let s:i.unite_sorter = has('ruby') ? 'sorter_selecta' : 'sorter_rank'
"  call unite#custom#source(
"        \ 'file, file_rec, buffer, file_mru',
"        \ 'sorters',
"        \ ['sorter_word', s:i.unite_sorter])
call unite#custom#source(
	  \ 'file, file_rec, buffer',
	  \ 'converters',
	  \ ['converter_relative_abbr'])

call unite#custom#source('tab, outline', 'matchers', ['matcher_fuzzy'])
call unite#custom_source('help', 'sorters', 'sorter_word')
" }}}

" Profile customization {{{
call unite#custom#profile('default', 'context', {
	  \   'start_insert': 1,
	  \   'hide_source_names': 1
	  \ })

" Preserve built-in substitute_patterns
"  for s:i.unite_pattern in values(unite#get_profile('files', 'substitute_patterns'))
"    call unite#custom#profile('source/files', 'substitute_patterns', {
"          \   'pattern': s:i.unite_pattern.pattern,
"          \   'subst': s:i.unite_pattern.subst,
"          \   'priority': s:i.unite_pattern.priority
"          \ })
"  endfor

" Ref: thinca - http://d.hatena.ne.jp/thinca/20101027/1288190498
call unite#custom#profile('files', 'substitute_patterns', {
	  \   'pattern': '^@',
	  \   'subst': '\=expand("#:p:h")."/*"',
	  \   'priority': 1
	  \ })
" }}}

command! -bar -nargs=? EditBookmarks call s:edit_bookmarks()
function! s:edit_bookmarks() "{{{
  if !has_key(g:, 'unite_source_bookmark_directory')
	call unite#get_candidates(['bookmark'])
  endif
  execute printf("Unite -immediately -auto-resize file:%s", get(g:, 'unite_source_bookmark_directory', ''))
endfunction "}}}
" }}}

" Project: {{{
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
let use_cscope = 1 " 1: cscope; 0: gtags
if (g:use_cscope == 1)
  let cs_prg = "cscope"
  let cs_db = "cscope.out"
else
  let cs_prg = "gtags-cscope"
  let cs_db = "GTAGS"
endif

function! s:set_project() " {{{
  "let path = substitute(expand("%:p:h"), "\\", "/", "g")
  let path = resolve(expand("%:p:h"))

  " skip the same project
  if (g:current_project != '' && path =~ g:current_project)
    return
  endif

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

  if (db_found == 1)
    let g:current_project = path

    execute "set tags=./tags,./TAGS,tags,TAGS," . g:current_project . "/tags"
    execute "cs kill -1"

    execute "set cscopeprg=" . g:cs_prg
	execute "set cscopequickfix=s-,c-,d-,i-,t-,e-,a-"
    execute "set cscopetag"
    execute "set cscopetagorder=0"
    execute "cs add " . g:current_project . '/' . g:cs_db
  endif
endfunction " }}}
" }}}

" Tab: {{{
if has("unix") && !has("mac")
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
elseif has("mac")
  execute "set <M-1>=¡"
  execute "set <M-2>=™"
  execute "set <M-3>=£"
  execute "set <M-4>=¢"
  execute "set <M-5>=∞"
  execute "set <M-6>=§"
  execute "set <M-7>=¶"
  execute "set <M-8>=•"
  execute "set <M-9>=ª"
  execute "set <M-0>=º"
  execute "set <M-,>=≤"
  execute "set <M-.>=≥"
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
noremap ts :tab split<cr>

" vim-airline
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_buffers = 0
"let g:airline#extensions#tabline#tab_nr_type = 1
"let g:airline#extensions#tabline#show_tab_nr = 1
"let g:airline#extensions#tabline#show_tab_type = 0
"let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline#extensions#tabline#tab_min_count = 2
"let g:airline#extensions#tabline#show_close_button = 0

" vim-tabline
hi TabLineFill        term=NONE cterm=NONE ctermfg=85 ctermbg=234
hi TabLineMore        term=NONE cterm=NONE ctermfg=255 ctermbg=238
hi TabLine            term=NONE cterm=NONE ctermfg=255 ctermbg=238
hi TabLineNr          term=NONE cterm=NONE ctermfg=255 ctermbg=238
hi TabLineSplitNr     term=NONE cterm=NONE ctermfg=255 ctermbg=238
hi TabLineSel         term=NONE cterm=NONE ctermfg=17 ctermbg=190
hi TabLineNrSel       term=NONE cterm=NONE ctermfg=17 ctermbg=190
hi TabLineSplitNrSel  term=NONE cterm=NONE ctermfg=17 ctermbg=190
" }}}

" Quickfix: {{{
" toggles the quickfix window.
command -bang -nargs=0 QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("t:QFixToggle")
    lclose
    unlet! t:QFixToggle
  else
    if !empty(getloclist(0))
      execute "lopen 12"
      let t:QFixToggle=1
    else
      echo 'No list'
    endif
  endif
endfunction

autocmd FileType qf wincmd J  " move quickfix window to the bottom awlays
" }}}

" modeline {{{
" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
