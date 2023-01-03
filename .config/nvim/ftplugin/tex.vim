setlocal spell
setlocal norelativenumber

setlocal colorcolumn=

command -range=% Wordcount :<line1>,<line2> w !detex - | wc -w
command Spellfix :syntax spell toplevel

nnoremap <buffer> <silent> <leader>tf :w<CR> :!/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> main.pdf %<CR>
