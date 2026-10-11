# Metadata Files

The NASA metadata files required for this project are not stored in this GitHub repository.

Download the following files from NASA OSD-871 / GeneLab:

- `GLDS-720_rna_seq_SampleTable_GLbulkRNAseq.csv`
- `GLDS-720_rna_seq_contrasts_GLbulkRNAseq.csv`
- `s_OSD-871.txt`
- `a_OSD-871_transcription-profiling_rna-sequencing-(rna-seq)_Illumina.txt`

Place all four files directly inside:

`02_METADATA/`

These files are used to reconstruct and audit:

- sample identity,
- donor and iPSC cell line,
- Ground versus Space Flight condition,
- microglia co-culture status,
- organoid replicate labels,
- sequencing platform,
- read length,
- read depth,
- and rRNA contamination.

The NASA differential-expression file used for statistical validation should be downloaded separately and placed in:

`04_RESULTS/GLDS-720_rna_seq_differential_expression_GLbulkRNAseq.csv`
