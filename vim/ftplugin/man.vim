set noswapfile
set noundofile

set nonumber
set norelativenumber

colorscheme molokai

let g:airline_theme='base16_gruvbox_dark_hard'

nnoremap <silent> <C-z> :set list<CR>:set list!<CR>:AirlineRefresh<CR>
