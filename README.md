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
NASA-OSD871-Reproduction/
│
├── README.md
├── run_all.R
│
├── 01_RAW_DATA/
│   └── README.md
│
├── 02_METADATA/
│   └── README.md
│
├── 03_CODE/
│   ├── README.md
│   ├── 01_load_data.R
│   ├── 02_prepare_metadata.R
│   ├── 03_marker_reproduction.R
│   ├── 04_statistical_validation.R
│   └── 05_make_figures.R
│
├── 04_RESULTS/
│   ├── README.md
│   ├── Master_Sample_Audit_Table.csv
│   ├── Statistical_Reproduction_Scorecard.csv
│   ├── Statistical_Reproduction_Long_Format.csv
│   ├── Paper_vs_My_Reproduction.csv
│   └── sessionInfo.txt
│
├── 05_FIGURES/
│   ├── README.md
│   ├── Figure1_TH_Ground_vs_LEO.png
│   ├── Figure2_DDC_Ground_vs_LEO.png
│   ├── Figure3_Progenitor_CellCycle_Markers_Ground_vs_LEO.png
│   ├── Figure4_Statistical_Reproduction_Heatmap.png
│   └── Figure4_Statistical_Reproduction_Heatmap.pdf
│
├── 06_WRITEUP/
│   ├── README.md
│   ├── technical_report.md
│   ├── limitations.md
│   └── executive_summary.md
│
└── 07_EXPERT_FEEDBACK/
    ├── README.md
    └── expert_outreach.md
## Sources

- NASA Open Science Data Repository — OSD-871  
  https://osdr.nasa.gov/bio/repo/data/studies/OSD-871

- Primary study: neural / dopaminergic organoids cultured in low-Earth orbit  
  [Primary paper link / DOI]

- DESeq2 documentation  
  https://bioconductor.org/packages/release/bioc/html/DESeq2.html
