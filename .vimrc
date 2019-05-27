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
    " auto read file while file change outside vim
    set autoread
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
        set t_Co=256        
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
    inoremap jk <esc>
    nnoremap <Backspace> <left>x<esc>
    nnoremap load <esc>:so %<CR>:noh<CR>
    " cut and paste {
        " can use <control> + <x> to cut the cursor line
        inoremap <C-x> <esc>ddi
        nnoremap <C-x> <esc>dd
        " can use <control> + <p> to paste the cursor line
        inoremap <C-v> <esc>pi
        nnoremap <C-v> <esc>p
        " can use <control> + <p> to paste the cursor line
        inoremap <C-c> <esc>yy<esc>
        " vnoremap <C-c> <esc>y<esc>
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
        nnoremap <C-S-up> mx<up>ddp<up>`x
        inoremap <C-S-up> <esc>mx<up>ddp<up>`x<right>i
        " can use <shit> + <up> to move cursor line to down
        nnoremap <C-S-down> mx<down>dd<up>P`x
        inoremap <C-S-down> <esc>mx<down>dd<up>P`x<right>i
        " remap gm to real middle of current line
        nnoremap <silent>gm :call <SID>Gm()<CR>
        " onoremap <silent>gm :call <SID>Gm()<CR>
    " save {
        " save file with sudo
        inoremap <C-a><C-s> <esc>:w !sudo tee > /dev/null %<CR>
        nnoremap <C-a><C-s> :w !sudo tee > /dev/null %<CR>
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
    " },
    " quote {
        " complete the quote and bracket
        " inoremap ( ()<left>
        " inoremap [ []<left>
        " inoremap { {}<left>
        " inoremap ' ''<left>
        " not usefual while " is for comment
        " inoremap " ""<left>
    " },
    " exit {
        
    "
" }

" comment and uncomment {
    autocmd FileType sh,ruby,python     let b:comment_leader = '# '
    autocmd FileType fstab,zsh          let b:comment_leader = '# '
    autocmd FileType apache,conf,nginx  let b:comment_leader = '# '
    autocmd FileType tex                let b:comment_leader = '% '
    autocmd FileType mail               let b:comment_leader = '> '
    autocmd FileType vim                let b:comment_leader = '" '
    autocmd FileType c,cpp              let b:comment_leader = '\/\/ '
    " default is '#'
    if !exists('b:comment_leader')
        let b:comment_leader = '# '
    endif
    noremap <C-_> :call ToggleComment(b:comment_leader)<CR>:noh<CR>
    inoremap <C-_> <esc>:call ToggleComment(b:comment_leader)<CR>:noh<CR>i
" }

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
" iabbrev <expr> for <SID>Ask('for', "for () {}", 1)
" iabbrev <expr> for "for () {\n}"   
