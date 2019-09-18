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
" and make pathogen work

execute pathogen#infect()

runtime! macros/matchit.vim

runtime! plugin/sensible.vim


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

set tags=./tags
set path+=**,include

set confirm
set showcmd

set backspace=2
set showmatch

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

highlight ColorColumn ctermbg=darkgray  ctermfg=red
" set colorcolumn=81

set splitbelow
set splitright

" Highlight trailing whitespaces
set list
set listchars=trail:·,tab:➣―
highlight SpecialKey ctermfg=33


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
    Limelight
    set nocursorcolumn
    set nocursorline
endfunction

" Goyo enter - Limelight
function! s:goyo_leave()
  Limelight!
  set cursorcolumn
  set cursorline
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

" New scape
" inoremap kj <ESC>
" deprecated because ctrl-c
" make esc, also ctrl-[

" Wrapped lines goes down/up to next row, rather than next line in file.
" noremap j gj
" noremap k gk
" noremap ^ g^
" noremap 0 g0e
" noremap $ g$

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
nnoremap <silent> <F5> :set list!<CR>
inoremap <silent> <F5> :set list!<CR>

" toggle goyo + limeligh
nnoremap <silent> <Leader>gl :Goyo<CR>

" toggle mundo
nnoremap <silent> <Leader>md :MundoToggle<CR>

" LanguageClient-neovim keybinds
augroup LCT
    autocmd!
    autocmd FileType julia,rust,python,c,cpp,latex  noremap <silent> K :call LanguageClient_textDocument_hover()<CR>
    autocmd FileType julia,rust,python,c,cpp,latex  noremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
    autocmd FileType julia,rust,python,c,cpp,latex  noremap <silent> <Leader>rn :call LanguageClient_textDocument_rename()<CR>
augroup END

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

" For encrypted files with ccrypt
augroup CPT
    au!
    au BufReadPre *.cpt       set bin
    au BufReadPre *.cpt       set viminfo=
    au BufReadPre *.cpt       set noswapfile
    au BufReadPre *.cpt       set noundofile
    au BufReadPost *.cpt      let $vimpass = inputsecret("Password: ")
    au BufReadPost *.cpt      silent '[,']!/usr/bin/ccrypt -cb -E vimpass
    au BufReadPost *.cpt      set nobin
    au BufWritePre *.cpt      set bin
    au BufWritePre *.cpt      '[,']!/usr/bin/ccrypt -e -E vimpass
    au BufWritePost *.cpt     u
    au BufWritePost *.cpt     set nobin
augroup END

" Comment string for diferent types
autocmd FileType c,cpp,cs,java      setlocal commentstring=//\ %s
autocmd FileType git,gitcommit      setlocal foldmethod=syntax foldlevel=1

" COlorcolumn just for coding documents
autocmd FileType c,cpp,python,julia,vim,sh  call matchadd('ColorColumn', '\%81v', 100)

" Keep the position of the open files
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Tabular automatic mode (gist tpope)
autocmd FileType markdown inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a

" goyo+limelight compatibility
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" NERDTree
noremap <silent> <Leader><Tab> :NERDTreeToggle<CR>

" Use of osc52 to pass the yanked text
" to the CLIPBOARD X selection
augroup YANK
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call Osc52Yank() | endif
augroup END

" Organizing CSV files columns
aug CSV_Editing
        au!
        au BufRead,BufWritePost *.csv :%ArrangeColumn
        au BufWritePre *.csv :%UnArrangeColumn
aug end

" Load skeletons automatically
" autocmd BufNewFile *.h      0read ~/.vim/sket/skeleton.h
" autocmd BufNewFile *.c      0read ~/.vim/sket/skeleton.c
" autocmd BufNewFile *.cpp    0read ~/.vim/sket/skeleton.cpp
" autocmd BufNewFile *.md     0read ~/.vim/sket/skeleton.md


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

" Pandoc ALL
command! -nargs=1 PandocAll :Pandoc <args> --filter ~/.pandoc/dot2tex-filter.py --filter pandoc-crossref --filter pandoc-pyplot --filter filter_pandoc_run_py


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

" Vim-Markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=zsh', 'julia']
let g:markdown_minlines = 100 " As tpope/vim-markdown recoments
let g:markdown_syntax_conceal = 1

" Vim-pandoc
let g:vim_markdown_math = 1
let g:pandoc#command#custom_open = 'zathura'

" Vim-pandoc-after (pandoc)
let g:pandoc#after#modules#enabled = ["ultisnips"]

" Gzip
let loaded_gzip=1

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#checks = [ 'trailing', 'mixed-indent-file' ]
let g:airline#extensions#whitespace#show_message = 1
let airline#extensions#c_like_langs = ['arduino', 'c', 'cpp', 'cuda', 'go', 'javascript', 'ld', 'php']

" deoplete
let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option('smart_case', v:true)

" mundo (gundo fork)
let g:mundo_right = 1

" julia-vim
let g:latex_to_unicode_auto = 1
let g:default_julia_version = "1.1.0"
" let g:latex_to_unicode_suggestions = 1

" LanguageClient-neovim
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
\   'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
\       using LanguageServer;
\       using Pkg;
\       import StaticLint;
\       import SymbolServer;
\       env_path = dirname(Pkg.Types.Context().env.project_file);
\       debug = false;
\
\       server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "", Dict());
\       server.runlinter = true;
\       run(server);
\   '],
\   'rust': ['rustup', 'run', 'nightly', 'rls'],
\   'python': ['pyls'],
\   'c': ['clangd'],
\   'cpp': ['clangd'],
\   'latex': ['texlab'],
\   'bash': ['bash-language-server'],
\   }

set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

" NERDTree
let g:NERDTreeShowHidden=0
let g:NERDTreeIndicatorMapCustom = {
\   "Modified"  : "✹",
\   "Staged"    : "✚",
\   "Untracked" : "✭",
\   "Renamed"   : "➜",
\   "Unmerged"  : "═",
\   "Deleted"   : "✖",
\   "Dirty"     : "✗",
\   "Clean"     : "✔︎",
\   'Ignored'   : '☒',
\   "Unknown"   : "?"
\   }

" NerdTree syntax highlight
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeSyntaxEnabledExtensions = ['jl', 'h', 'diff']

" Vim-devicons
let g:webicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_statusline = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 0
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
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

" dispatch
autocmd FileType c let b:dispatch = 'make %'
autocmd FileType cpp let b:dispatch = 'make %'
autocmd FileType julia let b:dispatch = 'julia %'

" Vim Slime for repls
" <C-c><C-c> default keybind
let g:slime_target = "vimterminal"

" Vim-rooter
let g:rooter_change_directory_for_non_project_files = 'home'
let g:rooter_targets = '/,*.h,/*.cpp,*.c,*.jl,*.py,Makefile,makefile,MAKEFILE'
let g:rooter_patterns = ['README.md', 'Readme.md', '.git', '.git/']

" Goyo vim
let g:goyo_width=120
let g:goyo_height=90

" Limelight vim
let g:limelight_conceal_ctermfg = 'DarkGray'
let g:limelight_conceal_ctermfg = 240

" Gotham Theme
let g:gotham_airline_emphasised_insert = 0

" Grammarous
let g:grammarous#default_comments_only_filetypes = {
\   '*' : 1,
\   'markdown' : 0,
\   'pandoc' : 0,
\   'latex' : 0,
\   }
let g:grammarous#languagetool_cmd = 'languagetool'
let g:grammarous#show_first_error = 1

" Vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0

" CSV.vim
let g:csv_highlight_column = 'y'
:let g:csv_delim=','
let g:csv_strict_columns = 1

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

" Vim clang format
let g:clang_format#code_style = "google"
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "BreakBeforeBraces" : "Stroustrup"}

" Vim sneak
let g:sneak#label = 1


"}}}
