set foldmethod=marker
set foldmarker={,}

" setlocal commentstring=/*\ %s\ */

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


" Vim cpp enhanced highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
" let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1

packadd vim-clang-format
packadd vim-cpp-enhanced-highlight
