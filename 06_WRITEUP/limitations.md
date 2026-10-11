# Limitations

## 1. Study design limitations

- The OSD-871 dopaminergic-organoid dataset contains 23 organoid samples derived from only two donor-specific iPSC lines: one control donor/cell line and one sporadic Parkinson’s disease donor/cell line.

- Because disease status is fully confounded with donor and cell line, differences between the PD-labelled and control-labelled samples cannot be interpreted as generalizable Parkinson’s-disease effects.

- The Ground-versus-LEO comparisons are therefore most defensible as within-cell-line comparisons rather than as evidence for disease-specific responses.

- The multiple organoid samples within each condition are organoid-level replicates derived from the same donor-specific cell line, not independent human donors. This limits biological generalizability.

- The study design does not isolate microgravity from all other spaceflight-associated exposures. Therefore, observed Ground-versus-LEO differences should be described as LEO/spaceflight-associated rather than automatically attributed to microgravity alone.
## 2. Statistical limitations

- The statistical results used in this Build were taken from NASA-processed differential-expression outputs. I did not independently rerun the full raw-count differential-expression pipeline.

- The normalized expression values were used for descriptive visualization and marker-level comparisons only. They were not used as input for an independent DESeq2 analysis.

- Subgroup sample sizes were small, ranging from 2 to 4 organoid samples per matched condition. Therefore, lack of statistical significance should not automatically be interpreted as absence of a biological effect.

- Directional consistency and statistical significance were treated separately. For example, TH showed a positive LEO-associated log2 fold change in all four matched contrasts, but did not reach adjusted p < 0.05 in any of them.

- DDC showed the most consistent statistical support among the selected dopaminergic markers, reaching adjusted p < 0.05 in three of four matched contrasts.

- Comparisons of the number of significant genes between microglia-positive and microglia-negative groups should not be interpreted as evidence that microglia modify the LEO effect. A formal interaction model would be required for that claim.

- Likewise, differences in effect size or significance between the PD-labelled and control-labelled cell lines cannot be interpreted as disease-specific interaction effects because disease status is confounded with donor and cell line.

- Multiple-testing correction was already incorporated in the NASA-processed adjusted p-values used here, and significance was defined as adjusted p < 0.05.
## 3. Biological limitations

- Increased expression of maturation-associated markers does not by itself demonstrate functional neuronal maturation.

- TH and DDC are relevant to dopaminergic identity and dopamine synthesis, but higher transcript abundance does not establish mature electrophysiology, synaptic activity, dopamine release, or adult-like neuronal function.

- Likewise, lower expression of progenitor-associated markers such as VIM, SOX2 and PAX6 is consistent with a shift away from a progenitor-like state, but does not prove that cells have reached the biologically faithful ventral-midbrain dopaminergic state required for Parkinson’s disease modelling.

- The selected marker panel captures only a small part of the organoid transcriptional state. This reproduction therefore cannot establish whole-transcriptome maturation or exclude broader dysregulation.

- Changes in marker expression could reflect several competing biological explanations, including a change in neuronal state, a change in cellular composition, or stress/cell-cycle-related responses.

- Because this analysis is based on bulk RNA-seq, a change in expression may reflect changes in the proportion of different cell types rather than a within-cell maturation effect.

- Transcript abundance does not necessarily correspond to protein abundance. Protein-level measurements would be required to determine whether the transcriptional changes are translated into corresponding molecular changes.

- Functional validation would additionally require evidence such as electrophysiological activity, synaptic function, dopamine-related function or release, morphology/viability, and molecular confirmation of ventral-midbrain dopaminergic identity.

- Therefore, the results reproduced here support an LEO-associated transcriptional shift that is compatible with aspects of maturation, but they do not demonstrate that the organoids became functionally mature, more biologically faithful, or better Parkinson’s disease models.
## 4. Technical limitations

- This Build used NASA-processed normalized expression data for descriptive marker analysis and NASA-processed differential-expression outputs for log2 fold changes and adjusted p-values.

- The complete raw RNA-seq processing pipeline, including read trimming, alignment, count generation and independent differential-expression modelling, was not rerun in this Build.

- The predefined eight-gene marker panel was selected based on the published study and the biological question of interest. It therefore does not provide an unbiased transcriptome-wide test of maturation.

- The assay metadata showed consistent sequencing platform, read length, paired-end layout and strandedness across samples; however, library selection and library kit information were listed as unavailable.

- Read depth and rRNA contamination varied between samples. These technical differences were not uniformly associated with Ground or LEO across all subgroups, but they remain potential sources of variation.

- The PD donor/cell line showed somewhat larger Ground-versus-LEO differences in read depth and rRNA contamination than the control donor/cell line in some subgroups, which should be considered when interpreting within-line expression differences.

- Bulk RNA-seq does not resolve individual cell types. Therefore, observed expression shifts cannot distinguish within-cell transcriptional changes from shifts in cell-type composition.

- The reproducible pipeline developed here reproduces the Build analysis from a fresh R session using relative project paths, but it depends on the availability and structure of the NASA OSD-871 processed files used in the project.
## 5. What remains unresolved

The reproduced transcriptional pattern is compatible with several biological explanations that cannot be distinguished using the current bulk RNA-seq analysis alone.

### Competing explanation 1 — Change in neuronal state

LEO-associated conditions may have shifted cells away from a progenitor-like state and toward a more mature neuronal transcriptional state.

Evidence that would strengthen this explanation would include:
- broader maturation-associated transcriptional programs,
- protein-level confirmation of dopaminergic markers,
- mature neuronal morphology,
- electrophysiological activity,
- synaptic function,
- and dopamine-related functional measurements.

### Competing explanation 2 — Change in cellular composition

The apparent maturation-associated signal could partly reflect changes in the relative proportions of progenitor-like, neuronal, glial or other cell populations within the organoids rather than maturation within individual cells.

Data that could distinguish this explanation would include:
- single-cell or single-nucleus RNA sequencing,
- cell-type deconvolution,
- immunostaining for major cell populations,
- or quantitative cell-composition measurements.

### Competing explanation 3 — Stress or cell-cycle-related response

The decrease in several progenitor/cell-cycle-associated genes could reflect altered proliferation, stress responses or broader transcriptional dysregulation rather than a clean transition toward biologically faithful dopaminergic maturation.

Data that would help distinguish this explanation would include:
- stress-response markers,
- mitochondrial/metabolic readouts,
- viability measurements,
- apoptosis markers,
- cell-cycle profiling,
- and broader transcriptome-wide pathway analysis.

### Central unresolved question

The key unresolved question is not simply whether LEO-associated conditions increase maturation-associated gene expression.

The central question is:

**Does the LEO-associated transcriptional maturation phenotype preserve the ventral-midbrain dopaminergic identity, cellular integrity and functional properties required for a biologically faithful Parkinson’s disease model?**

This question defines the transition from the Build stage to the Iterate stage.