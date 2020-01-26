set hlsearch
set tabstop=2
set noexpandtab
set autoindent
set mouse=r
syntax on

set paste
map <F7> :w !xclip<CR><CR>
vmap <F7> "+y
map <S-F7> :r!xclip -o<CR>
