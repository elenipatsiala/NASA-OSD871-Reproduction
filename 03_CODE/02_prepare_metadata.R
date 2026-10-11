# ============================================================
# 02_prepare_metadata.R
# Purpose:
# Prepare and audit biological + technical metadata for OSD-871
# ============================================================


# ----------------------------
# 1. Load ISA sample metadata
# ----------------------------

isa <- read.delim(
  "02_METADATA/s_OSD-871.txt",
  check.names = FALSE,
  quote = "",
  stringsAsFactors = FALSE
)


# ----------------------------
# 2. Create biological audit table
# ----------------------------

audit_table <- data.frame(
  sample_id = isa$`Sample Name`,
  subject = isa$`Characteristics[Subject ID]`,
  cell_line = isa$`Characteristics[cell line]`,
  disease = isa$`Factor Value[Donor Medical History]`,
  gravity = isa$`Factor Value[Spaceflight]`,
  microglia = isa$`Factor Value[Co-culture]`,
  sample_info = isa$`Comment[Sample Info]`,
  stringsAsFactors = FALSE
)


# ----------------------------
# 3. Extract replicate number
# ----------------------------

audit_table$replicate <- sub(
  ".*(Ground|LEO)([0-9]+)$",
  "\\2",
  trimws(audit_table$sample_info)
)


# ----------------------------
# 4. Load assay / sequencing metadata
# ----------------------------

assay <- read.delim(
  "02_METADATA/a_OSD-871_transcription-profiling_rna-sequencing-(rna-seq)_Illumina.txt",
  check.names = FALSE,
  quote = "",
  stringsAsFactors = FALSE
)


# ----------------------------
# 5. Keep relevant technical fields
# ----------------------------

assay_tech <- assay[, c(
  "Sample Name",
  "Parameter Value[Library Layout]",
  "Parameter Value[Stranded]",
  "Parameter Value[Sequencing Instrument]",
  "Parameter Value[Read Length]",
  "Parameter Value[Read Depth]",
  "Parameter Value[rRNA Contamination]"
)]


# ----------------------------
# 6. Integrity checks
# ----------------------------

stopifnot(nrow(audit_table) == 23)

stopifnot(
  setequal(
    audit_table$sample_id,
    assay_tech$`Sample Name`
  )
)

stopifnot(
  !anyDuplicated(audit_table$sample_id)
)

stopifnot(
  !any(is.na(audit_table$sample_id))
)


# ----------------------------
# 7. Align assay metadata to biological metadata
# ----------------------------

tech_aligned <- assay_tech[
  match(
    audit_table$sample_id,
    assay_tech$`Sample Name`
  ),
]


stopifnot(
  identical(
    audit_table$sample_id,
    tech_aligned$`Sample Name`
  )
)


# ----------------------------
# 8. Build master audit table
# ----------------------------

master_audit <- data.frame(
  audit_table,
  
  library_layout =
    tech_aligned$`Parameter Value[Library Layout]`,
  
  stranded =
    tech_aligned$`Parameter Value[Stranded]`,
  
  sequencing_instrument =
    tech_aligned$`Parameter Value[Sequencing Instrument]`,
  
  read_length =
    tech_aligned$`Parameter Value[Read Length]`,
  
  read_depth =
    tech_aligned$`Parameter Value[Read Depth]`,
  
  rrna_contamination =
    tech_aligned$`Parameter Value[rRNA Contamination]`
)


# ----------------------------
# 9. Save clean metadata output
# ----------------------------

write.csv(
  master_audit,
  "04_RESULTS/Master_Sample_Audit_Table.csv",
  row.names = FALSE
)


# ----------------------------
# 10. Final confirmation
# ----------------------------

print(dim(master_audit))
print(head(master_audit))