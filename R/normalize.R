normalize_data <- function(df) {
  data.frame(scale(df))
}

normalize_all <- function(data_list) {
  lapply(data_list, normalize_data)
}