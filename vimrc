let mapleader = "\<space>"

set nocompatible
filetype off
syntax on

if has('win32')
    colorscheme darkblue
else
    colorscheme elflord
endif

" VUNDLE PLUGIN MANAGER
if has('win32')
    " 1. vim should be 64-bit (link in ycm site)
    " 2. python should be 64-bit
    " set %HOME% env var equal to %USERPROFILE%
    set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
    set rtp^=$HOME/vimfiles/bundle/ctrlp.vim/
    let vpath = $HOME . '/vimfiles/bundle'
    call vundle#begin(vpath)
else
    set rtp+=~/.vim/bundle/Vundle.vim/
    set rtp^=~/.vim/bundle/ctrlp.vim/
    call vundle#begin()
endif

Plugin 'VundleVim/Vundle.vim' " plugin manager
Plugin 'scrooloose/nerdtree' " file explorer
Plugin 'flazz/vim-colorschemes' " vim themes
Plugin 'Valloric/YouCompleteMe' " clang, gocode, racer, omnisharp
Plugin 'rust-lang/rust.vim' " rustfmt, syntax
Plugin 'fatih/vim-go' " gofmt, syntax
Plugin 'majutsushi/tagbar' " tagbar
Plugin 'ctrlpvim/ctrlp.vim' " fuzzy finder
Plugin 'tpope/vim-surround' " quoting/parenthesizing
Plugin 'pangloss/vim-javascript' " javascript
Plugin 'mattn/emmet-vim' " html/css

if has('win32')
    " Plugin 'qualiabyte/vim-colorstepper'
    Plugin 'PProvost/vim-ps1' " powershell syntax
    Plugin 'vim-scripts/findstr.vim' " findstr windows
    Plugin 'vim-airline/vim-airline' " status bar
    Plugin 'vim-airline/vim-airline-themes' " color themes for airline
    Plugin 'bling/vim-bufferline' " integrates nicely with vim-airline
else
    " Plugin 'qualiabyte/vim-colorstepper'
    " ** airline is a bit problematic with ctrlp **
    " Plugin 'vim-airline/vim-airline'
    " Plugin 'vim-airline/vim-airline-themes'
    Plugin 'vim-scripts/grep.vim' " grep integration
    Plugin 'itchyny/lightline.vim' " simpler airline
    Plugin 'bling/vim-bufferline' " integrates nicely with vim-airline
endif
call vundle#end()

if has('win32')
    " https://blog.golang.org/go-fonts; or
    " git clone https://go.googlesource.com/image
    " copy .\image\font\gofont\ttfs\*
    set guifont=Go\ Mono:h9

    " window size (gvim only)
    if has("gui_running")
        set lines=70
        set columns=250
    endif
endif

" to ignore plugin indent changes, instead use filetype plugin on
filetype plugin indent on

set viminfo='100,f1 " save marks to up to 100 files, save global marks as well (f1); to disable, f0

" folding options
set foldmethod=indent
set foldnestmax=20
set nofoldenable
set foldlevel=0

" generic
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set autoindent
set smartindent
set number
set encoding=utf-8
" set fileencodings=utf-8
" set fencs=ucs-bom,utf-16le,utf-8,default,latin1
set noswapfile
set shortmess+=I
set backspace=indent,eol,start " make backspace work like most other apps
set nocompatible
set ignorecase
set splitright
set splitbelow
set ruler
set relativenumber
set history=200 " keep 200 lines of command line history
set showcmd " display incomplete commands
set laststatus=2 " always show vim-airline status

if has('win32')
    set display=truncate " show @@@ in the last line if it is truncated
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
    " clean ui
    set guioptions-=T
    set guioptions-=L
    set guioptions-=r
    set guioptions-=m
endif

" setttings for ycm
if has('win32')
    let extra_conf_path = $HOME . '\_ycm_extra_conf.py'
    let g:ycm_global_ycm_extra_conf = extra_conf_path
    let g:ycm_auto_start_csharp_server = 1
    let g:ycm_csharp_server_port = 0
else
    " temporary enable/disable ycm: active = disable, commented = enable
    " let g:loaded_youcompleteme = 1
    let g:ycm_global_ycm_extra_conf = $HOME . '/.ycm_extra_conf.py'
    " let g:ycm_server_use_vim_stdout = 0
    " let g:ycm_server_keep_logfiles = 1
endif

let g:ycm_disable_for_files_larger_than_kb = 0
let g:ycm_autoclose_preview_window_after_completion = 1

" settings for ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_show_hidden = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0

if has('win32')
    let g:ctrlp_cache_dir = $HOME . '\.cache\ctrlp'
    let g:ctrlp_custom_ignore = {
                \ 'dir':  '\v[\/]\.(git|hg|svn)$',
                \ 'file': '\v\.(exe|so|dll)$',
                \ 'link': 'some_bad_symbolic_links',
                \ }
else
    let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
    let g:ctrlp_custom_ignore = {
                \ 'dir':  '\v[\/]\.(git|hg|svn)$',
                \ 'file': '\v\.(exe|so|dll)$',
                \ 'link': 'some_bad_symbolic_links',
                \ }
endif

" settings for emmet-vim, see augroup + autocmd
let g:user_emmet_install_global = 0

" settings for airline/lightline
if has('win32')
    let g:airline_theme = 'light'
else
    " let g:airline_theme = 'light'
    let g:lightline = {
                \ 'colorscheme': 'PaperColor',
                \ }
endif

" settings for vim-go
" 1 :PluginInstall
" 2 :GoInstallBinaries (gotags, vim-go)
" 3 Install 'ctags'
if executable('go')
    if has('win32')
        " nothing, nil
    else
        " 4 go get -u github.com/jstemmer/gotags
        let g:tagbar_type_go = {
                    \ 'ctagstype' : 'go',
                    \ 'kinds'     : [
                    \ 'p:package',
                    \ 'i:imports:1',
                    \ 'c:constants',
                    \ 'v:variables',
                    \ 't:types',
                    \ 'n:interfaces',
                    \ 'w:fields',
                    \ 'e:embedded',
                    \ 'm:methods',
                    \ 'r:constructor',
                    \ 'f:functions'
                    \ ],
                    \ 'sro' : '.',
                    \ 'kind2scope' : {
                    \ 't' : 'ctype',
                    \ 'n' : 'ntype'
                    \ },
                    \ 'scope2kind' : {
                    \ 'ctype' : 't',
                    \ 'ntype' : 'n'
                    \ },
                    \ 'ctagsbin'  : 'gotags',
                    \ 'ctagsargs' : '-sort -silent'
                    \ }
    endif

    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_types = 1
    let g:go_highlight_build_constraints = 1
endif

" rust-related options
" read $HOME/.rustup/settings.toml and extract the default-toolchain setting
" need to install both stable and nightly for this to work
if executable('rustup')
    let rust_settings_toml = readfile($HOME . '/.rustup/settings.toml')[1] " read 2nd line
    let rust_current_toolchain = split(rust_settings_toml, '"')[1] " split with double quotes, get [1]
    let g:ycm_rust_src_path = $HOME . '/.rustup/toolchains/' . rust_current_toolchain . '/lib/rustlib/src/rust/src'
    let g:rustfmt_autosave = 1
endif

" nerdtree
map <c-n> :NERDTreeToggle<cr>
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeQuitOnOpen = 1

" normal mode maps
if has('win32')
    " source: ftp://xmlsoft.org/libxml2/win32/64bit/
    " part of libxml2, needs xml2/bin, iconv/bin, and zlib/bin
    nnoremap <leader>px :%!xmllint --format %<cr>

    " copy/paste (clipboard) mappings
    " paste only works in visual and insert mode so there will be no conflict for ctrl-v in normal mode
    " just remember to go insert mode when pasting from system clipboard
    vmap <c-c> "+yi
    vmap <c-x> "+c
    vmap <c-v> c<esc>"+p
    imap <c-v> <c-r><c-o>+
else
    nnoremap <F8> :TagbarToggle<cr>
endif

nnoremap <leader>wq <c-w>q
nnoremap <leader>ws <c-w>s
nnoremap <leader>wv <c-w>v
nnoremap <leader>wo <c-w>o
nnoremap <leader><left> <c-w><left>
nnoremap <leader>h <c-w><left>
nnoremap <leader><right> <c-w><right>
nnoremap <leader>l <c-w><right>
nnoremap <leader><up> <c-w><up>
nnoremap <leader>k <c-w><up>
nnoremap <leader><down> <c-w><down>
nnoremap <leader>j <c-w><down>
nnoremap <leader>s :w<cr>
nnoremap <leader>e :e.<cr>
nnoremap <leader>pj :%!python -m json.tool<cr>
nnoremap <leader>dt :windo diffthis<cr>
nnoremap <leader>do :windo diffoff!<cr>
nnoremap <leader>cw :cw<cr>
nnoremap <leader>hl :set hlsearch! hlsearch?<cr>

" prepare search: move cursor to //, then get word under cursor using ctrl-r + ctrl-w
nnoremap <leader>vg :vimgrep //j *<left><left><left><left><c-r><c-w><end><bar>:cw<cr>
" search for the word under cursor in the current dir (recursively): csm = cursor search multiple
" command CSM execute ":vimgrep /" . expand("<cword>") . "/j ** <bar> :cw"
" nnoremap <leader>ms :CSM<cr>

" prepare replace: move cursor to //, then get word under cursor using ctrl-r + ctrl-w
nnoremap <leader>rt :%s/<c-r><c-w>//gc<left><left><left>
" nnoremap <leader>fs :sp<cr>:CtrlPMixed<cr>
" nnoremap <leader>fv :vsp<cr>:CtrlPMixed<cr>

nnoremap <leader>x :qall<cr>
nnoremap <leader>xx :qall!<cr>
nnoremap <leader>bs :new<cr>:setlocal buftype=nofile nobuflisted<cr>
nnoremap <leader>bv :vnew<cr>:setlocal buftype=nofile nobuflisted<cr>
nnoremap <leader>bd :bd<cr>
nnoremap <leader>1 :b1<cr>
nnoremap <leader>2 :b2<cr>
nnoremap <leader>3 :b3<cr>
nnoremap <leader>4 :b4<cr>
nnoremap <leader>5 :b5<cr>
nnoremap <leader>6 :b6<cr>
nnoremap <leader>7 :b7<cr>
nnoremap <leader>8 :b8<cr>
nnoremap <leader>9 :b9<cr>
nnoremap <leader>rn :exec &nu==&rnu? "set nornu" : "set rnu"<cr>
nnoremap <leader>cd :lcd %:h<cr>

" makes ctrl-t not work in golang so just use ctrl-t
" nnoremap <leader>] :YcmCompleter GoTo<cr>

if has('win32')
    " search using vimgrep (!recursive)
    nnoremap <leader>vg :vimgrep /<c-r><c-w>/j * <bar> :cw<cr>
    " search using vimgrep (recursive)
    nnoremap <leader>ms :vimgrep /<c-r><c-w>/j ** <bar> :cw<cr>

    " search for word under cursor (ignore case, exclude non-printables)
    nnoremap <leader>fs :Findstring /ip <c-r><c-w> *<cr>
    nnoremap <leader>rs :Rfindstring /ip <c-r><c-w> *<cr>
    nnoremap <leader>fp :Findpattern /ip <c-r><c-w> *<cr>
    nnoremap <leader>rp :Rfindpattern /ip <c-r><c-w> *<cr>
    " prepare for recursive search (ignore case, exclude non-printables)
    nnoremap <leader>pp :Rfindpattern /ip <c-r><c-w> *
    " needs confirmation, 'update' allows us to switch to next buffer (all recursive)
    " #1 = search/replace current word (c/c++)
    nnoremap <leader>f1 :Rfindpattern /ip <c-r><c-w> *.h *.c *.cpp *.conf<cr>
    nnoremap <leader>p1 :Rfindpattern /ip <c-r><c-w> *.h *.c *.cpp *.conf
    nnoremap <leader>r1 :arg **/*.c <bar> argadd **/*.cpp <bar> argadd **/*.h <bar> argdo %s/<c-r><c-w>/?/gc <bar> update
    " #2 = search/replace current word (golang)
    nnoremap <leader>f2 :Rfindpattern /ip <c-r><c-w> *.go *.md *.html *.js *.conf<cr>
    nnoremap <leader>p2 :Rfindpattern /ip <c-r><c-w> *.go *.md *.html *.js *.conf
    nnoremap <leader>r2 :arg **/*.go <bar> argdo %s/<c-r><c-w>/?/gc <bar> update
    " #3 = search/replace current word (rust)
    nnoremap <leader>f3 :Rfindpattern /ip <c-r><c-w> *.rs *.md *.conf<cr>
    nnoremap <leader>p3 :Rfindpattern /ip <c-r><c-w> *.rs *.md *.conf
    nnoremap <leader>r3 :arg **/*.rs <bar> argdo %s/<c-r><c-w>/?/gc <bar> update
    " #0 = prepare search/replace (generic)
    nnoremap <leader>f0 :Rfindpattern /ip <c-r><c-w> *
    nnoremap <leader>r0 :arg **/* <bar> argdo %s/<c-r><c-w>/?/gc <bar> update
else
    " prepare pattern search via grep recursive (c/c++)
    nnoremap <leader>g1 :Rgrep -P -i --binary-files=without-match <c-r><c-w> *.h *.c *.cpp *.conf
    " prepare pattern search via grep recursive (golang)
    nnoremap <leader>g2 :Rgrep -P -i --binary-files=without-match <c-r><c-w> *.go *.md *.html *.js *.conf
    " prepare pattern search via grep recursive (rust)
    nnoremap <leader>g3 :Rgrep -P -i --binary-files=without-match <c-r><c-w> *.rs *.md *.conf
    " prepare pattern search via grep recursive (generic)
    nnoremap <leader>g0 :Rgrep -P -i --binary-files=without-match <c-r><c-w> *
endif

" hightlight the 81st and 161st column
augroup highlight81and161
    autocmd!
    autocmd BufEnter * highlight OverLength ctermbg=magenta ctermfg=white guibg=magenta guifg=white
    autocmd BufEnter * match OverLength /\%81v/
    autocmd BufEnter * 2match OverLength /\%161v/
augroup END

augroup enablerustfiletype
    autocmd!
    autocmd BufRead,BufNewFile *.rs set filetype=rust
augroup END

" from 'defaults.vim'
augroup jmplastcurpos
    " put these in an autocmd group, so that you can revert them with:
    " ":augroup vimStartup | au! | augroup END"
    autocmd!
    " when editing a file, always jump to the last known cursor position;
    " don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim)
    autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" |
        \ endif
augroup END

" limit emmet-vim to html, css only
augroup emmetfiletypeenable
    autocmd!
    autocmd FileType html,css EmmetInstall
augroup END

augroup rememberfolds
    autocmd!
    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent! loadview
augroup END

" ColorStepper Keys
" nmap <F6> <Plug>ColorstepPrev
" nmap <F7> <Plug>ColorstepNext
" nmap <S-F7> <Plug>ColorstepReload
