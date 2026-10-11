# Reproducing LEO-Associated Transcriptional Shifts in Human Dopaminergic Organoids

This project is a reproducible R-based analysis of NASA OSD-871, a public RNA-seq dataset of human iPSC-derived dopaminergic organoids cultured under Ground Control and low-Earth-orbit (LEO) spaceflight conditions.

The goal was to reproduce selected published transcriptional marker patterns associated with the LEO condition and to evaluate how consistently those patterns appeared across matched organoid conditions.

## Research Objective

The Build tested whether the published LEO-associated direction of eight predefined genes could be reproduced using NASA-processed data.

The marker panel included:

- Dopaminergic-associated markers: **TH, DDC**
- Progenitor/cell-state-associated markers: **VIM, SOX2, PAX6**
- Cell-cycle/stress-associated markers: **CCND1, CDKN1A, GADD45A**

This project is a computational reproduction exercise. It does not attempt to prove that LEO causes functional neuronal maturation or that LEO-exposed organoids are better Parkinson’s disease models.
## Key Findings

- **TH and DDC were higher in LEO than Ground** in all four matched Ground-versus-LEO contrasts.

- **VIM, SOX2, PAX6, CCND1, CDKN1A and GADD45A were lower in LEO** in all four matched contrasts.

- All eight predefined genes therefore reproduced the expected published direction across **4/4 matched contrasts**.

- Statistical support varied across genes:
  - **DDC** reached adjusted p < 0.05 in **3/4** contrasts.
  - **GADD45A** reached adjusted p < 0.05 in **2/4** contrasts.
  - **PAX6, VIM, CDKN1A and SOX2** each reached adjusted p < 0.05 in **1/4** contrasts.
  - **TH and CCND1** showed the expected direction in all four contrasts but did not reach adjusted p < 0.05 in any of them.

- The analysis therefore supports reproduction of a **marker-level LEO-associated transcriptional pattern**, but does not demonstrate functional neuronal maturation or improved Parkinson’s disease modelling.
## Dataset and Experimental Design

The project used NASA Open Science Data Repository study **OSD-871**, containing RNA-seq data from **23 human iPSC-derived dopaminergic organoid samples**.

The samples came from only **two donor-specific iPSC lines**:

- **Subject 3:** control donor, iPSC line `UEC741iPS517`
- **Subject 4:** sporadic Parkinson’s disease donor, iPSC line `HDF410iPS504`

Each donor-derived line contained:

- Ground Control and Space Flight / LEO samples
- organoids cultured with microglia
- organoids cultured without microglia
- multiple organoid-level replicate samples

An important limitation is that **disease status is fully confounded with donor and cell line**. Therefore, differences between the PD-labelled and control-labelled samples cannot be interpreted as generalizable Parkinson’s-disease effects.

The strongest comparisons in this project are therefore **within-cell-line Ground-versus-LEO comparisons**.

The 23 samples represent organoid-level replication, not 23 independent human donors.
## Data Sources and Files Used

All data used in this project came from NASA OSD-871 and its associated GeneLab processed RNA-seq outputs.

The main files used were:

- `GLDS-720_rna_seq_Normalized_Counts_GLbulkRNAseq.csv`  
  Used for descriptive marker-level expression analysis and plotting.

- `GLDS-720_rna_seq_differential_expression_GLbulkRNAseq.csv`  
  Used to extract NASA-processed log2 fold changes and adjusted p-values for the four matched Ground-versus-LEO contrasts.

- `GLDS-720_rna_seq_contrasts_GLbulkRNAseq.csv`  
  Used to identify and verify the relevant differential-expression contrasts.

- `GLDS-720_rna_seq_SampleTable_GLbulkRNAseq.csv`  
  Used for the initial sample-condition mapping.

- `s_OSD-871.txt`  
  Used to reconstruct biological metadata including donor, cell line, disease label, Ground/Space Flight condition, microglia status and replicate information.

- `a_OSD-871_transcription-profiling_rna-sequencing-(rna-seq)_Illumina.txt`  
  Used to reconstruct technical assay metadata including sequencing platform, read length, library layout, strandedness, read depth and rRNA contamination.

This project did not rerun the complete raw RNA-seq processing pipeline. The normalized expression values and differential-expression statistics were taken from NASA-processed outputs.
## Project Structure

```text
BUILD_LEO_Dopaminergic_Organoids/
│
├── README.md
├── run_all.R
│
├── 01_RAW_DATA/
│   └── GLDS-720_rna_seq_Normalized_Counts_GLbulkRNAseq.csv
│
├── 02_METADATA/
│   ├── GLDS-720_rna_seq_SampleTable_GLbulkRNAseq.csv
│   ├── GLDS-720_rna_seq_contrasts_GLbulkRNAseq.csv
│   ├── s_OSD-871.txt
│   └── a_OSD-871_transcription-profiling_rna-sequencing-(rna-seq)_Illumina.txt
│
├── 03_CODE/
│   ├── 01_load_data.R
│   ├── 02_prepare_metadata.R
│   ├── 03_marker_reproduction.R
│   ├── 04_statistical_validation.R
│   └── 05_make_figures.R
│
├── 04_RESULTS/
│   ├── Master_Sample_Audit_Table.csv
│   ├── Statistical_Reproduction_Scorecard.csv
│   ├── Statistical_Reproduction_Long_Format.csv
│   ├── Paper_vs_My_Reproduction.csv
│   └── sessionInfo.txt
│
├── 05_FIGURES/
│   ├── Figure1_TH_Ground_vs_LEO.png
│   ├── Figure2_DDC_Ground_vs_LEO.png
│   ├── Figure3_Progenitor_CellCycle_Markers_Ground_vs_LEO.png
│   ├── Figure4_Statistical_Reproduction_Heatmap.png
│   └── Figure4_Statistical_Reproduction_Heatmap.pdf
│
└── 06_WRITEUP/
    ├── technical_report.md
    └── limitations.md
## How to Reproduce the Analysis

### 1. Requirements

The analysis was developed in R and requires the `ggplot2` package.

Install it if necessary:

```r
install.packages("ggplot2")
## How to Reproduce the Analysis

### Requirements

This project was developed in R and uses the `ggplot2` package.

If needed, install it with:

`install.packages("ggplot2")`

The exact R and package versions used are recorded in:

`04_RESULTS/sessionInfo.txt`

### Required NASA files

The following NASA OSD-871 files are required to reproduce the analysis:

- `GLDS-720_rna_seq_Normalized_Counts_GLbulkRNAseq.csv`
- `GLDS-720_rna_seq_SampleTable_GLbulkRNAseq.csv`
- `GLDS-720_rna_seq_contrasts_GLbulkRNAseq.csv`
- `GLDS-720_rna_seq_differential_expression_GLbulkRNAseq.csv`
- `s_OSD-871.txt`
- `a_OSD-871_transcription-profiling_rna-sequencing-(rna-seq)_Illumina.txt`

These files should be downloaded from NASA OSD-871 and placed in the corresponding project folders.

Large NASA data files do not need to be uploaded directly to the GitHub repository.

### Run the analysis

Open the project folder:

`BUILD_LEO_Dopaminergic_Organoids`

Start a fresh R session and run:

`source("run_all.R")`

The pipeline will automatically:

1. load and validate the expression data,
2. prepare and align the metadata,
3. reproduce the selected marker patterns,
4. validate the NASA differential-expression results,
5. generate the final figures.

A successful run ends with:

`BUILD PIPELINE COMPLETED SUCCESSFULLY`

The pipeline was successfully tested from a fresh R session during development of this project.
## Limitations and Scientific Integrity

This project reproduces selected marker-level transcriptional patterns from NASA OSD-871. It does not independently reproduce the complete raw RNA-seq processing pipeline.

Key limitations include:

- The dataset contains only two donor-specific iPSC lines: one control line and one sporadic Parkinson’s disease line.
- Disease status is therefore confounded with donor and cell line, so PD-versus-Control differences cannot be interpreted as generalizable disease effects.
- The 23 samples represent organoid-level replication, not 23 independent human donors.
- Normalized NASA expression data were used for descriptive analysis, while log2 fold changes and adjusted p-values came from NASA-processed differential-expression outputs.
- Directional consistency does not necessarily imply statistical significance.
- The selected eight-gene panel does not represent the complete transcriptome-wide maturation program.
- Higher TH/DDC expression and lower progenitor-associated expression do not by themselves demonstrate functional neuronal maturation.
- Bulk RNA-seq cannot determine whether the observed signal reflects within-cell maturation, changes in cell-type composition, or broader stress/cell-cycle effects.
- Ground-versus-LEO differences should be described as LEO/spaceflight-associated. This analysis does not isolate microgravity from all other spaceflight exposures.

The main unresolved question is:

**Does the LEO-associated transcriptional maturation phenotype preserve the ventral-midbrain dopaminergic identity, cellular integrity and functional properties required for a biologically faithful Parkinson’s disease model?**
