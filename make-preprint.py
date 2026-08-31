#!/usr/bin/env python3
"""Derive preprint.tex from main.tex.

preprint.tex used to be a hand-maintained copy, which silently drifted: a
correction to main.tex's availability statement never reached it, and the
submitted preprint kept a stale registry reference. Generating it removes that
failure mode -- the two can no longer disagree on anything but the journal
metadata deliberately changed below.
"""
import re
import sys

src = open("main.tex").read()

old_meta = r"""\journaltitle{Bioinformatics}
\DOI{DOI added during production}
\copyrightyear{2026}
\pubyear{2026}
\vol{00}
\issue{0}
\access{Advance Access Publication Date: Day Month Year}
\appnotes{Applications Note}"""
new_meta = r"""% Preprint build: no journal, volume, issue, DOI or publication date yet.
\journaltitle{}
\DOI{}
\copyrightyear{2026}
\pubyear{2026}
\vol{}
\issue{}
\access{}
\appnotes{Applications Note (preprint)}"""

if old_meta not in src:
    sys.exit("ERROR: main.tex journal metadata block not found; update make-preprint.py")
out = src.replace(old_meta, new_meta, 1)

# Blank volume/issue would leave stranded punctuation in the OUP running head,
# so use a plain page style instead of the journal one.
if r"\maketitle" not in out:
    sys.exit("ERROR: \\maketitle not found in main.tex")
out = out.replace(r"\maketitle", "\\maketitle\n\\pagestyle{plain}\n\\thispagestyle{plain}", 1)

open("preprint.tex", "w").write(
    "% GENERATED from main.tex by make-preprint.py -- do not edit.\n"
    "% Run `make preprint` to regenerate.\n" + out)
print("preprint.tex regenerated from main.tex")
