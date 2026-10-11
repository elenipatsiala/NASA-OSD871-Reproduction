# ============================================================
# 04_statistical_validation.R
# Purpose:
# Validate selected marker directions using
# NASA-processed differential expression outputs
#
# IMPORTANT:
# These statistics come from NASA-processed DGE outputs.
# This is NOT an independent DESeq2 analysis.
# ============================================================


# ----------------------------
# 1. Load NASA processed DGE file
# ----------------------------

dge <- read.csv(
  "04_RESULTS/GLDS-720_rna_seq_differential_expression_GLbulkRNAseq.csv",
  check.names = FALSE
)


# ----------------------------
# 2. Define target genes
# ----------------------------

target_genes <- c(
  "TH", "DDC",
  "VIM", "SOX2", "PAX6",
  "CCND1", "CDKN1A", "GADD45A"
)


# ----------------------------
# 3. Confirm target genes exist
# ----------------------------

dge_targets <- dge[
  dge$SYMBOL %in% target_genes,
  c("ENSEMBL", "SYMBOL")
]

print(dge_targets)

stopifnot(
  all(target_genes %in% dge_targets$SYMBOL)
)


# ----------------------------
# 4. Define the four matched contrasts
# ----------------------------

# PD + microglia
pd_with_microglia <- dge[
  dge$SYMBOL %in% target_genes,
  c(
    "SYMBOL",
    colnames(dge)[147],
    colnames(dge)[150]
  )
]

# PD - microglia
pd_without_microglia <- dge[
  dge$SYMBOL %in% target_genes,
  c(
    "SYMBOL",
    colnames(dge)[175],
    colnames(dge)[178]
  )
]

# Control + microglia
control_with_microglia <- dge[
  dge$SYMBOL %in% target_genes,
  c(
    "SYMBOL",
    colnames(dge)[235],
    colnames(dge)[238]
  )
]

# Control - microglia
control_without_microglia <- dge[
  dge$SYMBOL %in% target_genes,
  c(
    "SYMBOL",
    colnames(dge)[247],
    colnames(dge)[250]
  )
]


# ----------------------------
# 5. Build statistical scorecard
# ----------------------------

scorecard <- data.frame(
  SYMBOL = pd_with_microglia$SYMBOL,
  
  PD_with_microglia_log2FC =
    pd_with_microglia[[2]],
  
  PD_with_microglia_padj =
    pd_with_microglia[[3]],
  
  PD_without_microglia_log2FC =
    pd_without_microglia[[2]],
  
  PD_without_microglia_padj =
    pd_without_microglia[[3]],
  
  Control_with_microglia_log2FC =
    control_with_microglia[[2]],
  
  Control_with_microglia_padj =
    control_with_microglia[[3]],
  
  Control_without_microglia_log2FC =
    control_without_microglia[[2]],
  
  Control_without_microglia_padj =
    control_without_microglia[[3]]
)


# ----------------------------
# 6. Define expected direction
# ----------------------------

scorecard$Expected_direction <- ifelse(
  scorecard$SYMBOL %in% c("TH", "DDC"),
  "Up in LEO",
  "Down in LEO"
)


# ----------------------------
# 7. Count directional matches
# ----------------------------

scorecard$Direction_matches <- rowSums(cbind(
  
  ifelse(
    scorecard$SYMBOL %in% c("TH", "DDC"),
    scorecard$PD_with_microglia_log2FC > 0,
    scorecard$PD_with_microglia_log2FC < 0
  ),
  
  ifelse(
    scorecard$SYMBOL %in% c("TH", "DDC"),
    scorecard$PD_without_microglia_log2FC > 0,
    scorecard$PD_without_microglia_log2FC < 0
  ),
  
  ifelse(
    scorecard$SYMBOL %in% c("TH", "DDC"),
    scorecard$Control_with_microglia_log2FC > 0,
    scorecard$Control_with_microglia_log2FC < 0
  ),
  
  ifelse(
    scorecard$SYMBOL %in% c("TH", "DDC"),
    scorecard$Control_without_microglia_log2FC > 0,
    scorecard$Control_without_microglia_log2FC < 0
  )
))


# ----------------------------
# 8. Count statistically significant contrasts
# ----------------------------

scorecard$Significant_contrasts <- rowSums(cbind(
  scorecard$PD_with_microglia_padj < 0.05,
  scorecard$PD_without_microglia_padj < 0.05,
  scorecard$Control_with_microglia_padj < 0.05,
  scorecard$Control_without_microglia_padj < 0.05
))


# ----------------------------
# 9. Save full scorecard
# ----------------------------

write.csv(
  scorecard,
  "04_RESULTS/Statistical_Reproduction_Scorecard.csv",
  row.names = FALSE
)


# ----------------------------
# 10. Create long-format statistical table
# ----------------------------

stat_long <- rbind(
  
  data.frame(
    SYMBOL = scorecard$SYMBOL,
    Contrast = "PD + microglia",
    log2FC = scorecard$PD_with_microglia_log2FC,
    padj = scorecard$PD_with_microglia_padj
  ),
  
  data.frame(
    SYMBOL = scorecard$SYMBOL,
    Contrast = "PD - microglia",
    log2FC = scorecard$PD_without_microglia_log2FC,
    padj = scorecard$PD_without_microglia_padj
  ),
  
  data.frame(
    SYMBOL = scorecard$SYMBOL,
    Contrast = "Control + microglia",
    log2FC = scorecard$Control_with_microglia_log2FC,
    padj = scorecard$Control_with_microglia_padj
  ),
  
  data.frame(
    SYMBOL = scorecard$SYMBOL,
    Contrast = "Control - microglia",
    log2FC = scorecard$Control_without_microglia_log2FC,
    padj = scorecard$Control_without_microglia_padj
  )
)


# ----------------------------
# 11. Add significance label
# ----------------------------

stat_long$Significance <- ifelse(
  stat_long$padj < 0.05,
  "*",
  ""
)


# ----------------------------
# 12. Save long-format statistics
# ----------------------------

write.csv(
  stat_long,
  "04_RESULTS/Statistical_Reproduction_Long_Format.csv",
  row.names = FALSE
)


# ----------------------------
# 13. Print compact summary
# ----------------------------

print(
  scorecard[, c(
    "SYMBOL",
    "Expected_direction",
    "Direction_matches",
    "Significant_contrasts"
  )]
)