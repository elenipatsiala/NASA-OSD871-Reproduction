# ============================================================
# 03_marker_reproduction.R
# Purpose:
# Reproduce selected LEO-associated marker directions
# using NASA OSD-871 normalized expression data
#
# IMPORTANT:
# These are NASA processed normalized counts.
# This script is descriptive marker reproduction,
# NOT an independent DESeq2 differential-expression analysis.
# ============================================================


# ----------------------------
# 1. Align metadata to expression samples
# ----------------------------

stopifnot(
  setequal(
    colnames(counts),
    master_audit$sample_id
  )
)

meta_aligned <- master_audit[
  match(colnames(counts), master_audit$sample_id),
]

stopifnot(
  identical(
    colnames(counts),
    meta_aligned$sample_id
  )
)


# ----------------------------
# 2. Create simplified condition labels
# ----------------------------

meta_aligned$gravity_short <- ifelse(
  meta_aligned$gravity == "Space Flight",
  "LEO",
  "Ground"
)

meta_aligned$disease_short <- ifelse(
  grepl("Parkinson", meta_aligned$disease),
  "PD",
  "Control"
)

meta_aligned$microglia_short <- ifelse(
  grepl("^with microglia$", trimws(meta_aligned$microglia)),
  "With",
  "Without"
)


# ----------------------------
# 3. Define predefined marker panel
# ----------------------------

marker_ids <- c(
  TH      = "ENSG00000180176",
  DDC     = "ENSG00000132437",
  VIM     = "ENSG00000026025",
  SOX2    = "ENSG00000181449",
  PAX6    = "ENSG00000007372",
  CCND1   = "ENSG00000110092",
  CDKN1A  = "ENSG00000124762",
  GADD45A = "ENSG00000116717"
)


# ----------------------------
# 4. Confirm every marker exists
# ----------------------------

marker_check <- data.frame(
  gene = names(marker_ids),
  ensembl_id = unname(marker_ids),
  present = unname(marker_ids %in% rownames(counts))
)

print(marker_check)

stopifnot(all(marker_check$present))


# ----------------------------
# 5. Extract marker expression
# ----------------------------

marker_expr <- as.data.frame(
  t(counts[unname(marker_ids), , drop = FALSE])
)

colnames(marker_expr) <- names(marker_ids)


# ----------------------------
# 6. Combine expression with metadata
# ----------------------------

marker_data <- data.frame(
  sample_id = colnames(counts),
  gravity = meta_aligned$gravity_short,
  disease = meta_aligned$disease_short,
  microglia = meta_aligned$microglia_short,
  marker_expr,
  row.names = NULL
)


# ----------------------------
# 7. Overall Ground vs LEO means
# ----------------------------

overall_marker_summary <- aggregate(
  cbind(
    TH, DDC, VIM, SOX2,
    PAX6, CCND1, CDKN1A, GADD45A
  ) ~ gravity,
  data = marker_data,
  FUN = mean
)

print(overall_marker_summary)


# ----------------------------
# 8. Ground vs LEO within disease group
# ----------------------------

disease_marker_summary <- aggregate(
  cbind(
    TH, DDC, VIM, SOX2,
    PAX6, CCND1, CDKN1A, GADD45A
  ) ~ gravity + disease,
  data = marker_data,
  FUN = mean
)

print(disease_marker_summary)


# ----------------------------
# 9. Ground vs LEO within microglia condition
# ----------------------------

microglia_marker_summary <- aggregate(
  cbind(
    TH, DDC, VIM, SOX2,
    PAX6, CCND1, CDKN1A, GADD45A
  ) ~ gravity + microglia,
  data = marker_data,
  FUN = mean
)

print(microglia_marker_summary)


# ----------------------------
# 10. Save reproducible outputs
# ----------------------------

write.csv(
  marker_data,
  "04_RESULTS/Marker_Expression_Sample_Level.csv",
  row.names = FALSE
)

write.csv(
  overall_marker_summary,
  "04_RESULTS/Marker_Summary_Overall.csv",
  row.names = FALSE
)

write.csv(
  disease_marker_summary,
  "04_RESULTS/Marker_Summary_By_CellLine_Disease_Label.csv",
  row.names = FALSE
)

write.csv(
  microglia_marker_summary,
  "04_RESULTS/Marker_Summary_By_Microglia.csv",
  row.names = FALSE
)


# ----------------------------
# 11. Final confirmation
# ----------------------------

print(dim(marker_data))
print(head(marker_data))