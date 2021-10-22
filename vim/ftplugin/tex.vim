command! Compile !alacritty -e /home/jose/.vim/script/tex-compile.sh "%:p:h" "%:p:r" "%:p" &
set spell spl=es
set updatetime=1500
autocmd CursorHold,CursorHoldI * silent! w

let g:tex_flavor = 'latex'
let g:vimtex_format_enable = 1

packadd vimtex

" This space is for my snnipets (abbreviations)

" Snippets provided by ultisnipts
" ia tbl \begin{table}[htb]%[h\|t\|b\|p\|!] %(here\|top\|bottom\|page\|override (force))<CR>\label{tab:}<CR>\begin{center}<CR>\begin{tabular}{cc}%{c\|l\|r\|\|} %(center\|left\|right\|separator <\|>)<CR><TAB><TAB><TAB><TAB>&<TAB><TAB><TAB><TAB>\\<CR><BS><BS><BS><BS>\noalign{\hrule}<CR>\end{tabular}<CR>\caption{}<CR>\end{center}<CR>\end{table}<ESC>5k$yyjp2k5ha
" ia sum \sum_{}^{}{}<ESC>6ha
" ia prod \prod_{}^{}{}<ESC>6ha
" ia eqt \begin{equation}<CR><CR>\end{equation}<Up>
" ia eqtn \begin{equation*}<CR><CR>\end{equation*}<Up>
" ia int \int_{}^{}{}<ESC>6ha
" ia frac \frac{}{}<ESC>3ha
" ia txt \text{\ \ \ \ }<ESC>5ha
" ia mtx \begin{matrix}<CR><TAB>&<TAB><TAB>\\<CR>\end{matrix}<ESC>kyypkhi
" ia pmtx \begin{pmatrix}<CR><TAB>&<TAB><TAB>\\<CR>\end{pmatrix}<ESC>kyypkhi
" ia bmtx \begin{bmatrix}<CR><TAB>&<TAB><TAB>\\<CR>\end{bmatrix}<ESC>kyypkhi
" ia vmtx \begin{vmatrix}<CR><TAB>&<TAB><TAB>\\<CR>\end{vmatrix}<ESC>kyypkhi
" ia Bmtx \begin{Bmatrix}<CR><TAB>&<TAB><TAB>\\<CR>\end{Bmatrix}<ESC>kyypkhi
" ia Vmtx \begin{Vmatrix}<CR><TAB>&<TAB><TAB>\\<CR>\end{Vmatrix}<ESC>kyypkhi
" ia bf \mathbf{}<Left>
" ia bb \mathbb{}<Left>
" ia cal \mathcal{}<Left>
" ia frak \mathfrak{}<Left>
" ia inf \infty
" ia l(r) \left(\right)<ESC>6hi
" ia l[r] \left[\right]<ESC>6hi
" ia l{r} \left{\right}<ESC>6hi
" ia l[r) \left[\right)<ESC>6hi
" ia l(r] \left(\right]<ESC>6hi
" ia l.r\| \left.\right\|_{}^{}<ESC>12hi
" ia l\|r\| \left\|\right\|<ESC>6hi
" ia fig \begin{figure}%[h\|t\|b\|p\|!] %(here\|top\|bottom\|page\|override (force))<CR>\label{fig:}<CR>\includegraphics{}<CR>\caption{}<CR>\end{figure}<ESC>2k0f{a
" ia arr \begin{array}{cc}<CR><TAB>&<TAB><TAB>\\<CR>\end{array}<ESC>k6ha
" ia eqtarr \begin{eqnarray}<CR><TAB>& = &<TAB><TAB>\\<CR>\end{eqnarray}<ESC>k7ha
" ia eqtarrn \begin{eqnarray*}<CR><TAB>& = &<TAB><TAB>\\<CR>\end{eqnarray*}<ESC>k7ha
" ia enm \begin{enumerate}<CR>\item <TAB><CR><BS><BS>\end{enumerate}<ESC>kA
" ia ite \begin{itemize}<CR>\item <TAB><CR><BS><BS>\end{itemize}<ESC>kA
" ia des \begin{descripctio}<CR><TAB>\item <TAB><CR><BS>\end{descripctio}<ESC>kA
" ia proof \begin{proof}<CR><CR>\end{proof}<ESC>ka
" ia lem \begin{lemma}<CR><CR>\end{lemma}<ESC>ka
" ia apen \begin{appendix}<CR>\listoffigures<CR>\listoftables<CR>\end{appendix}
" ia fot \footnote{\label{note:}}<ESC>2ha
" ia lstset \lstset{ % General setup for the package<CR>language=,<CR>basicstyle=\small\sffamily,<CR>numbers=left,<CR>numberstyle=\tiny,<CR>frame=tb,<CR>tabsize=4,<CR>columns=fixed,<CR>showstringspaces=false,<CR>showtabs=false,<CR>keepspaces,<CR>commentstyle=\color{red},<CR>keywordstyle=\color{blue}<CR>}<ESC>12k$i
" ia frm \begin{frame}<CR><CR>\end{frame}<ESC>ka
