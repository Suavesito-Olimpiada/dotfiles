setlocal textwidth=92

nnoremap <Leader>rs :split<CR>:term ++curwin julia -i<CR>
nnoremap <Leader>rv :vsplit<CR>:term ++curwin julia -i<CR>

" julia-vim
let g:latex_to_unicode_auto = 1
let g:default_julia_version = "1.8"
let g:latex_to_unicode_suggestions = 1
highlight link juliaParDelim Delimiter
highlight juliaComma guifg=Red ctermfg=Red

" set commentstring=#=%s=#
" set comments=s1:#=,mb:#,ex:=#,:#,b:#
" let commentary_format="#=%s=#"

let g:JuliaFormatter_options = {
    \ 'indent'                      : 4,
    \ 'margin'                      : 92,
    \ 'always_for_in'               : v:false,
    \ 'whitespace_typedefs'         : v:false,
    \ 'whitespace_ops_in_indices'   : v:true,
    \ }

packadd julia.vim
