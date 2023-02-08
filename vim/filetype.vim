"
"  _____ _ _      _
" |  ___(_) | ___| |_ _   _ _ __   ___  ___
" | |_  | | |/ _ \ __| | | | '_ \ / _ \/ __|
" |  _| | | |  __/ |_| |_| | |_) |  __/\__ \
" |_|   |_|_|\___|\__|\__, | .__/ \___||___/
"                     |___/|_|
"
" Define new filetypes.
"

" " Defines csv filetype
" if exists("did_load_csvfiletype")
"     finish
" endif
" let did_load_csvfiletype=1

augroup filetypedetect
"     au! BufRead,BufNewFile *.csv,*.dat	setfiletype csv
    au! BufRead,BufNewFile *.sgf	setfiletype sgf
augroup END
