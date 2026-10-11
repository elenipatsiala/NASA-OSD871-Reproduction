# Reproducing LEO-Associated Transcriptional Shifts in Human Dopaminergic Organoids Using NASA OSD-871 Data

## 1. Objective

This Build aimed to reproduce selected transcriptional findings from NASA OSD-871, a dataset of human iPSC-derived dopaminergic organoids exposed to Ground Control or low-Earth-orbit (LEO) spaceflight conditions.

I tested whether the published direction of eight predefined markers could be reproduced: the dopaminergic markers TH and DDC, together with VIM, SOX2, PAX6, CCND1, CDKN1A and GADD45A. The Build was designed as a reproducibility exercise, not as a new mechanistic study.

## 2. Dataset

The analysis used 23 dopaminergic-organoid RNA-seq samples from NASA OSD-871. The samples originated from two donor-specific iPSC lines: one control donor/cell line and one sporadic Parkinson’s disease donor/cell line, each represented under Ground and Space Flight conditions with or without microglia.

Because disease status is fully confounded with donor and cell line, PD-versus-Control differences cannot be generalized as disease effects. The most defensible comparisons are therefore within-cell-line Ground-versus-LEO comparisons.

NASA-processed normalized expression values were used for descriptive marker analysis, while NASA-processed differential-expression outputs provided log2 fold changes and adjusted p-values. The complete raw RNA-seq and DESeq2 pipeline was not independently rerun.
## 3. Methods

The Build was implemented in R using relative project paths and five analysis scripts executed through a master `run_all.R` file.

NASA-processed normalized RNA-seq data were loaded and checked for expected dimensions, duplicate identifiers, missing values and sample consistency. Biological and technical metadata were reconstructed from the OSD-871 ISA files and aligned to the 23 expression samples. Metadata included donor/cell line, disease label, Ground/Space Flight condition, microglia status, replicate label, read depth and rRNA contamination.

A predefined eight-gene panel was then analysed: TH, DDC, VIM, SOX2, PAX6, CCND1, CDKN1A and GADD45A. Normalized expression values were used for descriptive Ground-versus-LEO comparisons overall and within donor/cell-line and microglia groups.

Statistical validation used NASA-processed differential-expression outputs. Four matched Ground-versus-LEO contrasts were examined, stratified by donor/cell-line label and microglia condition. For each gene, log2 fold change and adjusted p-value were extracted, with adjusted p < 0.05 used as the significance threshold.

Finally, figures and reproduction scorecards were generated automatically. The complete Build pipeline was successfully rerun from a fresh R session using `source("run_all.R")`.
## 4. Results

The selected marker panel reproduced the published direction of the LEO-associated transcriptional pattern.

Across all samples, mean TH expression was higher in LEO than Ground (5,976.6 vs 4,350.5), and DDC was also higher in LEO (2,523.2 vs 1,530.6). In contrast, all six progenitor/cell-cycle-associated markers were lower in LEO: VIM, SOX2, PAX6, CCND1, CDKN1A and GADD45A.

This directional pattern was retained when the two donor-derived cell lines were examined separately and when samples were stratified by microglia condition.

NASA-processed differential-expression outputs were then examined across four matched Ground-versus-LEO contrasts. All eight target genes matched the expected direction in all four contrasts: TH and DDC showed positive log2 fold changes, while the six progenitor/cell-cycle-associated markers showed negative log2 fold changes.

Statistical support varied across genes. DDC reached adjusted p < 0.05 in 3/4 contrasts, GADD45A in 2/4, and PAX6, VIM, CDKN1A and SOX2 in 1/4 each. TH and CCND1 matched the expected direction in all four contrasts but did not reach adjusted p < 0.05 in any of them.
## 5. Interpretation

The Build reproduced the published direction of the selected LEO-associated marker pattern. TH and DDC shifted upward in LEO, while VIM, SOX2, PAX6, CCND1, CDKN1A and GADD45A shifted downward across all four matched contrasts.

This supports reproduction of a marker-level transcriptional pattern, but not proof of a complete maturation program. Statistical support was uneven across genes, and transcriptional changes alone do not establish mature electrophysiology, synaptic function, dopamine release or preserved ventral-midbrain dopaminergic fidelity.

The experimental-design audit also showed that disease status is confounded with donor and cell line. Therefore, the strongest interpretation is a within-cell-line reproduction of LEO-associated transcriptional shifts rather than a generalizable PD-versus-Control comparison.
## 6. Limitations and unresolved question

The main limitations are the use of only two donor-specific iPSC lines, the confounding of disease status with donor/cell line, small subgroup sample sizes, and reliance on NASA-processed expression and DGE outputs rather than an independently rerun raw RNA-seq pipeline.

Biologically, the observed transcriptional pattern could reflect at least three competing explanations: a genuine shift in neuronal maturation state, a change in cellular composition, or a stress/cell-cycle-related response. Bulk RNA-seq cannot distinguish these possibilities.

The central unresolved question is:

**Does the LEO-associated transcriptional maturation phenotype preserve the ventral-midbrain dopaminergic identity, cellular integrity and functional properties required for a biologically faithful Parkinson’s disease model?**

Answering this would require cell-type-resolved, protein-level and functional validation.

## 7. What I learned and next step

This Build taught me that reproducibility requires more than reproducing the direction of a published result. It requires validating sample identity, understanding experimental design, separating descriptive patterns from statistical evidence, tracking data provenance, and testing whether the analysis can rerun from a fresh environment.

The main scientific lesson was that maturation-associated transcription is not equivalent to functional or biological fidelity.

The next Iterate stage should therefore test whether the reproduced transcriptional phenotype is accompanied by preserved dopaminergic identity and low dysregulation using broader transcriptomic, cell-type-specific and functional evidence.
