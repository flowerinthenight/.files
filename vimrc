let mapleader = "\<space>"
let s:uname = system("uname -s")

" --- PLUGIN MANAGER ---
set nocompatible
filetype off
syntax on

if has('win32')
    " 1. vim should be 64-bit (link in ycm site)
    " 2. python should be 64-bit
    " set %HOME% env var equal to %USERPROFILE%
    set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
    " set rtp^=$HOME/vimfiles/bundle/ctrlp.vim/
    let vpath = $HOME . '/vimfiles/bundle'
    call vundle#begin(vpath) " call vundle#end
else
    set rtp+=~/.vim/bundle/Vundle.vim/
    " set rtp^=~/.vim/bundle/ctrlp.vim/

    " Ref: https://aonemd.github.io/blog/finding-things-in-vim
    if s:uname == "Darwin\n"
        set rtp+=/usr/local/opt/fzf/
    else
        " using Homebrew for Linux, https://docs.brew.sh/Homebrew-on-Linux
        set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf/
    endif
    call vundle#begin() " call vundle#end
endif

Plugin 'VundleVim/Vundle.vim'               " plugin manager
Plugin 'scrooloose/nerdtree'                " file explorer
Plugin 'flazz/vim-colorschemes'             " vim themes
" Plugin 'Valloric/YouCompleteMe'             " clang, racer, omnisharp
Plugin 'Shougo/neocomplete.vim'             " for golang (+ vim-go)
Plugin 'fatih/vim-go'                       " gofmt, syntax
Plugin 'rust-lang/rust.vim'                 " rustfmt, syntax
Plugin 'majutsushi/tagbar'                  " tagbar
" Plugin 'ctrlpvim/ctrlp.vim'                 " fuzzy finder
Plugin 'junegunn/fzf.vim'                   " fzf fuzzy finder (find, ag, rg)
Plugin 'wellle/targets.vim'                 " additional target objects
Plugin 'pangloss/vim-javascript'            " javascript
Plugin 'mattn/emmet-vim'                    " html/css
Plugin 'godlygeek/tabular'                  " should be before markdown
Plugin 'plasticboy/vim-markdown'            " markdown
Plugin 'simnalamburt/vim-mundo'             " undo history visualizer
Plugin 'mtth/scratch.vim'                   " scratch buffer
if has('gui_macvim')
    Plugin 'luochen1990/rainbow'            " parenthesis (and others) color
endif
Plugin 'terryma/vim-smooth-scroll'          " smooth scrolling
Plugin 'stamblerre/gocode', {'rtp': 'vim/'} " go autocompletion daemon
Plugin 'gcmt/wildfire.vim'                  " extra objects selection

if has('win32')
    " Plugin 'qualiabyte/vim-colorstepper'
    Plugin 'PProvost/vim-ps1'                   " powershell syntax
    Plugin 'vim-scripts/findstr.vim'            " findstr windows
    Plugin 'vim-airline/vim-airline'            " status bar
    Plugin 'vim-airline/vim-airline-themes'     " color themes for airline
    Plugin 'bling/vim-bufferline'               " integrates nicely with vim-airline
elseif has('__macunix__')
    Plugin 'vim-airline/vim-airline'            " status bar
    Plugin 'vim-airline/vim-airline-themes'     " color themes for airline
    Plugin 'bling/vim-bufferline'               " integrates nicely with vim-airline
else
    " Plugin 'qualiabyte/vim-colorstepper'
    " ** airline is a bit problematic with ctrlp **
    " Plugin 'vim-airline/vim-airline'
    " Plugin 'vim-airline/vim-airline-themes'
    Plugin 'vim-scripts/grep.vim'               " grep integration
    Plugin 'itchyny/lightline.vim'              " simpler airline
    Plugin 'bling/vim-bufferline'               " integrates nicely with vim-airline
endif
call vundle#end()

" --- GENERAL SETTINGS ---
if has('win32')
    colorscheme darkblue

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

" undo settings
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif

if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "", 0700)
endif

set incsearch " incremental search
set undofile
set undodir=~/.vim/undo

" folding options
set foldmethod=indent
set foldnestmax=40
set nofoldenable
set foldlevel=0

" generic
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set autoindent
set number
set encoding=utf-8
set noswapfile
set shortmess+=I
set backspace=indent,eol,start  " make backspace work like most other apps
set nocompatible
set ignorecase
set splitright
set splitbelow
set ruler
set relativenumber
set history=200                         " keep 200 lines of command line history
set showcmd                             " display incomplete commands
set laststatus=2                        " always show vim-airline status

if has('win32')
    set display=truncate                " show @@@ in the last line if it is truncated
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
    " clean ui
    set guioptions-=T
    set guioptions-=L
    set guioptions-=r
    set guioptions-=m
    set viewdir=$HOME/vimfiles/view/    " for mkview and loadview
endif

if has('gui_macvim')
    colorscheme solarized
    set guioptions=
    set guifont=Go\ Mono:h11
else
    colorscheme oceanlight
endif

" --- YCM/RUST SETTINGS ---
if has('win32')
    " let g:loaded_youcompleteme = 1
    let extra_conf_path = $HOME . '\_ycm_extra_conf.py'
    let g:ycm_global_ycm_extra_conf = extra_conf_path
    let g:ycm_auto_start_csharp_server = 1
    let g:ycm_csharp_server_port = 0
else
    " temporary enable/disable ycm: active = disable, commented = enable
    let g:loaded_youcompleteme = 1
    let g:ycm_global_ycm_extra_conf = $HOME . '/.ycm_extra_conf.py'
    " let g:ycm_server_use_vim_stdout = 0
    " let g:ycm_server_keep_logfiles = 1
    let g:OmniSharp_server_type = 'roslyn'
    let g:OmniSharp_prefer_global_sln = 1
endif

let g:ycm_disable_for_files_larger_than_kb = 0
let g:ycm_autoclose_preview_window_after_completion = 1
    
" makes ctrl-t not work in golang so just use ctrl-t
" nnoremap <leader>] :YcmCompleter GoTo<cr>

if executable('rustup')
    " export RUST_SRC_PATH=`rustc --print sysroot`/lib/rustlib/src/rust/src
    let g:ycm_rust_src_path = $RUST_SRC_PATH
    let g:rustfmt_autosave = 1
endif

" --- CTRLP ---
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_show_hidden = 1
" let g:ctrlp_use_caching = 1
" let g:ctrlp_clear_cache_on_exit = 0
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" 
" if has('win32')
"     let g:ctrlp_cache_dir = $HOME . '\.cache\ctrlp'
"     let g:ctrlp_custom_ignore = {
"         \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"         \ 'file': '\v\.(exe|so|dll)$',
"         \ 'link': 'some_bad_symbolic_links',
"         \ }
" else
"     let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
"     let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|hg|svn))$'
" endif

" --- VIM SNIPPETS ---
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" --- EMMET-VIM ---
" (see augroup + autocmd)
let g:user_emmet_install_global = 0

" --- AIRLINE/LIGHTLINE ---
if has('win32')
    let g:airline_theme = 'light'
elseif has('__macunix__')
    " let g:airline_theme = 'bubblegum'
    " let g:airline_powerline_fonts = 1
    " if !exists('g:airline_symbols')
    "     let g:airline_symbols = {}
    " endif

    " unicode symbols
    " let g:airline_left_sep = '»'
    " let g:airline_left_sep = '▶'
    " let g:airline_right_sep = '«'
    " let g:airline_right_sep = '◀'
    " let g:airline_symbols.crypt = '🔒'
    " let g:airline_symbols.linenr = '␊'
    " let g:airline_symbols.linenr = '␤'
    " let g:airline_symbols.linenr = '¶'
    " let g:airline_symbols.maxlinenr = '☰'
    " let g:airline_symbols.maxlinenr = ''
    " let g:airline_symbols.branch = '⎇'
    " let g:airline_symbols.paste = 'ρ'
    " let g:airline_symbols.paste = 'Þ'
    " let g:airline_symbols.paste = '∥'
    " let g:airline_symbols.spell = 'Ꞩ'
    " let g:airline_symbols.notexists = '∄'
    " let g:airline_symbols.whitespace = 'Ξ'
else
    " let g:airline_theme = 'light'
    let g:lightline = {
        \ 'colorscheme': 'PaperColor',
        \ }
endif

" --- VIM-GO + NEOCOMPLETE ---
" 1 :PluginInstall
" 2 :GoInstallBinaries (gotags, vim-go)
" 3 Install 'ctags'
" 4 go get -u github.com/jstemmer/gotags
if (has('unix') || has('macunix'))
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

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_operators = 1
let g:go_fmt_command = 'goimports' " could be slow on very large code bases
let g:go_fmt_fail_silently = 1
let g:go_fmt_experimental = 1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

" --- NERDTREE ---
map <c-n> :NERDTreeToggle<cr>
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeQuitOnOpen = 1

" --- SMOOTH SCROLL ---
let g:ms_per_line = 5

" --- SCRATCH MAPPINGS ---
let g:scratch_autohide = 1

" --- MODE MAPPINGS ---
" insert mode maps
imap <c-f> <esc>
imap <c-j> <esc>
imap jj <esc>

" --- MODE MAPPINGS ---
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

function! ScrollQuarter(move)
    let height=winheight(0)
    if a:move == 'up'
        let key="\<c-y>"
    else
        let key="\<c-e>"
    endif
    execute 'normal! ' . height/4 . key
endfunction

" reverse the movement cause the cursor movement confuses me
nnoremap <leader>uu :call ScrollQuarter('down')<cr>
nnoremap <leader>dd :call ScrollQuarter('up')<cr>

" disable Ex mode
nnoremap Q <nop>
nnoremap <leader>wq <c-w>q
nnoremap <leader>ws <c-w>s
nnoremap <leader>wv <c-w>v
nnoremap <leader>wo <c-w>o
nnoremap <leader>wr <c-w>R
nnoremap <leader>wh <c-w>H
nnoremap <leader>wj <c-w>J
nnoremap <leader>wk <c-w>K
nnoremap <leader>wl <c-w>L
nnoremap <leader><left> <c-w><left>
nnoremap <leader><right> <c-w><right>
nnoremap <leader><up> <c-w><up>
nnoremap <leader><down> <c-w><down>
nnoremap <leader>s :w<cr>
nnoremap <leader>e :e.<cr>
nnoremap <leader>pj :%!python -m json.tool<cr>
nnoremap <leader>dt :windo diffthis<cr>
nnoremap <leader>do :windo diffoff!<cr>
nnoremap <leader>cw :cw<cr>
nnoremap <leader>H <c-w>H
nnoremap <leader>hl :set hlsearch! hlsearch?<cr>
nnoremap <leader>t gt
nnoremap <leader>x :qall<cr>
nnoremap <leader>xx :qall!<cr>
nnoremap <leader>bs :Scratch<cr>
" nnoremap <leader>bs :new<cr>:setlocal buftype=nofile nobuflisted<cr>
" nnoremap <leader>bv :vnew<cr>:setlocal buftype=nofile nobuflisted<cr>
nnoremap <leader>bd :bd<cr>
nnoremap <leader>rn :exec &nu==&rnu? "set nornu" : "set rnu"<cr>
nnoremap <leader>cd :lcd %:h<cr>
nnoremap <leader>ma :CtrlPModified<cr>
nnoremap <leader>mb :CtrlPBranch<cr>
nnoremap <leader>h :MundoToggle<cr>
" specific to vim-go
nnoremap <leader>i :GoDoc<cr>
nnoremap <leader>ii :GoDescribe<cr>
nnoremap <leader>er :GoIfErr<cr>

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 6)<cr>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 6)<cr>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 12)<cr>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 12)<cr>

" --- SEARCH/REPLACE SPECIFIC MAPPINGS ---
" fzf settings
nnoremap <leader>pp :FZF<cr>
nnoremap <leader>hh :History<cr>
nnoremap <leader>ll :Lines<cr>
nnoremap <leader>\ :Ag<space>
nnoremap <leader>/ :Rg<space>
nnoremap <leader>\\ :Ag<space><c-r><c-w>
nnoremap <leader>// :Rg<space><c-r><c-w>

" prepare replace: move cursor to //, then get word under cursor using ctrl-r + ctrl-w
nnoremap <leader>rt :%s/<c-r><c-w>//gc<left><left><left>

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
    " #0 = prepare search/replace (generic)
    nnoremap <leader>f0 :Rfindpattern /ip <c-r><c-w> *
    nnoremap <leader>r0 :arg **/* <bar> argdo %s/<c-r><c-w>/?/gc <bar> update
elseif has('unix')
    if s:uname == "Darwin\n"
        " prepare pattern search via grep recursive (c/c++)
        nnoremap <leader>rg :Rgrep -I -i -r <c-r><c-w> *.h *.c *.cpp *.conf
        " prepare pattern search via grep recursive (generic)
        nnoremap <leader>rg :Rgrep -I -i -r <c-r><c-w> *
    else
        nnoremap <leader>rg :Rgrep -P -i --binary-files=without-match <c-r><c-w> *.h *.c *.cpp *.conf
        nnoremap <leader>rg :Rgrep -P -i --binary-files=without-match <c-r><c-w> *
    endif
endif

" --- AUGROUP ---
augroup searchreplaceonfiletype
    autocmd!
    autocmd FileType go call MapGoSearchReplace()
    autocmd FileType rust call MapRustSearchReplace()
augroup END

augroup yamlspacing
    autocmd!
    autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType json setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

function MapGoSearchReplace()
    let g:Grep_Skip_Dirs = 'vendor .git bin'

    " recursive search and replace, global, confirm, no error if none found
    nnoremap <leader>sr :arg **/*.go <bar> argdo %s/<c-r><c-w>/?/gce <bar> update
        \<left><left><left><left><left><left><left><left><left><left>
        \<left><left><left>

    " recursive search
    if has('macunix')
        nnoremap <leader>rg :Rgrep -I -i -r <c-r><c-w> *.go *.md *.conf *.yaml *.yml *.json
            \<left><left><left><left><left><left><left><left><left><left>
            \<left><left><left><left><left><left><left><left><left><left>
            \<left><left><left><left><left><left><left><left><left><left>
            \<left><left><left><left><left><left><left>
    else
        nnoremap <leader>rg :Rgrep -P -i --binary-files=without-match <c-r><c-w> *.go *.md *.conf *.yaml *.yml *.json
            \<left><left><left><left><left><left><left><left><left><left>
            \<left><left><left><left><left><left><left><left><left><left>
            \<left><left><left><left><left><left><left><left><left><left>
            \<left><left><left><left><left><left><left>
    endif
endfunction

function MapRustSearchReplace()
    " recursive search and replace, global, confirm, no error if none found
    nnoremap <leader>sr :arg **/*.rs <bar> argdo %s/<c-r><c-w>/?/gce <bar> update
        \<left><left><left><left><left><left><left><left><left><left>
        \<left><left><left>

    " recursive search
    if has('macunix')
        nnoremap <leader>rg :Rgrep -I -i -r <c-r><c-w> *.rs *.md *.conf *.yaml *.yml *.json
            \<left><left><left><left><left><left><left><left><left><left>
            \<left><left><left><left><left><left><left><left><left><left>
            \<left><left><left><left><left><left><left><left><left><left>
            \<left><left><left><left><left><left><left>
    else
        nnoremap <leader>rg :Rgrep -P -i --binary-files=without-match <c-r><c-w> *.rs *.md *.conf *.yaml *.yml *.json
            \<left><left><left><left><left><left><left><left><left><left>
            \<left><left><left><left><left><left><left><left><left><left>
            \<left><left><left><left><left><left><left><left><left><left>
            \<left><left><left><left><left><left><left>
    endif
endfunction

augroup highlight81and161
    " hightlight the 81st and 161st column
    autocmd!
    autocmd BufEnter * highlight OverLength ctermbg=magenta ctermfg=white guibg=magenta guifg=white
    autocmd BufEnter * match OverLength /\%81v/
    autocmd BufEnter * 2match OverLength /\%161v/
augroup END

augroup enablerustfiletype
    autocmd!
    autocmd BufRead,BufNewFile *.rs set filetype=rust
augroup END

augroup jmplastcurpos
    " from 'defaults.vim'
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

augroup emmetfiletypeenable
    " limit emmet-vim to html, css only
    autocmd!
    autocmd FileType html,css EmmetInstall
augroup END

" ** this group doesn't play well with ycm+rust
" augroup rememberfolds
"     autocmd!
"     autocmd BufWinLeave *.* mkview
"     autocmd BufWinEnter *.* silent! loadview
" augroup END

augroup splitqfix
    " <leader>Enter to open quickfix to vertical split
    autocmd!
    autocmd FileType qf nnoremap <buffer> <leader><enter> <c-w><enter><c-w>L
augroup END

" ColorStepper Keys
" nmap <F6> <Plug>ColorstepPrev
" nmap <F7> <Plug>ColorstepNext

" --- RAINBOW PARENTHESIS ---
let g:rainbow_active = 1
let g:rainbow_conf = {
    \    'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \    'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \    'operators': '_,_',
    \    'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \    'separately': {
    \        '*': {},
    \        'tex': {
    \            'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \        },
    \        'lisp': {
    \            'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \        },
    \        'vim': {
    \            'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \        },
    \        'html': {
    \            'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \        },
    \        'css': 0,
    \    }
    \}
