$pdf_previewer = 'open -a Skim';
$pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode';
$xelatex = 'xelatex -interaction=nonstopmode';
@generated_exts = (@generated_exts, 'synctex.gz');
