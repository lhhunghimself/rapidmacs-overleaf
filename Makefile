.PHONY: all pdf check clean distclean

all: pdf

pdf:
	latexmk -pdf -interaction=nonstopmode main.tex supplementary.tex

# Fail on unresolved references, on text spilling out of a column, and on
# exceeding the Bioinformatics Applications Note limit of 4 pages
# (~2,600 words, or 2,000 words plus one figure).
check: pdf
	@! grep -qE "Citation .* undefined|Reference .* undefined" main.log supplementary.log \
	  || { echo "ERROR: undefined citations/references"; exit 1; }
	@! grep -hE "Overfull \\\\hbox \([0-9]{2,}\.[0-9]+pt too wide\) in paragraph" main.log supplementary.log \
	  || { echo "ERROR: badly overfull line (text will spill into the next column)"; exit 1; }
	@test "$$(grep -oE 'main.pdf \([0-9]+ pages' main.log | grep -oE '^[0-9]+' | tail -1)" -le 4 \
	  || { echo "ERROR: note exceeds the 4-page Applications Note limit"; exit 1; }
	@echo "OK: $$(grep -oE 'main.pdf \([0-9]+ pages' main.log | head -1), $$(grep -oE 'supplementary.pdf \([0-9]+ pages' supplementary.log | head -1)"

clean:
	latexmk -c

distclean:
	latexmk -C
