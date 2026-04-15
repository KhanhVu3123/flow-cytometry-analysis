library(pheatmap)
library(dplyr)

make_heatmap <- function(df, cluster_col, out_path) {
  
  marker_cols <- names(df)[sapply(df, is.numeric)]
  marker_cols <- setdiff(marker_cols, cluster_col)
  
  med_df <- df %>%
    group_by(.data[[cluster_col]]) %>%
    summarise(across(all_of(marker_cols), median), .groups = "drop")
  
  rownames(med_df) <- med_df[[cluster_col]]
  med_df <- med_df[, -1]
  
  png(out_path, width = 800, height = 600)
  pheatmap(med_df, scale = "column")
  dev.off()
}