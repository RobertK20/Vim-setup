scriptencoding utf-8
"{ Plugin installation
"{{ Vim-plug related settings.
" The root directory to install all plugins.
let g:plug_home=expand(stdpath('data') . '/plugged')

let g:is_win = has('win32') || has('win64')
let g:is_linux = has('unix') && !has('macunix')
let g:is_mac = has('macunix')

call plug#begin('~/AppData/Local/nvim/plugged/')

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
Plug 'scrooloose/nerdtree'
Plug 'lervag/vimtex'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'zchee/deoplete-jedi'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'sbdchd/neoformat'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

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
"}}
call plug#end()

  call deoplete#custom#var('omni', 'input_patterns', {
          \ 'tex': g:vimtex#re#deoplete
          \})

syntax on
colorscheme gruvbox-material 


