# RapidMACS Applications Note — Overleaf working copy

Manuscript source for the RapidMACS *Bioinformatics* Applications Note,
kept as a minimal tree so the Overleaf project contains only what compiles.

```
main.tex                     the note (4-page Applications Note limit)
supplementary.tex            Supplementary Material S1-S4
refs.bib                     references
latexmkrc                    build config; Overleaf reads this too
oup-authoring-template.cls   vendored OUP class (LPPL)
oup-abbrvnat.bst             OUP author-year style (in use)
oup-plain.bst                OUP numbered style (alternative)
figures/                     the one figure the supplement includes
```

Set `main.tex` as the main document after importing — `supplementary.tex`
also has a `\documentclass`, so Overleaf may otherwise pick it.

Build locally with `latexmk -pdf main.tex supplementary.tex`.

Full project history, benchmark data, figure generators and writing notes:
<https://github.com/lhhunghimself/rapidmacs-paper> (private).
