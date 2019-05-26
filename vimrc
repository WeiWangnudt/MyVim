" General settings {{{
" Folding {{{
set foldenable
set foldmethod=marker "OtherChoice:'syntax' 'manual' 'indent' 'expr' 'diff' 
" set foldclose=all
" vim: fdm=marker fdl=0 fdls=0 "the original settings of this vimrc
" }}}
" Not for vi {{{
set nocp
" }}}
" Line number {{{
set nu
" }}}
" Auto change to the current directory {{{
set acd
" }}}
" Auto complete of vim command-line {{{
set wmnu
set wildmode=longest,list,full
" }}}
" search {{{
set showmatch									" Highlight the Matching Bracket "
set matchtime=2									" Time of Showing Matching "
set ignorecase									" Igore case when searching "
set hlsearch									" Highlight Searching Things // hls "
" Unhighlight Searching Pattern
map nh <ESC>:nohl<CR>
set incsearch									" Search As You Are Typing "
set smartcase									" Smart Case Matching "
" }}}
" Show position of cursor at status line {{{
set ruler
" }}}
" Syntex highlighting {{{
syntax enable
syntax on
" }}}
" Autochdir {{{
au BufEnter * silent! lcd %:p:h
" }}}
" Allow backspace in insert mode {{{
set backspace=2
" }}}
" No beep and screenflashing {{{
set vb t_vb=
au GuiEnter * set t_vb=
" set vb
" }}}
" Shorter spaces {{{
set shiftwidth=2 tabstop=2
" }}}
" Auto indent {{{
if has('autocmd')
  filetype plugin indent on
endif
" }}}
" Copy indent {{{
set autoindent
" }}}
" Smart indent {{{
set smartindent
" }}}
" Smart table {{{
set smarttab
" }}}
" Use space for tab {{{
set expandtab
" }}}
" Set wrap, list disables line break {{{
set wrap lbr tw=0 wm=0 nolist
" }}}
" Remove menu/tool bar {{{
set go=ae
" }}}
" Share clipboard {{{
set clipboard=unnamed
" }}}
" }}}
" Encodings {{{
" Encoding for file {{{
set fenc=utf-8
" }}}
" Encoding for file's content {{{
"	If you want gvim under windws prompt
"	callback of shell command correctly
"	you need the following settings:
"	set enc=chinese
set enc=utf-8
scriptencoding utf-8
" }}}
" Encoding for term {{{
set termencoding=utf-8
" }}}
" Supported encoding {{{
set fencs=usc-bom,
      \utf-8,
      \chinese,
      \cp936,
      \gb18030,
      \big5,
      \euc-jp,
      \euc-kr,
      \latin1
" }}}
" Supported filefomart {{{
" auto detect mac,unix,dos
set ffs=mac,unix,dos
" }}}
" Vim message encoding {{{
language messages zh_CN.utf-8
" }}}
" }}}
" User functions {{{
" Toggle Verbose mode {{{
function! ToggleVerbose()
  if !&verbose
    set verbosefile=~/desktop/vimtex.log
    set verbose=15
  else
    set verbose=0
    set verbosefile=
  endif
endfunction
" }}}
" TeX live preiview {{{
fu! TexLivePreview()
  if filewritable( bufname( '%' ) )
    silent update %
  endif
endfu
au CursorHoldI,CursorHold *.tex call TexLivePreview()
" }}}
" }}}
" User variables {{{
let $USRVIMD =$HOME.'\vimfiles\myvim\'
let $USRPLUGD=$USRVIMD.'plugged\'
let $USRTEMPD=$USRVIMD.'vimtemp\'
let $LASTWKDR=$USRVIMD.'sessions\'
" }}}
" vim-Plug Plugins {{{
call plug#begin( $USRPLUGD )
" for latex
Plug 'lervag/vimtex'
" for powerline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" for soloarlized
Plug 'altercation/vim-colors-solarized'
" for snip
"Plug 'Sirver/ultisnips'
call plug#end()
" }}}
" vundle Plugins {{{
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/vimfiles/Vundle.vim-master
call vundle#begin('~/vimfiles/myvim/plugged')
" for windows manager like IDE
Plugin 'winmanager'
" for bufferExploer, needed by winmanager
Plugin 'vim-scripts/bufexplorer.zip',{'name':'bufexplorer'}
" for dir_tree
Plugin 'scrooloose/nerdtree'
" for taglist
Plugin 'taglist.vim', {'name':'taglist'}
" for closetag 
Plugin 'docunext/closetag.vim',{'name':'closetag'}
" for grep
Plugin 'yegappan/grep'
" for auto-pairs
Plugin 'jiangmiao/auto-pairs'
" for neocomplcache auto complete
Plugin 'neocomplcache'
" for SnipMate
Plugin 'SnipMate'                   "no settings below
"for c template
Plugin 'vim-scripts/c.vim',{'name':'cvim'}            "no settings below
" for bash template
Plugin 'bash-support.vim',{'name':'bash-support'}
"for DoxygenToolKit
Plugin 'vim-scripts/DoxygenToolkit.vim',{'name':'doxygentoolkit'}
"for Chinese input VimIM
Plugin 'vim-scripts/VimIM'
call vundle#end()            " required
filetype plugin indent on    " required
" }}}
" Plugin configuration {{{
" Vimtex {{{
if isdirectory( $USRPLUGD . 'vimtex' )
  let g:tex_flavor = "latex"
  let g:vimtex_quickfix_open_on_warning = 0
  let g:vimtex_quickfix_mode = 2
  let g:vimtex_view_general_viewer='sumatrapdf'
  autocmd Filetype tex setl updatetime=1
  let g:livepreview_cursorhold_recompile = 0
  let g:vimtex_compiler_latexrun_engines = {
        \ '-' : 'pdflatex'
        \}
  let g:vimtex_view_general_options_latexmk = '-reuse-instance'
  let g:vimtex_view_general_options
        \ = '-reuse-instance -forward-search @tex @line @pdf'
        \ . ' -inverse-search "gvim --servername ' . v:servername
        \ . ' --remote-send \"^<C-\^>^<C-n^>'
        \ . ':drop \%f^<CR^>:\%l^<CR^>:normal\! zzzv^<CR^>'
        \ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
        \ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
        \ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'
endif
" }}}
" Airline configuration {{{
if isdirectory( $USRPLUGD . 'vim-airline' )
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#whitespace#enabled = 1
  "let g:airline_theme='powerlineish'
  "let g:Powerline_symbols= 'fancy'
  "
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  " unicode symbols
  let g:airline_symbols.crypt = ''
  let g:airline_symbols.linenr = '?'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.paste = '?'
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.spell = 'SPELL'
  let g:airline_symbols.notexists = '?'
  let g:airline_symbols.whitespace = 'Ξ'
  " the font
  set guifont=DejaVu_Sans_Mono_for_Powerline:h16:cANSI:qDRAFT
endif
" }}}
" Solarized {{{
if isdirectory( $USRPLUGD . 'vim-colors-solarized' )
  let g:solarized_termcolors=256
  let g:solarized_termtrans=1
  set t_Co=256
  syntax enable
  if has('gui_running')
    set bg=light
  else
    set   bg=dark
  endif
  colo solarized
endif
" }}}
" Ultisnips {{{
if isdirectory( $USRPLUGD . 'ultisnips' )
  " Add ultisnips plugin dir to path
  set rtp -=$USRPLUGD.'ultisnips'
  " Add snippets dir to rtp
  if isdirectory( $USRVIMD )
    set rtp +=$USRVIMD
  endif
  " Set snippet search dir
  if isdirectory( $USRVIMD )
    let g:UltiSnipsSnippetsDir = $USRVIMD. 'UltiSnips'
    "Disable build-in i_CTRL-X_CTRL-K
    inoremap <c-x><c-k> <c-x><c-k>
  endif
endif
" }}}
" NERDTree {{{
let g:NERDTree_title='NERDTree'
let g:NERDTreeMapToggleZoom='a'
let g:NERDTreeMapToggleHidden='h'
map <Leader>nt :NERDTreeToggle<CR>
noremap <F3> <ESC>:NERDTreeToggle<CR>
" }}}
" winmanager {{{
let g:winManagerWindowLayout='FileExplorer|BufExplorer|TagList'
let g:persistentBehaviour=0           " Exit Vim When Only one left "
let g:winManagerWidth=10
let g:defaultExplorer=1
nmap <silent> <c-w><c-f> <ESC>:FirstExplorerWindow<cr>
nmap <silent> <c-w><c-b> <ESC>:BottomExplorerWindow<cr>
noremap <F4> :WMToggle<cr>
" }}}
" BufExplorer {{{
let g:bufExplorerSortBy="name"
let g:bufExplorerFindActive=1
" }}}
" taglist {{{
let TagList_title="TagList"					" TagList Window Name"
let Tlist_File_Fold_Auto_Close=1				" Hide function tags in unactive files
let Tlist_Show_One_File=1						" Show tags of one files
let Tlist_OnlyWindow=1
let Tlist_Use_Right_Window=1					" Tags on the Right"
let Tlist_Sort_Type='name'
let Tlist_Exit_OnlyWindow=1						" Exit vim if only one window exist
let Tlist_Show_Menu=1
let Tlist_Max_Submenu_Items=10
let Tlist_Max_Tag_length=20
let Tlist_Use_SingleClick=1						" Turn around on singleclick
let Tlist_Auto_Open=0
let Tlist_Auto_Update=1
let Tlist_Close_On_Select=0
let Tlist_GainFocus_On_ToggleOpen=1				" Gain the Focus on toggle openning
let Tlist_Process_File_Always=1					" Process File Always
let Tlist_WinWidth=18
let Tlist_Use_Horiz_Window=0
let Tlist_Enable_Fold_Column=0
let Tlist_Display_Prototype=0
let Tlist_Hightlight_Tag_On_BufEnter=1
let Tlist_Compact_Format=1
let tlist_diff_settings = 'diff;f:file'
let tlist_git_settings = 'diff;f:file'
let tlist_gitcommit_settings = 'gitcommit;f:file'
let tlist_privoxy_settings = 'privoxy;s:sections'
set iskeyword+=:,-,_
"" Open/Close TagList "
nmap <silent> tl <ESC>:TlistToggle<CR>
" }}}
" closetags {{{
let g:closetag_html_style=1
"au filetype html,xml,xsl,wiki,css,md,MD  source $VIMFILES/closetag/plugin/closetag.vim
" }}}
" grep {{{
set grepprg=grep\ -nH\ $*
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated' " Grep_Skip_Dirs "
" }}}
" auto-pairs {{{
let g:AutoPairsMapSpace=0
let g:AutoPairsFlyMode=1
let g:AutoPairsMapCR=0
let g:AutoPairsCenterLine=1
autocmd FileType tex let g:AutoPairs={'(':')','[':']','{':'}','"':'"',"'":"'"}
" }}}
" neocomplcache {{{
let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_auto_select = 1 
let g:NeoComplCache_Enable_Smart_Case=1
let g:neocomplcache_enable_camel_case_completion=1
let g:NeoComplCache_EnableInfo=1
let g:neocomplcache_enable_underbar_completion=1
let g:neocomplcache_min_syntax_length=2
let g:neocomplcache_enable_quick_match=1
let g:neocomplcache_max_list=20
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

let g:neocomplcache_auto_completion_length=1
let g:neocomplcache_enable_ignore_case=1
let g:NeoComplCache_EnableSkipCompletion=1
let g:NeoComplCache_SkipInputTime='0.5'
let g:NeoComplCache_SnippetsDir='~/.vim/vundle-plugin/SnipMate/snippets'
" }}}
" c.vim {{{
" }}}
" bash support {{{
" }}}
" DoxygenToolKit {{{
let g:DoxygenToolkit_authorName="Asins - asinsimple AT gmail DOT com"
let g:DoxygenToolkit_briefTag_funcName="yes"
map <leader>da :DoxAuthor<CR>
map <leader>df :Dox<CR>
map <leader>db :DoxBlock<CR>
map <leader>dc a /*  */<LEFT><LEFT><LEFT>
" }}}
" ctags settings {{{
map <F9> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ .<cr>
let g:ctags_path='`which ctags`'				" If ctags is not in your PATH "
let g:ctags_statusline=1			  			" Display Function Name in the Status Line "
let g:ctags_title=1					  			" Function Name Displayed in the Title Bar "
let generate_tags=1					  			" Automatically Generate Tags When Started"
let g:ctags_regenerate=1			  			" Regenerate Tags Each Time Buffer is Written "
set tags=
set tags+=./tags
set tags+=../tags
set tags+=./include/tags
set tags+=../include/tags
set tags+=/usr/include/tags
"}}}

" }}}
" User keymaps {{{
" copy to clipboard
vnoremap ;x "*y
" past from clipboard
vnoremap ;p "*p
" show math short key
nnoremap ;m :VimtexImapsList<cr>
" reload vimtex
nnoremap ;r :VimtexReload<cr>
" clean call of vimtex
nnoremap ;n :VimtexClean<cr>
" execute call of vimtex
nnoremap ;c :VimtexCompile<cr>
" preview
nnoremap ;v :VimtexView<cr>
" toggle of errors
nnoremap ;e :VimtexErrors<cr>
" toggle table of topic
nnoremap ;t :VimtexTocToggle<cr>
" next window
nnoremap nw <c-w><c-w>
" }}}
" Auto cmd {{{
"Automatical source vimrc on write 
au! BufWritePost $MYVIMRC source $MYVIMRC
"Auto change markdown file to tex fileformat
au! BufEnter *.md set ft=tex
" Go to last file(s) if invoked without arguments.
set ssop-=options
set ssop-=terminal
set ssop-=help
set ssop+=winpos
set ssop+=resize
autocmd VimLeave * nested if (!isdirectory($LASTWKDR)) |
      \ call mkdir($LASTWKDR) |
      \ endif |
      \ execute "mksession! " . $LASTWKDR . "Session.vim"

autocmd VimEnter * nested if argc() == 0 && filereadable($LASTWKDR . "Session.vim") |
      \ execute "source " . $LASTWKDR. "Session.vim"
" }}}
