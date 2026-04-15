############################################################
# Main pipeline script
############################################################

source("../R/transform.R")
source("../R/normalize.R")
source("../R/umap.R")
source("../R/clustering.R")
source("../R/visualization.R")

library(flowCore)

# Load data
flow_data <- read.csv("../data/raw/flow_data.csv")

# 1. Transform
transformed <- run_transformations(flow_data)

# 2. Normalize
normalized <- normalize_all(transformed)

# 3. UMAP
umap_results <- run_umap_all(transformed)

# 4. Clustering
clustered <- cluster_all(transformed)

# 5. Heatmap example
make_heatmap(
  clustered$flowTrans_arcsinh,
  "flowsom",
  "../results/heatmaps/flowsom.png"
)
