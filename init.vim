scriptencoding utf-8
"{ Plugin installation
"{{ Vim-plug related settings.
" The root directory to install all plugins.
let g:plug_home='C:/Users/RobertKerr/AppData/Local/nvim/plugged/'

let g:is_win = has('win32') || has('win64')
let g:is_linux = has('unix') && !has('macunix')
let g:is_mac = has('macunix')

let g:python3_host_prog = 'C:\ProgramData\Python39\python.exe' 

call plug#begin('C:/Users/RobertKerr/AppData/Local/nvim/plugged/')

"Aesthetics
Plug 'morhetz/gruvbox'
Plug 'PProvost/vim-ps1'
Plug 'lifepillar/vim-gruvbox8'
Plug 'ajmwagar/vim-deus'
Plug 'lifepillar/vim-solarized8'
Plug 'joshdick/onedark.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'sainnhe/edge'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'


"file manager 
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'

"VimTex
Plug 'lervag/vimtex'

"snipets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"Linting
Plug 'dense-analysis/ale'

Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'zchee/deoplete-jedi'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'sbdchd/neoformat'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'majutsushi/tagbar'
Plug 'ryanoasis/vim-devicons'

call plug#end()

set number
set splitbelow
if (g:is_win) 
	set shell=powershell.exe
endif

"{{ LaTeX editting
"This code has been adapted from: https://github.com/jdhao/nvim-config/blob/master/core/plugins.vim
""""""""""""""""""""""""""""vimtex settings"""""""""""""""""""""""""""""
if ( g:is_win || g:is_mac ) && executable('latex')
  function! SetServerName() abort
    if has('win32')
      let nvim_server_file = $TEMP . '/curnvimserver.txt'
    else
      let nvim_server_file = '/tmp/curnvimserver.txt'
    endif
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

  " TOC settings
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

  " Viewer settings for different platforms
  if g:is_win
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options_latexmk = '-reuse-instance'
    let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
  endif

  if g:is_mac
    " let g:vimtex_view_method = "skim"
    let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
    let g:vimtex_view_general_options = '-r @line @pdf @tex'

    augroup vimtex_mac
      autocmd!
      autocmd User VimtexEventCompileSuccess call UpdateSkim()
    augroup END

    " The following code is adapted from https://gist.github.com/skulumani/7ea00478c63193a832a6d3f2e661a536.
    function! UpdateSkim() abort
      let l:out = b:vimtex.out()
      let l:src_file_path = expand('%:p')
      let l:cmd = [g:vimtex_view_general_viewer, '-r']

      if !empty(system('pgrep Skim'))
        call extend(l:cmd, ['-g'])
      endif

      call jobstart(l:cmd + [line('.'), l:out, l:src_file_path])
    endfunction
  endif
endif

"Autocomplete settings
call deoplete#custom#var('omni', 'input_patterns', {
			\ 'tex': g:vimtex#re#deoplete
			\})

" file browser
" The following code is adapted from https://gist.github.com/miguelgrinberg/527bb5a400791f89b3c4da4bd61222e4
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let NERDTreeMinimalUI = 1
let g:nerdtree_open = 0
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
    end
endfunction

autocmd VimEnter * call StartUp()

" indent/unindent with tab/shift-tab
" The following code is adapted from https://gist.github.com/miguelgrinberg/527bb5a400791f89b3c4da4bd61222e4

nmap <Tab> >>
nmap <S-tab> <<
imap <S-Tab> <Esc><<i
vmap <Tab> >gv
vmap <S-Tab> <gv

" mouse
set mouse=a
let g:is_mouse_enabled = 1
noremap <silent> <Leader>m :call ToggleMouse()<CR>
function ToggleMouse()
    if g:is_mouse_enabled == 1
        echo "Mouse OFF"
        set mouse=
        let g:is_mouse_enabled = 0
    else
        echo "Mouse ON"
        set mouse=a
        let g:is_mouse_enabled = 1
    endif
endfunction

" terminal
function TermToggle ()
	sp
	term
	resize 20
endfunction
map <leader>z :call TermToggle()<CR>

"ale
map <C-e> <Plug>(ale_next_wrap)
map <C-r> <Plug>(ale_previous_wrap)

" tags
map <leader>t :TagbarToggle<CR>

"Airline
let g:airline#extensions#tabline#enabled = 1
"Startup preamble 
syntax on
colorscheme gruvbox-material 


