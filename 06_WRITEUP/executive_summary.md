# Executive Summary

This project is a reproducible computational analysis of NASA OSD-871, a public RNA-seq dataset of human iPSC-derived dopaminergic organoids exposed to Ground Control or low-Earth-orbit spaceflight conditions.

The goal was to test whether selected published transcriptional marker patterns could be reproduced using NASA-processed data. I focused on two dopaminergic-associated markers, TH and DDC, and six progenitor/cell-cycle-associated markers: VIM, SOX2, PAX6, CCND1, CDKN1A and GADD45A.

Across four matched Ground-versus-LEO contrasts, all eight genes reproduced the expected published direction. TH and DDC were consistently higher in LEO, while the six progenitor/cell-cycle-associated markers were consistently lower. Statistical support varied: DDC reached adjusted significance in 3/4 contrasts, while TH showed directional consistency but did not reach adjusted significance in any subgroup contrast.

The project also identified an important design limitation: the 23 organoid samples were derived from only two donor-specific iPSC lines, meaning disease status is confounded with donor and cell line.

The analysis was organized into a reproducible R pipeline and successfully rerun from a fresh R session. The findings support reproduction of a marker-level LEO-associated transcriptional pattern, but do not demonstrate functional neuronal maturation or improved Parkinson’s disease modelling.
