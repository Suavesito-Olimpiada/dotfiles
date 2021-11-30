setlocal textwidth=92

nnoremap <Leader>rs :split<CR>:term ++curwin julia -i<CR>
nnoremap <Leader>rv :vsplit<CR>:term ++curwin julia -i<CR>

" julia-vim
let g:latex_to_unicode_auto = 1
let g:default_julia_version = "1.5.1"
let g:latex_to_unicode_suggestions = 1
highlight link juliaParDelim Delimiter
highlight juliaComma guifg=Red ctermfg=Red

set commentstring=#=%s=#
set comments=s1:#=,mb:#,ex:=#,:#,b:#
let commentary_format="#=%s=#"

let g:JuliaFormatter_options = {
    \ 'indent'                      : 4,
    \ 'margin'                      : 92,
    \ 'always_for_in'               : v:false,
    \ 'whitespace_typedefs'         : v:false,
    \ 'whitespace_ops_in_indices'   : v:true,
    \ }

" Format Julia code
" normal mode mapping
nnoremap <silent> <Leader>jf :<C-u>call JuliaFormatter#Format(0)<CR>
" visual mode mapping
vnoremap <silent> <Leader>jf :<C-u>call JuliaFormatter#Format(1)<CR>

let g:JuliaFormatter_server = 1

packadd julia.vim
packadd JuliaFormatter.vim
