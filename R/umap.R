library(uwot)

run_umap <- function(df, cols = 1:5) {
  uwot::umap(df[, cols])
}

run_umap_all <- function(data_list, cols = 1:5) {
  lapply(data_list, run_umap, cols = cols)
}