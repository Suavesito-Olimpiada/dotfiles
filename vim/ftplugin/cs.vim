set completeopt=longest,menuone,popuphidden
set completepopup=highlight:Pmenu,border:off


let g:OmniSharp_popup_options = {
\   'highlight': 'Normal',
\   'padding': [0, 0, 0, 0],
\   'border': [1]
\}

let g:OmniSharp_popup_mappings = {
\   'sigNext': '<C-n>',
\   'sigPrev': '<C-p>',
\   'pageDown': ['<C-f>', '<PageDown>'],
\   'pageUp': ['<C-b>', '<PageUp>']
\}

let g:OmniSharp_want_snippet = 1

packadd omnisharp-vim
