# RapidMACS v1.0.1 candidate refresh — 2026-08-22

Private benchmark handoff; this file is provenance for the standalone paper and is not a release note. No commit, merge, push, or publication was performed.

## Scope and provenance

- Candidate source: RapidMACS v1.0.1 exact commit `c22ff439cc66337e1b7fc9b87b547478eb5c0d3b` in the clean isolated worktree `/mnt/pikachu/rapidmacs-v1.0.1-refresh-20260822`.
- Candidate binary: `/mnt/pikachu/rapidmacs-v1.0.1-refresh-20260822/bin/rapidmacs`; SHA256 `7b0a8dfb6d9ae4212d7bfc9952198bcfb70a51acc04aa9c4359693a9ec2172e`.
- Host/storage: pikachu, 13th Gen Intel Core i9-13900KF, 128 GiB; timed inputs, outputs, temporary files, and candidate work roots were on `/dev/nvme0n1p2`.
- Candidate result bundle: `/storage/rapidmacs_candidate_refresh_20260822`.
- Aggregate candidate values: `provenance/candidate_results.tsv` (18 measured rows) and `provenance/candidate_stages.tsv` (18 stage rows).
- Reused comparator values: `provenance/baseline_reuse.tsv` and `provenance/oracle_*.tsv`; frozen MACS3 roots were not modified and MACS3 was not launched during this refresh.
- Exact six-row command/name/oracle audit: `provenance/row_mapping.tsv` and `provenance/row_mapping.md`.
- Per-row `candidate_only_metadata.tsv` files are authoritative for the candidate-only contract and explicitly record `macs3_action=not launched`; inherited script metadata fields that describe the original dual-caller harness are not used as refresh provenance.

## Six-row mapping and final candidate medians

| Paper row | Exact candidate output name | Candidate wall medians (T=1 / 4 / 24 s) | Speedup versus reused MACS3 median | Parity |
|---|---|---:|---:|---|
| scATAC 10x supplied fragments | `atac_treatment_only` | 58.930 / 24.440 / 16.350 | 12.685x / 30.587x / 45.722x | PASS |
| scATAC Chromap fragments | `atac_full` | 59.810 / 25.580 / 16.310 | 12.684x / 29.657x / 46.513x | PASS |
| Bulk ATAC source BAM | `ENCSR095QNB_ENCFF646NWY_direct` | 41.940 / 13.210 / 7.470 | 3.496x / 11.100x / 19.629x | PASS |
| Bulk ATAC Chromap BAM | `ENCSR095QNB_chromap_bam` | 32.510 / 10.840 / 6.560 | 3.781x / 11.339x / 18.738x | PASS |
| ChIP-seq + matched input | `chipseq_full` | 97.080 / 27.380 / 12.180 | 6.355x / 22.531x / 50.649x | PASS |
| CUT&RUN + matched IgG | `cutrun_full` | 9.940 / 2.990 / 2.010 | 6.513x / 21.652x / 32.209x | PASS |

Every row has one warmup and three recorded repetitions at each thread count. Each result root contains `PARITY_VERDICT.txt` and a 12-run parity manifest; every candidate narrowPeak and summits file passed full byte-for-byte `cmp` against the frozen MACS3 oracle. The full-file hashes are in the aggregate and per-row manifests.

The first generic supplied-10x attempt used the wrong historical output name (`atac_full`) and is explicitly rejected/excluded at `/storage/rapidmacs_candidate_refresh_20260822/results/scatac_10x/REJECTED.txt`. It was not used in the aggregate. The corrected row-specific rerun at `results/scatac_10x_treatment_only` used `atac_treatment_only` and passed complete parity.

## Manuscript changes

`main.tex`, `preprint.tex`, and `supplementary.tex` now report the refreshed RapidMACS medians, ranges, RSS values, speedups, and stage medians. Frozen MACS3 values and the historical 72-invocation full-matrix description are unchanged; the refresh measured candidate arms only and reused accepted MACS3 evidence. The supplementary controlled-build comparison was recomputed using the refreshed candidate medians.

## Build status

- `make check`: PASS on 2026-08-22. `main.pdf` is 4 pages and `supplementary.pdf` is 4 pages; the check found no LaTeX errors or undefined citations/references.
- `make preprint`: PASS. `preprint.pdf` is 4 pages; the merged `rapidmacs-preprint.pdf` contains the 4-page preprint plus the 4-page supplement.
- `git diff --check`: PASS. Working tree changes are intentionally uncommitted; no push was performed.
- PDF SHA256: `main.pdf` `e266100488387793af857e44b3f956deda76692f59f60bbfbbe9dacd044c3911`; `supplementary.pdf` `ecc20f1d345d6d44c5f1bd2e2ebfeff86f066e37fba8c7d6ccd03a7bcc796ce6`; `preprint.pdf` `9027641fd36f45e8e79d1fe5c6752c86829b2af19bf3a7c36312484930ffe897`; merged preprint `682a8d0221087693b842b561da77253057ca8d72a81b3dfa4e06f6bd01f1b4d5`.
