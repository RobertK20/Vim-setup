set encoding=utf-8
set number
set splitright
set incsearch
set showmatch
set hlsearch
set ignorecase
set smartcase
set mouse=a

"Set to your Python and Ruby paths
let g:python_host_prog='C:/ProgramData/Python27/python.exe'
let g:python3_host_prog='C:/ProgramData/Python39/python.exe'
let g:ruby_host_prog='~/UserPrograms/ruby30/bin/ruby.exe'


"
"Plugins
"
call plug#begin('~/AppData/Local/nvim/plugged/')

Plug 'PProvost/vim-ps1'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'danilo-augusto/vim-afterglow'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'lervag/vimtex'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'dense-analysis/ale'
Plug 'zchee/deoplete-jedi'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'sbdchd/neoformat'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'liuchengxu/vista.vim'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'majutsushi/tagbar'
Plug 'ryanoasis/vim-devicons'

call plug#end()


"
"VimTeX
"
if executable('latex')
	function! SetServerName() abort
		nvim_server_file = $TEMP .'/curnimserver.txt'
		let cmd = printf('echo %s > %s', v:servername, nvim_server_file)
		call system(cmd)
	endfunction

	augroup vimtex_common
		autocmd!
		autocmd FileType tex nmap <buffer> <F9> <plug>(vimtex-compile)
		autocmd FileType tex call SetServerName()
	augroup END

	let g:vimtex_compiler_latexmk = {
		\ 'build_dir' : 'build',
        	\ }

  	let g:vimtex_toc_config = {
        	\ 'name' : 'TOC',
        	\ 'layers' : ['content', 'todo', 'include'],
        	\ 'resize' : 1,
		\ 'split_width' : 30,
        	\ 'todo_sorted' : 0,
        	\ 'show_help' : 1,
        	\ 'show_numbers' : 1,
        	\ 'mode' : 2,
        	\ }

	let g:vimtex_syntax_enabled=1
	let g:vimtex_compiler_progname = 'nvr'
  	let g:tex_flavor='latex'
 	let g:vimtex_quickfix_open_on_warning = 0
  	let g:vimtex_quickfix_mode = 2

	let g:vimtex_view_general_viewer = 'SumatraPDF'
    	let g:vimtex_view_general_options_latexmk = '-reuse-instance'
    	let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
 
endif


"
"NERDTree setting
"
let g:nerdtree_open=0
map <leader>n :call NERDTreeToggle()<CR>
function NERDTreeToggle()
	NERDTreeTabsToggle
    	if g:nerdtree_open == 1
		let g:nerdtree_open = 0
    	else
        	let g:nerdtree_open = 1
        	wincmd p
    	endif
endfunction

function! StartUp()
    if 0 == argc()
        NERDTree
	endif
endfunction

autocmd VimEnter * call StartUp()


"
"Shortcuts
"
nmap <Tab> >>
nmap <S-tab> <<
imap <S-Tab> <Esc><<i
vmap <Tab> >gv
vmap <S-Tab> <gv
map <leader>t :TagbarToggle<CR>
map <C-e> <Plug>(ale_next_wrap)
map <C-r> <Plug>(ale_previous_wrap)

"
"Terminal toggle
"
function TermToggle()
	sp
	term
	resize 15
endfunction
map <leader>z :call TermToggle()<CR>


"
"Visual and autocomplete
"
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='afterglow'
call deoplete#custom#var('omni', 'input_patterns', {'tex': g:vimtex#re#deoplete})

syntax on
set background=dark
colorscheme afterglow













	
