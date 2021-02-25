setlocal spell
let b:AutoPairs = deepcopy(g:AutoPairs) | let b:AutoPairs["$"] = "$"
syntax spell toplevel

command -range=% Wordcount :<line1>,<line2> w !detex - | wc -w
