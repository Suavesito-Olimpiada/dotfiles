set textwidth=80
set wrap
set spell
set spl=es,en
set virtualedit=all

" command! -nargs=1 PandocAll :Pandoc <args> --filter pandoc-citeproc --filter pandoc-crossref --filter pandoc-pyplot --filter filter_pandoc_run_py
"

" Tabular automatic mode (gist tpope)
inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a

" Vim-Markdown
let g:markdown_fenced_languages = [
\   'html',
\   'python',
\   'bash=zsh',
\   'julia',
\   'c',
\   'cpp',
\   'dot'
\ ]
let g:markdown_minlines = 100 " As tpope/vim-markdown recoments
let g:markdown_syntax_conceal = 1

" Vim-pandoc
let g:vim_markdown_math = 1
let g:pandoc#command#custom_open = 'zathura'

" Vim-pandoc-syntax
let g:pandoc#syntax#codeblocks#embeds#langs = [
\   'html',
\   "ruby",
\   "julia",
\   "bash=sh",
\   "python",
\   "pyplot=python",
\   "c",
\   "cpp",
\   "dot",
\ ]

" Vim-pandoc-after (pandoc)
let g:pandoc#after#modules#enabled = ["ultisnips"]

" packadd vim-criticmarkup
" packadd vim-markdownfootnotes
packadd vim-pandoc-after
packadd vim-pandoc-syntax

" Tabular automatic mode on |
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
