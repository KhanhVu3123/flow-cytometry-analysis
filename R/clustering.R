cluster_all_methods <- function(df) {
  df_out <- df
  
  # FlowSOM
  fs <- FlowSOM::FlowSOM(as.matrix(df))
  df_out$flowsom <- fs$metaclustering[fs$map$mapping[,1]]
  
  # K-means
  df_out$kmeans <- kmeans(df[,1:5], centers = 10)$cluster
  
  # PAC
  df_out$pacman <- PAC(df[,1:5], K = 10)
  
  # PhenoGraph
  pg <- Rphenograph(df[,1:5])
  df_out$phenograph <- factor(membership(pg[[2]]))
  
  # SamSPECTRAL
  df_out$samspectral <- SamSPECTRAL(
    as.matrix(df[,1:5]),
    normal.sigma = 200,
    separation.factor = 0.39
  )
  
  return(df_out)
}

cluster_all <- function(data_list) {
  lapply(data_list, cluster_all_methods)
}