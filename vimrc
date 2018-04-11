"""""""""""""""""
"Global settings"
"""""""""""""""""
set guioptions=aegilt
"set guifont=Monospace\ 14
set guifont=Menlo\ Regular:h14

filetype on
filetype plugin indent on
syntax on 		
color desert 			"set themes
set ic 				"incase sensitive search
set laststatus=2		"for plugin airline
set t_Co=256 			"set 256colors
set mouse=a 			"mouse support
set winaltkeys=no 		"let alt can be binding
set encoding=utf-8 	
set showmatch 			"highlight match brackets
set autoread  			"autoreload
set number 			"show line number
set hlsearch 			"highlight search result
set incsearch 			"dynamic search
set ru 				"show current cursor status in statusline
set ai 				"auto indent
set smartindent
set nocompatible 		"disable vi-compatibility mode
set autochdir 			"auto change folder path
set backspace=indent,eol,start

let mapleader=',' 		"set leader key

" disable middle mouse
noremap <MiddleMouse> <Nop>
noremap <2-MiddleMouse> <Nop>
noremap <3-MiddleMouse> <Nop>
noremap <4-MiddleMouse> <Nop>
inoremap <MiddleMouse> <Nop>
inoremap <2-MiddleMouse> <Nop>
inoremap <3-MiddleMouse> <Nop>
inoremap <4-MiddleMouse> <Nop>

map <leader>ro :set wrap <CR>
map <leader>rf :set nowrap<CR>

" turn off serach highlighting
map <leader>/ :nohl<CR>
map <F7> :SrcExplToggle<CR>
map <F8> :NERDTreeToggle<CR>
map <F9> :TlistToggle<CR>
" save & quit
map <leader>s :w<CR>
map <leader>S <leader>s
map <leader>w :wqa!<CR> 
map <leader>W <leader>w
map <leader>x :call ForceQuit()<CR>
map <leader>X <leader>x

" switch between windows
map <M-Left> <C-w>h
map <M-Right> <C-w>l
map <M-Up> <C-w>k
map <M-Down> <C-w>j
map <F3> <C-w>w
" move this line up/down
map <S-Up> :m .-2<CR>
map <S-Down> :m .+1<CR>

" copy & paste from clipboard
map <leader>c "+y
map <leader>v "+p

"""""""""""
"Functions"
"""""""""""
function ForceQuit()
	let a:ans = input("Quit without save? (y/N)...")
	if a:ans == 'y' || a:ans == 'Y'
		exec ":qa!"
	else
		echo 'Cancel'
	endif
endfunction

function SetFold()
	set foldnestmax=2
	set foldmethod=indent
endfunction

function SwapIdent()
	set tabstop=4
	set shiftwidth=4
	set expandtab
endfunction

function MaxLenghtTip()
	if exists('+colorcolumn')
		set colorcolumn=80
	else
		au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
	endif

endfunction

function RemoveTailSpace()
	:%s/\s\+$//e
endfunction

function PythonSettings()
	call SetFold()
	call SwapIdent()
	call MaxLenghtTip()
endfunction

function JavascriptSettings()
	call SwapIdent()
endfunction

"""""""""
"Plugins"
"""""""""
autocmd BufWritePre *.py call RemoveTailSpace()
autocmd! BufRead,BufNewFile,BufEnter *.py call PythonSettings()
autocmd BufWritePre *.js call RemoveTailSpace()
autocmd! BufRead,BufNewFile,BufEnter *.js call JavascriptSettings()
autocmd BufWritePre *.c call RemoveTailSpace()
autocmd! BufRead,BufNewFile,BufEnter *.c call SwapIdent()

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" Install plugins by bundle
Bundle 'gmarik/vundle'

 "nerdtree & nerdtree tabs
" 	file browser and extsion
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
let g:NERDTreeWinPos="right"
let g:nerdtree_tabs_open_on_console_startup=0

" nerdcommenter
" 	quick toggle comment
Bundle 'scrooloose/nerdcommenter'

" taglist
" 	list all functions and variables (depand on ctags)
Bundle 'taglist.vim'
let Tlist_Auto_Open=0
let Tlist_Show_One_File=1
let Tlist_Close_On_Select=0
let Tlist_File_Fold_Auto_Close=0
autocmd BufWritePost *.c :TlistUpdate
autocmd BufWritePost *.h :TlistUpdate

" cSyntaxAfter
" 	highlight brackets for c-like language
Bundle 'cSyntaxAfter'
autocmd! BufRead,BufNewFile,BufEnter *.{c,cpp,h,javascript} call CSyntaxAfter()

" vim-easytags
" 	Hightlight codes (depand on ctags)
"Bundle 'xolox/vim-misc'
"Bundle 'xolox/vim-easytags'
"set tags=./.easytags;,~/.vimtags
"let g:easytags_dynamic_files=2
"let g:easytags_include_members=1
"let g:easytags_async=1
" Disable auto update, create .easytags myself
"let g:easytags_auto_update = 0 
"highlight cMember term=italic ctermfg=31 gui=italic guifg=#80a0ff
"let g:easytags_autorecurse=1 
"autocmd! BufRead *.{c,cpp,h,javascript} :UpdateTags
"autocmd! BufRead *.{c,cpp,h,javascript} :HighlightTags
"noremap <F4> :UpdateTags<CR>:HighlightTags<CR>
"noremap <F4> :HighlightTags<CR>
"noremap <F3> <C-]>
"noremap <F2> <C-t>

" minibufexpl
" 	control vim buffers like tab
Bundle 'fholgado/minibufexpl.vim'
let g:miniBufExplSetUT=0
let g:miniBufExplorerMoreThanOne=1
map <leader>1 :MBEbp<CR>
map <leader>2 :MBEbn<CR>
map <leader>q :MBEbw<CR>

" autoclose
" 	auto complete a pair of brackets
Bundle 'Townk/vim-autoclose'

" idutils_finder
" 	find tags by idutils
"Bundle 'verybada/idutils_finder'
"let g:IDF_Automkid=1

" Ycm
" 	replace supertab, clangcomplete, neocomplete
" 	But conflict with vim-easytags
Bundle 'Valloric/YouCompleteMe'
" let select key not using arrow key
"let g:ycm_server_use_vim_stdout = 1
"let g:ycm_server_log_level = 'debug'
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_key_list_previous_completion = ['<S-TAB>']
let g:ycm_enable_diagnostic_signs = 0

" Visiable bookmark
"Bundle 'huxiao/vim-bookmark'

" XML
"Bundle 'othree/xml.vim'

" YankRing
Bundle 'vim-scripts/YankRing.vim'

" Has a bug!! will cause autocomplete become extremely slow
" Python-mode
"Bundle 'klen/python-mode'
 "Default python version, enable if necesary
let g:pymode_python = 'python'
 "Auto folding
let g:pymode_folding = 1
 "code check
let g:pymode_lint = 0
 " disable code check in every save
let g:pymode_lint_on_write = 0
 "disable rope
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0
 " disable auto complete because I have YCM
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
 "disable max column tip line
let g:pymode_options_colorcolumn = 1

" vim-indent-object
" Using shortcut to select a block which without {}
Bundle 'michaeljsmith/vim-indent-object'

" vim-airline
Bundle 'bling/vim-airline'

" vim-javascript-syntax
"Bundle 'jelera/vim-javascript-syntax'

" vim-python-pep8-indent
"	 Let vim follow pep8 indent
Bundle 'hynek/vim-python-pep8-indent'

" vim-markdown
" 	Treat *.md as a markdown file
" open md support
"Bundle 'tpope/vim-markdown'
"autocmd! BufNewFile,BufReadPost *.md set filetype=markdown

" Syntastic
" 	synctax checker
"Bundle 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
