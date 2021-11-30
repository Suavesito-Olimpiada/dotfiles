"
" __     _____ __  __ ____   ____
" \ \   / /_ _|  \/  |  _ \ / ___|
"  \ \ / / | || |\/| | |_) | |
"   \ V /  | || |  | |  _ <| |___
"    \_/  |___|_|  |_|_| \_\\____|
"
" My vimrc
"


" fix runtime for some plugins

runtime! macros/matchit.vim

runtime! plugin/sensible.vim

packadd! termdebug
packadd! justify
packadd! shellmenu
packadd! matchit


"   ___        _   _
"  / _ \ _ __ | |_(_) ___  _ __  ___
" | | | | '_ \| __| |/ _ \| '_ \/ __|
" | |_| | |_) | |_| | (_) | | | \__ \
"  \___/| .__/ \__|_|\___/|_| |_|___/
"       |_|
"
" Some vim vanilla options
"
"{{{

set nocompatible
set pastetoggle=<F2>
set encoding=utf-8
set title
" set clipboard+=unnamedplus " to paste to system clipboard

syntax on
filetype plugin indent on

" This first because every leader action
" is remmaped to the key that the leader is
" configured with at THAT moment.
let mapleader=" "

set ignorecase
set smartcase
set incsearch
set hlsearch
if maparg('<Leader>l', 'n') ==# '' " Use <C-L> to clear the highlighting of :set hlsearch.
    nnoremap <silent> <Leader>l :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set tags=./.git/tags;
set path=.,**,,

set confirm
set showcmd

set backspace=2
set showmatch
" Might be dragons :v
" set virtualedit=onemore

set shiftround
set smarttab
set shiftwidth=4
set expandtab
set tabstop=4
set softtabstop=4
set autoindent
set smartindent

set omnifunc=syntaxcomplete#Complete
set complete+=kspel,i,d
set completefunc=syntaxcomplete#Complete
set thesaurus="thesaurus/thesaurus_en.txt"


set history=10000
set wildmenu
set wildmode=full
set wildignore+=tags,.*.un~,*.pyc,*.o

set background=dark
colorscheme gruvbox

set backupdir=~/.vim/backup
set directory=~/.vim/swap

set undofile
set undodir=~/.vim/undo
set undolevels=100000
set undoreload=100000

set hidden
set autoread
set autowrite
set autowriteall
set lazyredraw
set ttyfast

" set timeout
set ttimeout
" set timeoutlen=150
set ttimeoutlen=-1

set cursorline
set cursorcolumn
set number
set relativenumber
" set textwidth=80

set foldmethod=indent
set nofoldenable

set display+=lastline
set linebreak
set scrolloff=3
" set scrolljump=3

highlight ColorColumn ctermbg=darkgray ctermfg=red
set colorcolumn=81

highlight SpellBad term=reverse cterm=bold,reverse ctermfg=235 ctermbg=167 gui=bold,reverse guifg=#fb4934 guibg=bg

set splitbelow
set splitright

" Highlight trailing whitespaces
set list
set listchars=trail:·,tab:➣―
highlight SpecialKey ctermfg=33

set mouse=a


"}}}
"  _____                 _   _
" |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
" | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
" |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
" |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
"
" Some nice functions, I put them here
" because I'll probably use them all
" in maps or commands
"{{{

" Goyo enter + Limelight
function! s:goyo_enter()
    " Limelight
    set nocursorcolumn
    set nocursorline
endfunction

" Goyo enter - Limelight
function! s:goyo_leave()
  " Limelight!
  set cursorcolumn
  set cursorline
  AirlineRefresh
endfunction

" Tabular automatic mode
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Yank to system clipboard with OSC52
function! Osc52Yank()
    let buffer=system('base64 -w0', @0)
    let buffer=substitute(buffer, "\n$", "", "")
    let buffer='\e]52;c;'.buffer.'\x07'
    silent exe "!echo -ne ".shellescape(buffer)." > ".shellescape("/dev/tty")
endfunction

" Grammarous hooks
let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
    nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
    nmap <buffer><C-f> <Plug>(grammarous-fixit)
    nmap <buffer><C-r> <Plug>(grammarous-remove-error)
endfunction

function! g:grammarous#hooks.on_reset(errs) abort
    nunmap <buffer><C-n>
    nunmap <buffer><C-p>
    nunmap <buffer><C-f>
    nunmap <buffer><C-r>
endfunction


"}}}
"  __  __
" |  \/  | __ _ _ __  ___
" | |\/| |/ _` | '_ \/ __|
" | |  | | (_| | |_) \__ \
" |_|  |_|\__,_| .__/|___/
"              |_|
"
" Useful maps.
"{{{

" New leader in normal mode
nnoremap <space> <Nop>

" New enter normal mode
nnoremap <CR> i<CR><ESC>

" New position (`) mark
" this because <space> is th new leader
" and "`" in latam keyboard is much
" harder to type
nnoremap <Bslash> `

" New scape
" inoremap kj <ESC>
" deprecated because ctrl-c
" make esc, also ctrl-[
" and know block-amyus too.

" Wrapped lines goes down/up to next row, rather than next line in file.
" noremap j gj
" noremap k gk
" noremap ^ g^
" noremap 0 g0e
" noremap $ g$

nnoremap <silent> <leader>s :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Change windows focus
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h
" As ctrl-same, it can cause terminal block in some
" *nix terminals, in linux you can try stty -ixon.
" If you suffer of terminal block you can type ctrl-q
map <C-S> <C-W>=

" Buffer jumps in normal mode
nnoremap <silent> <leader>bn :bn<CR>
nnoremap <silent> <leader>bp :bp<CR>

" spell
nnoremap <silent> <Leader>es :set spell spelllang=es<CR>
nnoremap <silent> <Leader>en :set spell spelllang=en<CR>

" open a terminal {st stands for Simple Terminal}
nnoremap <silent> <Leader>st :vsplit<CR>:terminal ++curwin ++close<CR>

" smile!!!
nnoremap <silent> <Leader>sm :smile<CR>

" toggle between list and nolist
" nnoremap <silent> <F5> :set list!<CR>
" inoremap <silent> <F5> <Esc>:set list!<CR>a

" Explorer with netrw
nnoremap <silent> <Leader><Tab> :Explore!<CR>

" toggle goyo + limeligh
nnoremap <silent> <Leader>gl :Goyo<CR>

" toggle mundo
nnoremap <silent> <Leader>md :MundoToggle<CR>

" toggle tagbar
nnoremap <silent> <Leader>tb :TagbarToggle<CR>

" toggle latex2unicode
noremap <silent> <F7> :call LaTeXtoUnicode#Toggle()<CR>
inoremap <silent> <F7> <ESC>:call LaTeXtoUnicode#Toggle()<CR>a

" Grammarous check
nnoremap <silent> <Leader>gen :GrammarousCheck --lang=en<CR>
nnoremap <silent> <Leader>ges :GrammarousCheck --lang=es<CR>

" Grammarous operator map (gr)
map gr <Plug>(operator-grammarous)

" Leader load skeletons
nmap <silent> <Leader>tex :0read ~/.vim/sket/skeleton.tex
nmap <silent> <Leader>bea :0read ~/.vim/sket/skeleton.beamer

" Vim sneak f,t,F,T
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" bufferhint.vim
nnoremap - :call bufferhint#Popup()<CR>
nnoremap + :call bufferhint#LoadPrevious()<CR>

" LanguageClient maps
nmap <F5> <Plug>(lcn-menu)
vmap <F5> <Plug>(lcn-menu)
nmap <silent> gd <Plug>(lcn-definition)


"}}}
"     _         _         ____ __  __ ____
"    / \  _   _| |_ ___  / ___|  \/  |  _ \
"   / _ \| | | | __/ _ \| |   | |\/| | | | |
"  / ___ \ |_| | || (_) | |___| |  | | |_| |
" /_/   \_\__,_|\__\___/ \____|_|  |_|____/
"
" Here are some autocommands...
"
"{{{

" Colorcolumn just for coding documents
autocmd FileType c,cpp,python,julia,vim,sh,java,mail,pandoc,markdown  call matchadd('ColorColumn', '\%82v', 100)

" Keep the position of the open files
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" goyo+limelight compatibility
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Use of osc52 to pass the yanked text
" to the CLIPBOARD X selection
augroup YANK
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call Osc52Yank() | endif
augroup END

" Load skeletons automatically
" autocmd BufNewFile *.h      0read ~/.vim/sket/skeleton.h
" autocmd BufNewFile *.c      0read ~/.vim/sket/skeleton.c
" autocmd BufNewFile *.cpp    0read ~/.vim/sket/skeleton.cpp
" autocmd BufNewFile *.md     0read ~/.vim/sket/skeleton.md

" SuperCollider vim plugin
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd set filetype=supercollider
au Filetype supercollider packadd scvim

augroup Binary
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost *.bin if &bin | %!xxd
    au BufReadPost *.bin set ft=xxd | endif
    au BufWritePre *.bin if &bin | %!xxd -r
    au BufWritePre *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END


"}}}
"   ____                                          _
"  / ___|___  _ __ ___  _ __ ___   __ _ _ __   __| |___
" | |   / _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` / __|
" | |__| (_) | | | | | | | | | | | (_| | | | | (_| \__ \
"  \____\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|___/
"
" Useful commands.
"{{{

" Figlet insert text
command! -nargs=1 Figlet :r !figlet <q-args>

" Yank to system clipboard with OSC52
command! Osc52CopyYank call Osc52Yank()

" Add license
command! License call InsertLicense('licenseFile')


"}}}
"  ____  _             _
" |  _ \| |_   _  __ _(_)_ __  ___
" | |_) | | | | |/ _` | | '_ \/ __|
" |  __/| | |_| | (_| | | | | \__ \
" |_|   |_|\__,_|\__, |_|_| |_|___/
"                |___/
"
" Setting of vim plugins.
" My plugins are managed with Pathogen
" by the uncle pope.
"{{{

" Netrw
let g:netrw_liststyle=3
let g:netrw_browse_split=0
let g:netrw_altv=1
let g:netrw_winsize=25
let g:netrw_banner=0
let g:netrw_preview=1
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide+=&wildignore

" Gzip
let loaded_gzip=1

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#checks = [ 'trailing', 'mixed-indent-file' ]
let g:airline#extensions#whitespace#show_message = 1
let airline#extensions#c_like_langs = ['arduino', 'c', 'cpp', 'cuda', 'go', 'javascript', 'ld', 'php']
let g:airline#extensions#wordcount#filetypes = '\vasciidoc|help|mail|pandoc|markdown|org|rst|tex|text'

" deoplete
let g:deoplete#enable_at_startup = 1
packadd deoplete.nvim
call deoplete#custom#option({
\   'smart_case': v:true,
\   })
call deoplete#custom#source('LanguageClient',
\   'min_pattern_length',
\   2)

" LanguageClient-neovim
let g:LanguageClient_autoStart = 1
let g:LanguageClient_hasSnippetSupport = 1
let g:LanguageClient_hoverPreview = "Auto"
let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_usePopupHover = 1
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_serverCommands = {
\   'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
\       using Pkg;
\       Pkg.activate("LanguageServer", shared=true);
\
\       using LanguageServer;
\       using SymbolServer;
\       using StaticLint;
\
\       Pkg.activate(pwd());
\
\       src_path = pwd();
\       project_path = something(Base.current_project(src_path), Base.load_path_expand(LOAD_PATH[3])) |> dirname;
\
\       server = LanguageServerInstance(stdin, stdout, project_path);
\       run(server);
\   '],
\   'rust': ['rustup', 'run', 'nightly', 'rls'],
\   'python': ['pyls'],
\   'c': ['clangd'],
\   'cpp': ['clangd'],
\   'latex': ['texlab'],
\   'tex': ['texlab'],
\   'bash': ['bash-language-server', 'start'],
\   'sh': ['bash-language-server', 'start'],
\   'java': ['jdtls', '-data', getcwd()],
\   'scala': ['metals-vim'],
\   'r': ['R', '--slave', '-e', 'languageserver::run()'],
\   'glsl': ['glslls', '--stdin'],
\   'yaml': ['yaml-language-server', '--stdio'],
\   'yaml.docker-compose': ['yaml-language-server', '--stdio'],
\   'vim': ['vim-language-server', '--stdio'],
\   }

let settings = json_decode('
\{
\    "yaml": {
\        "format": {
\            "enable": true,
\            "singleQuote": false,
\            "bracketSpacing": true,
\            "proseWrap": "preserve",
\            "printfWidth": 80
\        },
\        "validate": true,
\        "hover": true,
\        "completion": true,
\        "schemas": {
\            "Kubernetes": "/*",
\            "https://json.schemastore.org/github-action.json": "github.yml",
\            "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json": "docker-compose.yml"
\        },
\        "schemaStore": {
\            "enable": true,
\        }
\    },
\    "http": {
\        "proxyStrictSSL": true
\    },
\    "trace": {
\        "server": "verbose",
\    }
\}')
augroup LanguageClient_config
    autocmd!
    autocmd User LanguageClientStarted call LanguageClient#Notify(
        \ 'workspace/didChangeConfiguration', {'settings': settings})
augroup END


" mundo (gundo fork)
let g:mundo_right = 1

" Vim-devicons
let g:webicons_enable = 1
let g:webdevicons_enable_airline_statusline = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsOS = 'Linux'

let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['csv'] = ''

" tagbar
let g:tagbar_type_julia = {
\   'ctagstype' : 'julia',
\   'kinds'     : [
\   't:struct', 'f:function', 'm:macro', 'c:const']
\   } " Add Julia support

" Vim Slime for repls
" <C-c><C-c> default keybind
let g:slime_target = "vimterminal"

" Vim-rooter
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_silent_chdir = 0
let g:rooter_resolve_links = 1
let g:rooter_targets = '/,*.h,*.hpp,*.cpp,*.c,*.jl,*.py,*.jl,Makefile,makefile,MAKEFILE'
let g:rooter_patterns = [
\   'README.rst',
\   'Readme.rst',
\   'README',
\   'Readme',
\   'README.md',
\   'Readme.md',
\   '.git',
\   '.git/',
\   ]

" Goyo vim
let g:goyo_width=120
let g:goyo_height=90

" Limelight vim
let g:limelight_conceal_ctermfg = 'DarkGray'
let g:limelight_conceal_ctermfg = 240

" Gotham Theme
let g:gotham_airline_emphasised_insert = 0

" Grammarous
let g:grammarous#use_vim_spelllang = 1
let g:grammarous#default_comments_only_filetypes = {
\   '*' : 1,
\   'markdown' : 0,
\   'pandoc' : 0,
\   'latex' : 0,
\   }
let g:grammarous#languagetool_cmd = 'languagetool'
let g:grammarous#show_first_error = 1

" Licenses vim
let g:licenses_copyright_holders_name = 'Zubieta Rico, Jose Joaquin <jose.zubieta@cimat.mx>'
let g:licenses_authors_name = 'Zubieta Rico, Jose Joaquin <jose.zubieta@cimat.mx>'
let g:licenses_default_commands = ['gpl', 'mit', 'gplv2', 'bsd2', 'bsd3', 'lgpl']

" UtilSnips vim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["/home/jose/.vim/snips"]
let g:UltiSnipsSnippetDir=["/home/jose/.vim/snips"]
let g:snips_author = "José Joaquín Zubieta Rico"

" Vim sneak
let g:sneak#label = 1

" Gutentags
let g:gutentags_project_root = ['README.rst', 'Readme.rst', 'README', 'Readme', 'README.md', 'Readme.md', '.git', '.git/']

" Gutentags + Gutentags_plus
let g:gutentags_modules = ['ctags', 'gtags_cscope']
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_plus_switch = 1
let g:gutentags_define_advanced_commands = 1

" Info.vim
let g:infoprg = '/usr/bin/info'

" bufferhint.vim
let g:bufferhint_MaxWidth = 40
let g:bufferhint_PageStep = 10

" vim-niceblock
let g:niceblock_no_default_key_mappings = 0

" julia-vim
let g:latex_to_unicode_auto = 1
let g:latex_to_unicode_tab = 0
let g:latex_to_unicode_file_types = "pandoc"

" vim-wheel by reedes
" let g:wheel#map#up   = '<C-S-k>'
" let g:wheel#map#down = '<C-S-j>'
" let g:wheel#map#mouse = 1

" edit_alternate.vim by tjdevries

packadd standard.vim
packadd conf.vim
packadd edit_alternate.vim
call edit_alternate#rule#add('c', {filename ->
        \ fnamemodify(filename, ':h:h')
        \ . '/include/'
        \ . fnamemodify(filename, ':t:r') . '.h'
        \ })
call edit_alternate#rule#add('cpp', {filename ->
        \ fnamemodify(filename, ':h:h')
        \ . '/include/'
        \ . fnamemodify(filename, ':t:r') . '.hpp'
        \ })
call edit_alternate#rule#add('h', {filename ->
        \ fnamemodify(filename, ':h:h')
        \ . '/src/'
        \ . fnamemodify(filename, ':t:r') . '.c'
        \ })
call edit_alternate#rule#add('hpp', {filename ->
        \ fnamemodify(filename, ':h:h')
        \ . '/src/'
        \ . fnamemodify(filename, ':t:r') . '.cpp'
        \ })
nnoremap <leader>ea :EditAlternate<CR>

" presenting.vim
au FileType pandoc let b:presenting_slide_separator_default = '\v(^|\n)\ze#{1,2}[^#]'
let g:presenting_figlets = 1
" let g:presenting_next = 'j'
" let g:presenting_prev = 'k'
" let g:presenting_quit = '<esc>'


"}}}
