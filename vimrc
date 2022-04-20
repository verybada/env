"""""""""""""""""
"Global settings"
"""""""""""""""""
set guioptions=aegilt
"set guifont=Monospace\ 14
"set guifont=Menlo\ Regular:h14

filetype on
filetype plugin indent on
syntax on 		
color desert 			"set themes
set ic 				"incase sensitive search
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
set tabstop=4
set shiftwidth=4
set expandtab

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

" save & quit
map <leader>s :w<CR>
map <leader>S <leader>s
map <leader>w :wqa!<CR> 
map <leader>W <leader>w
map <leader>x :call ForceQuit()<CR>
map <leader>X <leader>x
map <leader>q :bw<CR>

" copy & paste from clipboard
map <leader>c "+y
map <leader>v "+p

"""""""""""
"Functions"
"""""""""""
function ForceQuit()
	let ans = input("Quit without save? (y/N)...")
	if ans == 'y' || ans == 'Y'
		exec ":qa!"
	else
		echo 'Cancel'
	endif
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
	set foldnestmax=2
	set foldmethod=indent
	call SwapIdent()
	call MaxLenghtTip()
endfunction

function GoSettings()
	set foldnestmax=2
	set foldmethod=syntax
	call SwapIdent()
	call MaxLenghtTip()
endfunction

"""""""""
"Plugins"
"""""""""
autocmd BufWritePre *.py call RemoveTailSpace()
autocmd BufWritePre *.go call RemoveTailSpace()
autocmd! BufRead,BufNewFile,BufEnter *.py call PythonSettings()
autocmd! BufRead,BufNewFile,BufEnter *.go call GoSettings()

filetype off " Vundle required               
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" Install plugins by bundle
Plugin 'VundleVim/Vundle.vim'

"""""""""""""""""
" General plugins
"
 "nerdtree
" 	file browser
Plugin 'scrooloose/nerdtree'
let g:NERDTreeWinPos="right"
map <F8> :NERDTreeToggle<CR>

" nerdcommenter
" 	quick toggle comment
Plugin 'scrooloose/nerdcommenter'

" vim-airline
" 	tiny vim status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
set laststatus=2		"for plugin airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'

" autoclose
" 	auto complete a pair of brackets
Plugin 'jiangmiao/auto-pairs'

" Ycm
Plugin 'ycm-core/YouCompleteMe'
" let select key not using arrow key
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_key_list_previous_completion = ['<S-TAB>']
map gd :YcmCompleter GoTo<CR>
map gD :YcmCompleter GoToReferences<CR>

"""""""""""""""""
" Python plugins
"
" vim-indent-object
" 	Using shortcut to select a block which without {}
Plugin 'michaeljsmith/vim-indent-object'

" vim-python-pep8-indent
"	 Let vim follow pep8 indent
Plugin 'hynek/vim-python-pep8-indent'

" python-syntx
"	 Syntax hightlight
Plugin 'vim-python/python-syntax'
let g:python_highlight_builtins = 1
let g:python_highlight_exceptions = 1
let g:python_highlight_func_calls = 1

"""""""""""""""""
" Go plugins
"
" vim-go
Plugin 'fatih/vim-go'
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
" let g:go_fold_enable = ['block', 'package_comment', 'comment']
let g:go_fold_enable = ['package_comment', 'comment']


""""""""""""
Plugin 'preservim/tagbar'
map <F9> :TagbarToggle<CR>

call vundle#end() 
filetype plugin indent on 
