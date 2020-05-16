call plug#begin('~/.local/share/nvim/plugged')

Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
