" GENERAL BINDINGS
" ================
set pastetoggle=<F6>

" interchange : and ;
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

" Natural movement in case of wrapped lines; NO skipping
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Easy jumping to beginning and end of line
nnoremap H ^
nnoremap L g_
vnoremap H ^
vnoremap L g_

" Disable the arrow keys for good :)
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Right> <NOP>
inoremap <Left> <NOP>
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Right> <NOP>
nnoremap <Left> <NOP>

" Handle splits the right way
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" search results appear in middle of buffer and blink
nnoremap n nzz
nnoremap N Nzz

" Enable resaving a file as root with sudo
cmap w!! w !sudo tee % >/dev/null

" visual shifting dows not exit visual mode
vnoremap < <gv
vnoremap > >gv

" follow tradition of C & D
nnoremap Y y$

" use terminal style mappings in cmd mode
cnoremap <C-a> <home>
cnoremap <C-e> <end>

" Better scrolling
noremap <expr> <C-f> max([winheight(0) - 2, 1])
	\ ."\<C-d>".(line('w$') >= line('$') ? "L" : "M")
noremap <expr> <C-b> max([winheight(0) - 2, 1])
	\ ."\<C-u>".(line('w0') <= 1 ? "H" : "M")
noremap <expr> <C-e> (line("w$") >= line('$') ? "j" : "3\<C-e>")
noremap <expr> <C-y> (line("w0") <= 1         ? "k" : "3\<C-y>")

" Press ENTER for blank line(in place)
nnoremap <silent> [<space> :set paste<CR>m`O<Esc>``:set nopaste<CR>
nnoremap <silent> ]<space> :set paste<CR>m`o<Esc>``:set nopaste<CR>

" QUICKFIX WINDOW SETTINGS
" ========================
" Toggle quickfix window
function! s:QuickfixToggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') ==? 'quickfix'
            cclose
            return
        endif
    endfor
    copen
endf

command! ToggleQuickfix call <SID>QuickfixToggle()
nnoremap gq :ToggleQuickfix<cr>

" Mappings for jumping to next/prev in quickfix window
nnoremap ]q :cnext<cr>
nnoremap [q :cprev<cr>

function! s:BufferCount()
    return len(filter(range(1, bufnr('$')), 'bufwinnr(v:val) != -1'))
endfunction

function! s:LocListToggle()
    let buffer_count_before = s:BufferCount()
    " Location list can't be closed if there's cursor in it, so we need 
    " to call lclose twice to move cursor to the main pane
    silent! lclose
    silent! lclose

    if s:BufferCount() == buffer_count_before
        execute "silent! lopen"
    endif
endfunction

command! ToggleLocList call <SID>LocListToggle()
nnoremap gl :ToggleLocList<cr>

" Next/Prev buffers
nnoremap [b :bprev<cr>
nnoremap ]b :bnext<cr>

" Autocomplete { on pressing <cr>
inoremap {<cr> {}<Esc>i<cr><Esc>O 

" LEADER KEY MAPPINGS
" ===================
let mapleader = "\<Space>"

" Close without saving
nnoremap <leader>q :q!<cr>
nnoremap <leader>Q :qa!<cr>

" Clear highlighting of searched text
nnoremap <silent> <leader>h :nohlsearch<cr>

" quick source vimrc
nnoremap <silent> <leader>sv :source $MYVIMRC<cr>