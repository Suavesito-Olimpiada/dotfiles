" Organizing CSV files columns
" aug CSV_Editing
"         au!
"         au BufRead,BufWritePost *.csv :%ArrangeColumn
"         au BufWritePre *.csv :%UnArrangeColumn
" aug end

" CSV.vim)
let g:csv_highlight_column = 'y'
let g:csv_delim=','
let g:csv_strict_columns = 1
