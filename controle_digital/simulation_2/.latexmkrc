$out_dir = 'build';
@default_files = ('relatorio.tex');
$pdflatex = 'pdflatex -synctex=1 -file-line-error -shell-escape -interaction=nonstopmode -output-directory=build %O %S; cp build/relatorio.pdf ./Sim02-120111098.pdf';
$pdf_mode = 1;
$force_mode = 1;
$bibtex_use = 1;

