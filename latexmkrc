# latexmk configuration.
#
# Overleaf reads this file (no leading dot) from the project root and uses it
# for its own compile, so local and Overleaf builds behave the same way.

# pdflatex, not xelatex/lualatex: the OUP class is pdflatex-targeted.
$pdf_mode = 1;

# Always run bibtex when the .aux file requests it.
$bibtex_use = 2;

# Keep going through the usual "undefined reference on first pass" noise, but
# still surface real errors in the log.
$pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error -synctex=1 %O %S';

# Both compilable documents: the note and its supplement.
@default_files = ('main.tex', 'supplementary.tex');

# Extra generated files latexmk should clean up with `latexmk -c`.
$clean_ext = 'bbl fdb_latexmk fls synctex.gz run.xml bcf spl';
