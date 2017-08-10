" for pathogen
    execute pathogen#infect()

" generic settings
    syntax enable
    set nu
    set ts=4
    " noet|retab! will set all spaces to tabs
    " et will insert 4 spaces when using the tab
    "set et
    set noet|retab!
    set shiftwidth=4
    set autoindent
    set t_Co=256
    set nowrap
    set mouse=a
    set ttymouse=xterm2
    set clipboard=unnamed
    set cursorline
    set ruler
    set fileformats=unix,dos,mac
    set hlsearch
    set backspace=indent,eol,start
    set foldmethod=manual

" set encodings
    set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932
    set fileencoding=utf-8
    set encoding=utf-8

" set ignorecase
    set ic

" set colorscheme
    colorscheme fu
    "colorscheme mustang
    "colorscheme desert256v2
    "colorscheme bensday

" enable file type detection
    filetype on
    filetype plugin on

" manually set .sv and .svh filetype
    au BufNewFile,BufRead *.sv set filetype=verilog_systemverilog
    au BufNewFile,BufRead *.svh set filetype=verilog_systemverilog

" clear last search highlight with ,+/ combo
    nmap <silent> ,/ : nohlsearch<CR>

"  ctrl + j/k go to next buffer/tab
    nmap <C-j> gT
    imap <C-j> <Esc> gT i
    nmap <C-k> gt
    imap <C-k> <Esc> gt i
    nmap <C-Left> gT
    imap <C-Left> <Esc> gT i
    nmap <C-Right> gt
    imap <C-Right> <Esc> gt i

" use <F5> to toggle display of preceeding and trailing white space
    noremap <F5> :set list!<CR>
    set listchars=eol:$,tab:>-,trail:.,extends:>,precedes:<,nbsp:_
    highlight SpecialKey term=standout ctermfg=250   ctermbg=237   guifg=#bcbcbc guibg=#3a3a3a

" for neocomplete - copied from github
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
            \ }
    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'
    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" for airline
    set laststatus=2
    let g:airline#extensions#tabline#enabled=1
    let g:airline#extensions#tabline#show_tabs = 1
    let g:airline_powerline_fonts=1
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline#extensions#tabline#fnamemod = ':t'
    let g:airline_theme='base16_isotope'

" for gitgutter
    highlight link GitGutterAdd DiffAdd
    highlight link GitGutterChange DiffChange
    highlight link GitGutterDelete DiffDelete
    highlight link GitGutterChangeDelete DiffChangeDelete

let g:gitgutter_sign_column_always = 1

" for supertab
    let g:SuperTabMappingForward  = '<s-tab>'
    let g:SuperTabMappingBackward = '<tab>'

" save and restore sessions
    fu! SaveSession()
        execute 'mksession! ' . getcwd() . '/.session.vim'
    endfunction

    function! RestoreSession()
        if argc() == 0
            if filereadable(getcwd() . '/.session.vim') 
                execute 'source ' . getcwd() . '/.session.vim'
                if bufexists(1)
                    for l in range(1, bufnr('$'))
                        if bufwinnr(1) == -1
                            exec 'sbuffer ' . l
                        endif
                    endfor
                endif
                GitGutterAll
            endif
        end
    endfunction

    autocmd VimEnter * call RestoreSession()
    autocmd VimLeave * call SaveSession()

    autocmd BufWinLeave *.* mkview
    autocmd BufWinEnter *.* silent loadview 

    autocmd VimLeave *.* mkview
    autocmd VimEnter *.* silent loadview 

" set ctags
    set tags=./tags;,./TAGS;,tags,TAGS
    map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
    map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" nerdtree
    au BufNewFile,BufRead nerdtree_* set filetype=txt
    let g:NERDTreeWinPos ="right"
    let g:NERDTreeCreatePrefix="nerdtree_"
    let g:NERDTreeDirArrowExpandable = '+'
    let g:NERDTreeDirArrowCollapsible = '~'
    hi Directory guifg=#ff0000 ctermfg=darkcyan
    noremap <F4> :NERDTreeToggle<CR>

" incsearch
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)

" minimap
    noremap <F6> :MinimapToggle <CR>
    noremap <F7> :MinimapUpdate <CR>

" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    if &term =~ '256color'
      set t_ut=
    endif
