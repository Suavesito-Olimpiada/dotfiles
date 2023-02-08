set foldmethod=marker
set foldmarker={,}
set foldmethod=indent

" setlocal commentstring=//\ %s

call matchadd('ColorColumn', '\%81v', 100)

nnoremap <Leader>rs :split<CR>:term ++curwin root<CR>
nnoremap <Leader>rv :vsplit<CR>:term ++curwin root<CR>

" Vim clang format
let g:clang_format#code_style = "google"
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "BreakBeforeBraces" : "Stroustrup"}

packadd vim-clang-format

