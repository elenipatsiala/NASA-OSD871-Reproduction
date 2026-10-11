# ============================================================
# run_all.R
# Reproduce the complete OSD-871 Build analysis
# ============================================================

rm(list = ls())

message("1/5 Loading expression data...")
source("03_CODE/01_load_data.R")

message("2/5 Preparing metadata...")
source("03_CODE/02_prepare_metadata.R")

message("3/5 Reproducing marker patterns...")
source("03_CODE/03_marker_reproduction.R")

message("4/5 Validating NASA DGE statistics...")
source("03_CODE/04_statistical_validation.R")

message("5/5 Creating final figures...")
source("03_CODE/05_make_figures.R")

message("BUILD PIPELINE COMPLETED SUCCESSFULLY")