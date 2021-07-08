setlocal spell

command -range=% Wordcount :<line1>,<line2> w !detex - | wc -w
command Spellfix :syntax spell toplevel
