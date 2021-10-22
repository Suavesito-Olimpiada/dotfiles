" For encrypted files with ccrypt
augroup CPT
    au!
    au BufReadPre *.cpt       set bin
    au BufReadPre *.cpt       set viminfo=
    au BufReadPre *.cpt       set noswapfile
    au BufReadPre *.cpt       set noundofile
    au BufReadPost *.cpt      let $vimpass = inputsecret("Password: ")
    au BufReadPost *.cpt      silent '[,']!/usr/bin/ccrypt -cb -E vimpass
    au BufReadPost *.cpt      set nobin
    au BufWritePre *.cpt      set bin
    au BufWritePre *.cpt      '[,']!/usr/bin/ccrypt -e -E vimpass
    au BufWritePost *.cpt     u
    au BufWritePost *.cpt     set nobin
augroup END
