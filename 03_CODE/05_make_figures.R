# ============================================================
# 05_make_figures.R
# Purpose:
# Create final figures for the OSD-871 reproduction Build
# ============================================================


# ----------------------------
# 1. Load plotting package
# ----------------------------

if (!requireNamespace("ggplot2", quietly = TRUE)) {
  stop("Package 'ggplot2' is required. Please install it first.")
}

library(ggplot2)


# ----------------------------
# 2. Check required objects
# ----------------------------

stopifnot(exists("marker_data"))
stopifnot(exists("stat_long"))

dir.create(
  "05_FIGURES",
  showWarnings = FALSE,
  recursive = TRUE
)


# ============================================================
# FIGURE 1 — TH
# ============================================================

p_th <- ggplot(
  marker_data,
  aes(x = gravity, y = TH)
) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(
    aes(shape = microglia),
    width = 0.12,
    size = 3
  ) +
  facet_wrap(~ disease) +
  labs(
    title = "TH expression: Ground vs LEO",
    subtitle = "OSD-871 dopaminergic organoids; panels represent the two donor-derived iPSC lines",
    x = "Condition",
    y = "Normalized TH expression",
    shape = "Microglia"
  ) +
  theme_minimal()

ggsave(
  "05_FIGURES/Figure1_TH_Ground_vs_LEO.png",
  plot = p_th,
  width = 7,
  height = 5,
  dpi = 300
)


# ============================================================
# FIGURE 2 — DDC
# ============================================================

p_ddc <- ggplot(
  marker_data,
  aes(x = gravity, y = DDC)
) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(
    aes(shape = microglia),
    width = 0.12,
    size = 3
  ) +
  facet_wrap(~ disease) +
  labs(
    title = "DDC expression: Ground vs LEO",
    subtitle = "OSD-871 dopaminergic organoids; panels represent the two donor-derived iPSC lines",
    x = "Condition",
    y = "Normalized DDC expression",
    shape = "Microglia"
  ) +
  theme_minimal()

ggsave(
  "05_FIGURES/Figure2_DDC_Ground_vs_LEO.png",
  plot = p_ddc,
  width = 7,
  height = 5,
  dpi = 300
)


# ============================================================
# FIGURE 3 — Progenitor / cell-cycle marker panel
# ============================================================

marker_long <- reshape(
  marker_data,
  varying = c(
    "VIM", "SOX2", "PAX6",
    "CCND1", "CDKN1A", "GADD45A"
  ),
  v.names = "expression",
  timevar = "gene",
  times = c(
    "VIM", "SOX2", "PAX6",
    "CCND1", "CDKN1A", "GADD45A"
  ),
  direction = "long"
)

marker_long$gene <- factor(
  marker_long$gene,
  levels = c(
    "VIM", "SOX2", "PAX6",
    "CCND1", "CDKN1A", "GADD45A"
  )
)

p_marker_panel <- ggplot(
  marker_long,
  aes(x = gravity, y = expression)
) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(
    aes(shape = microglia),
    width = 0.12,
    size = 1.8
  ) +
  facet_wrap(
    vars(disease, gene),
    scales = "free_y",
    ncol = 6
  ) +
  labs(
    title = "Progenitor and cell-cycle-associated markers: Ground vs LEO",
    subtitle = "Normalized expression in OSD-871 dopaminergic organoids",
    x = "Condition",
    y = "Normalized expression",
    shape = "Microglia"
  ) +
  theme_minimal()

ggsave(
  "05_FIGURES/Figure3_Progenitor_CellCycle_Markers_Ground_vs_LEO.png",
  plot = p_marker_panel,
  width = 14,
  height = 8,
  dpi = 300
)


# ============================================================
# FIGURE 4 — Statistical reproduction heatmap
# ============================================================

stat_long$SYMBOL <- factor(
  stat_long$SYMBOL,
  levels = rev(
    c(
      "TH", "DDC",
      "VIM", "SOX2", "PAX6",
      "CCND1", "CDKN1A", "GADD45A"
    )
  )
)

stat_long$Contrast <- factor(
  stat_long$Contrast,
  levels = c(
    "Control + microglia",
    "Control - microglia",
    "PD + microglia",
    "PD - microglia"
  )
)

p_heatmap <- ggplot(
  stat_long,
  aes(x = Contrast, y = SYMBOL, fill = log2FC)
) +
  geom_tile(color = "white") +
  geom_text(
    aes(label = Significance),
    size = 6
  ) +
  scale_fill_gradient2(
    low = "steelblue",
    mid = "white",
    high = "firebrick",
    midpoint = 0
  ) +
  labs(
    title = "Statistical reproduction of LEO-associated marker shifts",
    subtitle = "* = NASA-processed adjusted p < 0.05",
    x = "Matched Ground vs LEO contrast",
    y = "Gene",
    fill = "log2FC"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(
      angle = 30,
      hjust = 1
    ),
    plot.title = element_text(face = "bold"),
    panel.grid = element_blank()
  )

ggsave(
  "05_FIGURES/Figure4_Statistical_Reproduction_Heatmap.png",
  plot = p_heatmap,
  width = 10,
  height = 7,
  dpi = 300
)

ggsave(
  "05_FIGURES/Figure4_Statistical_Reproduction_Heatmap.pdf",
  plot = p_heatmap,
  width = 10,
  height = 7
)


# ----------------------------
# Final confirmation
# ----------------------------

print("All final figures created successfully.")