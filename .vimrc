" base setting{
    " enable file type detect
    filetype on
    " syntax highlight
    syntax on
    " use vim setting not vi setting
    set nocompatible 
    " let backspace can use but still can use if no set (?)
    set bs=2                
    " retain the command history, ex wq
    set history=50
    " let chinese can be used
    set encoding=utf-8
    " auto read file while file change outside vim
    set autoread
    " Allow us to use Ctrl-s and Ctrl-q as keybinds
    silent !stty -ixon
    " Restore default behaviour when leaving Vim.
    autocmd VimLeave * silent !stty ixon
" }

" indent {
    " auto indent on different type
    filetype indent on
    " set auto indent
    set autoindent
    " copy indent from last line
    set copyindent
" }

" view {
    " color mod {
        set t_co=256        
        " the color(theme) use now
        set background=dark  
    " },
    " overlength {          " highlight if one line over 80 word
    "   highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    "   match OverLength /\%81v.\+/
    " },
    " show line number
    set number
" }

" tab {
    " use space to replace tab
    set expandtab       
    " 4 space while hit tab
    set softtabstop=4   
    " 4 space while auto indent
    set shiftwidth=4
    " set 2 space on these file type
    autocmd FileType html setlocal ts=2 sts=2 sw=2
    autocmd FileType ruby setlocal ts=2 sts=2 sw=2
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2
" } 

" mouse {
    " let mouse can use in vim
    set mouse=a         
" }

" scroll {
    " retain 5 line while scrolling
    set scrolloff=5
" }

" current line {
    " show current position, ex 34, 56
    set ruler
    " show current line
    set cursorline
" }

" search {
    " highlight the search, it is default, comment this line is ok
    set hlsearch        
" }

" some useful map {
    set timeout
    set timeoutlen=200
    let mapleader = "\<space>\<space>"
    " for vimrc {
        nnoremap <leader>l <esc>:so $MYVIMRC<CR>:noh<CR>
        nnoremap <leader>v :vsplit $MYVIMRC<CR>
    " }
    " cut and paste {
        " can use <control> + <x> to cut the cursor line
        inoremap <C-x> <esc>ddi
        nnoremap <C-x> <esc>dd
        " can use <control> + <p> to paste the cursor line
        inoremap <C-v> <esc>pi
        nnoremap <C-v> <esc>p
        " can use <control> + <p> to paste the cursor line
        inoremap <C-c> <esc>yy<esc>
        vnoremap <C-c> y
        nnoremap <C-c> <esc>:call CopyLine()<esc>
    " },
    " move cursor {
        " can use <control> + <shift> + <left> to move to the beginning of the line
        nnoremap <C-S-left> ^
        inoremap <C-S-left> <esc>^i
        " can use <shift> + <right> to move to the end of the line
        nnoremap <C-S-right> $
        inoremap <C-S-right> <esc>$i
        " can use <shit> + <up> to move cursor line to up
        nnoremap <C-S-up> mxkddpk`x
        inoremap <C-S-up> <esc>mxkddpk`xli
        " can use <shit> + <up> to move cursor line to down
        nnoremap <C-S-down> mxjddkP`x
        inoremap <C-S-down> <esc>mxjddkP`xli
        " remap gm to real middle of current line
        nnoremap <silent>gm :call <SID>Gm()<CR>
    " save {
        " save file with sudo
        inoremap <leader>s <esc>:w !sudo tee > /dev/null %<CR>
        nnoremap <leader>s :w !sudo tee > /dev/null %<CR>
        " save file
        nnoremap <C-s> :w<CR>
        inoremap <C-s> <esc>:w<CR>
    " },
    " rollback {
        inoremap <C-z> <esc>ui
        nnoremap <C-z> u
    " }, 
    " indent {
        " can use shift-tab to reverse tab
        inoremap <S-tab> <esc><<i
        nnoremap <S-tab> <<
        nnoremap <tab> >>
        vnoremap > >gv
        vnoremap < <gv
        vnoremap <tab> >gv
        vnoremap <S-tab> <gv
        " reindent all file
        nnoremap <leader>g G=gg
        set pastetoggle=<leader>p
    " },
    " quote and bracket {
        " quote bracket current word
        nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
        inoremap <leader>" <esc>viw<esc>a"<esc>bi"<esc>leli
        nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
        inoremap <leader>' <esc>viw<esc>a'<esc>bi'<esc>leli
        nnoremap <leader>{ viw<esc>a}<esc>bi{<esc>lel
        inoremap <leader>{ <esc>viw<esc>a}<esc>bi{<esc>leli
        nnoremap <leader>( viw<esc>a)<esc>bi(<esc>lel
        inoremap <leader>( <esc>viw<esc>a)<esc>bi(<esc>leli
    " },
    " exit {
        " use jk to esc
        inoremap jk <esc>
    " },
    " select {
        " select all
        nnoremap <C-a> ggVG 
        " select one word
        nnoremap <leader><space> viw
    " },
    " delete {
        vnoremap <Backspace> d
        nnoremap <Backspace> <left>x<esc>
        " delete to the end of line
        nnoremap D d$
    " },
    " search {
        " keep result at the center
        nnoremap n nzz
        nnoremap N Nzz
    " },
    " complete {
        inoremap <tab> <C-R>=TabComplete()<CR>
        inoremap <tab><tab> <tab>
    " },
    " switch case {
        nnoremap <leader>U gUiw
        nnoremap <leader>L guiw
    " }
    " unmap
        map { <nop>
        map } <nop>
        map ( <nop>
        map ) <nop>
    " }
" }

" abbreviation {
    iabbrev adn and
    iabbrev fucntion function
    iabbrev @@ @gmail.com
    " iabbrev <expr> for "for () {\n}"
    " iabbrev <expr> for <SID>Ask('for', "for () {}", 1)
" }

" comment and uncomment {
    autocmd FileType sh,ruby,python     let b:comment_leader = '# '
    autocmd FileType fstab,zsh          let b:comment_leader = '# '
    autocmd FileType apache,conf,nginx  let b:comment_leader = '# '
    autocmd FileType tex                let b:comment_leader = '% '
    autocmd FileType mail               let b:comment_leader = '> '
    autocmd FileType vim                let b:comment_leader = '" '
    autocmd FileType c,cpp              let b:comment_leader = '\/\/ '
    autocmd FileType javascript         let b:comment_leader = '\/\/ '
    " default is '#'
    if !exists('b:comment_leader')
        let b:comment_leader = '# '
    endif
    noremap <C-_> :call ToggleComment(b:comment_leader)<CR>:noh<CR>
    noremap <C-k> :call ToggleComment(b:comment_leader)<CR>:noh<CR>
    inoremap <C-_> <esc>:call ToggleComment(b:comment_leader)<CR>:noh<CR>i
    inoremap <C-k> <esc>:call ToggleComment(b:comment_leader)<CR>:noh<CR>i
    vnoremap <C-k> :call Test(b:comment_leader)<CR>
" }

" command! -range Comment call Test()
" function! Comment() range
"   for line_number in range(a:firstline, a:lastline)
"     let current_line = getline(line_number)
"     let current_line_commented = substitute(current_line, '^', '# ', "")
"     call setline(line_number, current_line_commented)
"   endfor
" endfunction

function! Test(comment_leader) range
    let i = a:firstline
    let min_space_num = 1000
    while i <= a:lastline
        let space_num = indent(i)
        if space_num < min_space_num
            let min_space_num = space_num
        endif
        let i = i + 1
    endwhile

    let min_indent = repeat(" ", min_space_num)
    let space_comment_leader = min_indent . a:comment_leader
    let uncomment = 0
    let i = a:firstline
    while i <= a:lastline
        let cl = getline(i)
        if cl =~ "^" . space_comment_leader
        else
            let uncomment = 1
        endif
        let i = i + 1
    endwhile

    let i = a:firstline
    while i <= a:lastline
        let cl = getline(i)
        if uncomment
            let cl2 = substitute(cl, "^" . min_indent, space_comment_leader, "")
            call setline(i, cl2)
        else
            let cl2 = substitute(cl, space_comment_leader, min_indent, "")
            call setline(i, cl2)
        endif
        let i = i + 1
    endwhile
endfunction

function! ToggleComment(comment_leader)
    if getline('.') =~ "^". a:comment_leader
        :exe 's/^' . a:comment_leader . '//'
    else
        :exe 's/^/' . a:comment_leader . '/'
    endif
endfunction

function! CopyLine()
    :normal yy
endfunction

function! s:Gm()
    execute 'normal! ^'
    let first_col = virtcol('.')
    execute 'normal! g_'
    let last_col = virtcol('.')
    execute 'normal! ' . (first_col + last_col) / 2 . '|'
endfunction

function! s:Ask(abbr,expansion,defprompt)
    let answer = confirm("Expand '" . a:abbr . "'?", "&Yes\n&No", a:defprompt)
    return answer == 1 ? a:expansion : a:abbr
endfunction

function! TabComplete()
    if col('.') > 1 && strpart(getline('.'), col('.') - 2, 3) =~ '^\w'
        return "\<C-P>"
    else
        return "\<Tab>"
endfunction

