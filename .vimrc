"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc.vim', {
                        \'build' : {
                        \'windows' : 'tools\\update-dll-mingw',
                        \'cygwin' : 'make -f make_cygwin.mak',
                        \'mac' : 'make -f make_mac.mak',
                        \'linux' : 'make',
                        \'unix' : 'gmake',
                        \},
                        \}

NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'tpope/vim-fugitive'
" NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'rking/ag.vim'

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'ntpeters/vim-better-whitespace'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'tyru/caw.vim'
NeoBundle 'scrooloose/nerdtree'

NeoBundle 'kchmck/vim-coffee-script'
" NeoBundle 'marcus/rsense'
" NeoBundle 'supermomonga/neocomplete-rsense.vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'elixir-lang/vim-elixir'

NeoBundle 'ujihisa/unite-colorscheme'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck


inoremap <silent> fd <ESC>
nnoremap <silent> <C-L> :<C-U>noh<C-L><CR>
nnoremap <silent> <C-X><C-O> :<C-U>VimFilerBufferDir<CR>
nnoremap <silent> ]<Space> :<C-U>put =repeat(nr2char(10),v:count)<Bar>execute "'[-1"<CR>
nnoremap <silent> [<Space> :<C-u>put!=repeat(nr2char(10),v:count)<Bar>execute "']+1"<CR>
nnoremap <C-W><C-P> <C-W>o<C-W><C-V><C-W><C-W>
nnoremap <C-W><C-A> <C-W>o<C-W><C-V><C-W><C-W>:<C-U>A<CR>
cnoremap <C-G> <C-C>
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>

" set encoding=utf-8
" set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set ignorecase
set smartcase
set incsearch
set hlsearch
set number
set autoread

"colors
syntax enable
set background=dark
let g:solarized_termtrans=1
" let g:solarized_contrast="high"
" let g:solarized_visibility="high"
colorscheme hybrid

"statusline
set laststatus=2
set noshowmode

"comment
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

"unite
let g:unite_enable_start_insert=1
let g:unite_enable_ignore_case=1
let g:unite_enable_smart_case=1

nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
nnoremap <silent> <C-p> :<C-u>Unite file_rec/async:!<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
        let g:unite_source_grep_command='ag'
        let g:unite_source_grep_default_opts='--nogroup --nocolor'
        let g:unite_source_grep_recursive_opt=''
        let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --hidden -g ""'
endif

"vimfiler
let g:vimfiler_as_default_explorer=1
let g:vimfiler_safe_mode_by_default=0

"indent-guides
let g:indent_guides_enable_on_vim_startup=1
" let g:indent_guides_auto_colors=0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=234
let g:indent_guides_color_change_percent=30
let g:indent_guides_guide_size=1

"lightline
let g:lightline={
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ }
      \ }

"ctrlp
let g:ctrlp_custom_ignore='\v(www/lib|node_modules|platforms)'


"coffee-script
au BufRead,BufNewFile,BufReadPre *.coffee    set filetype=coffee
autocmd FileType coffee    setlocal sw=2 sts=2 ts=2 et

"ruby
autocmd FileType ruby setlocal sw=2 sts=2 ts=2 et

"rsense
let g:rsenseHome="/usr/local/"
