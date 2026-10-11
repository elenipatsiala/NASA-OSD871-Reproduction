# ============================================================
# 01_load_data.R
# Purpose:
# Load and validate the NASA OSD-871 normalized RNA-seq
# expression matrix used for descriptive marker reproduction.
#
# IMPORTANT:
# These are NASA-processed normalized counts.
# They are NOT raw counts for an independent DESeq2 analysis.
# ============================================================


# ----------------------------
# 1. Define input file
# ----------------------------

counts_file <-
  "01_RAW_DATA/GLDS-720_rna_seq_Normalized_Counts_GLbulkRNAseq.csv"


# ----------------------------
# 2. Confirm file exists
# ----------------------------

stopifnot(
  file.exists(counts_file)
)


# ----------------------------
# 3. Load normalized expression data
# ----------------------------

counts <- read.csv(
  counts_file,
  row.names = 1,
  check.names = FALSE
)


# ----------------------------
# 4. Basic integrity checks
# ----------------------------

stopifnot(
  nrow(counts) == 30269
)

stopifnot(
  ncol(counts) == 23
)

stopifnot(
  !anyDuplicated(rownames(counts))
)

stopifnot(
  !anyDuplicated(colnames(counts))
)

stopifnot(
  all(
    vapply(
      counts,
      is.numeric,
      logical(1)
    )
  )
)

stopifnot(
  !anyNA(counts)
)

stopifnot(
  all(
    grepl(
      "^GSM[0-9]+$",
      colnames(counts)
    )
  )
)


# ----------------------------
# 5. Final confirmation
# ----------------------------

print(dim(counts))
print(colnames(counts))
print(head(counts[, 1:3]))