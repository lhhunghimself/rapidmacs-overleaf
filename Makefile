.PHONY: all pdf check preprint clean distclean

all: pdf

pdf:
	latexmk -pdf -interaction=nonstopmode main.tex supplementary.tex

# Fail on LaTeX errors, unresolved references, text spilling out of a column,
# and exceeding the Bioinformatics Applications Note limit of 4 pages
# (~2,600 words, or 2,000 words plus one figure).
check: pdf
	@# nonstopmode still emits a PDF after an error, and a second latexmk run
	@# reports "up-to-date" and exits 0 -- so a broken build passes on the
	@# rerun unless the log itself is checked. latexmkrc sets -file-line-error,
	@# so errors read "./main.tex:133: Undefined control sequence." with no
	@# leading "! ". This is what catches a macro the OUP class does not
	@# provide (e.g. booktabs' \cmidrule), which renders locally but fails on
	@# Overleaf.
	@! grep -hE "^\.?/?[A-Za-z0-9_./-]+\.(tex|sty|cls|bbl):[0-9]+: " main.log supplementary.log \
	  || { echo "ERROR: LaTeX error above; the PDF is not trustworthy"; exit 1; }
	@! grep -qE "Citation .* undefined|Reference .* undefined" main.log supplementary.log \
	  || { echo "ERROR: undefined citations/references"; exit 1; }
	@! grep -hE "Overfull \\\\hbox \([0-9]{2,}\.[0-9]+pt too wide\) in paragraph" main.log supplementary.log \
	  || { echo "ERROR: badly overfull line (text will spill into the next column)"; exit 1; }
	@test "$$(grep -oE 'main.pdf \([0-9]+ pages' main.log | grep -oE '[0-9]+ pages' | grep -oE '^[0-9]+')" -le 4 \
	  || { echo "ERROR: note exceeds the 4-page Applications Note limit"; exit 1; }
	@echo "OK: $$(grep -oE 'main.pdf \([0-9]+ pages' main.log | head -1), $$(grep -oE 'supplementary.pdf \([0-9]+ pages' supplementary.log | head -1)"

# bioRxiv preprint: the same manuscript without the journal furniture (no
# volume, issue, DOI or publication date), then merged with the supplement into
# one PDF to upload.
preprint: rapidmacs-preprint.pdf

rapidmacs-preprint.pdf: preprint.tex supplementary.tex main.tex refs.bib
	latexmk -pdf -interaction=nonstopmode preprint.tex supplementary.tex
	@! grep -hE "^\\.?/?[A-Za-z0-9_./-]+\\.(tex|sty|cls|bbl):[0-9]+: " preprint.log supplementary.log \
	  || { echo "ERROR: LaTeX error above; the preprint is not trustworthy"; exit 1; }
	gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 \
	  -sOutputFile=$@ preprint.pdf supplementary.pdf
	@echo "OK: $@, $$(grep -oE 'preprint[.]pdf [(][0-9]+ pages' preprint.log | tail -1 | grep -oE '^[a-z.]+|[0-9]+ pages' | tail -1) + $$(grep -oE 'supplementary[.]pdf [(][0-9]+ pages' supplementary.log | tail -1 | grep -oE '[0-9]+ pages')"

clean:
	latexmk -c

distclean:
	latexmk -C
