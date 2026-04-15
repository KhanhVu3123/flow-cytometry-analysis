Comprehensive flow cytometry analysis pipeline with all choices of transformations / clustering
=======
# Flow Cytometry High-Dimensional Analysis Pipeline

A reproducible workflow implementing and comparing multiple methods from the literature for the analysis of high-dimensional flow cytometry data.

---

## Overview

This repository contains a comprehensive and systematic workflow for the analysis of high-dimensional flow cytometry data. The pipeline is designed to reflect established practices in the literature while allowing direct comparison across multiple methodological choices at each step.

Rather than relying on a single preprocessing or clustering strategy, this workflow intentionally implements **a broad range of methods reported in published studies**, enabling:

- Robust comparison between approaches  
- Sensitivity analysis of preprocessing choices  
- Reproducible evaluation of clustering performance  

The pipeline follows a traditional sequence:

1. Transformation  
2. Normalization  
3. Dimensionality reduction  
4. Clustering  
5. Population identification and interpretation  

---

## Rationale

Flow cytometry data presents several analytical challenges:

- Wide dynamic range of marker expression  
- Strong skewness and non-normal distributions  
- High dimensionality  
- Complex, overlapping cell populations  

Different studies have proposed different solutions to these problems. However, there is no universal consensus on a single best approach.

This workflow addresses that by **systematically applying multiple methods at each stage**, rather than committing to one.

---

## Pipeline Description

### 1. Transformation

Raw flow cytometry data (even after compensation) is typically:

- Highly skewed  
- Heteroscedastic  
- Not normally distributed  

Transformation aims to:

- Stabilize variance  
- Improve symmetry of distributions  
- Enhance separation between populations  

#### Methods implemented

This workflow includes transformation approaches commonly used in the literature:

- **Arcsinh transformation**
  - Cofactor = 1 (data-driven exploration)
  - Cofactor = 150 (widely used benchmark standard)

- **Biexponential transformation**
  - Standard in flow cytometry software

- **flowTrans methods (maximum likelihood-based)**
  - Multivariate arcsinh  
  - Box-Cox  
  - Lin-log  

These methods are applied independently, producing multiple transformed datasets for downstream comparison.

---

### 2. Normalization

Normalization (z-score scaling) is applied optionally.

Purpose:

- Center each marker around zero  
- Standardize variance across markers  
- Prevent features with large scales from dominating clustering  

Not all studies recommend normalization, so this workflow evaluates both:

- Transformed-only data  
- Transformed + normalized data  

---

### 3. Dimensionality Reduction (UMAP)

High-dimensional cytometry data is difficult to interpret directly.

UMAP (Uniform Manifold Approximation and Projection) is used to:

- Project data into 2D space  
- Preserve local and global structure  
- Visualize emerging clusters  

UMAP is used here primarily for:

- Qualitative assessment of clustering structure  
- Comparing how transformation methods affect separability  

---

### 4. Clustering

Identifying cell populations is the central goal of the analysis.

A wide range of clustering algorithms from the literature are implemented, reflecting different methodological philosophies:

#### A. Methods requiring predefined cluster number

- FlowSOM  
- K-means  
- PAC  

These methods require specifying the number of clusters (e.g., K = 10).

---

#### B. Graph-based / automated methods

- PhenoGraph  

Automatically determines cluster structure using nearest-neighbor graphs.

---

#### C. Density and spectral methods

- SamSPECTRAL  
- DensityCut  
- ClusterX  

These methods attempt to detect clusters based on density structure in the data.

---

#### D. Additional approaches

- Rclusterpp (hierarchical clustering)  
- DepecheR  
- flowPeaks  
- flowMeans  

---

### Key Design Principle

All clustering methods are applied to:

- Every transformation  
- With and without normalization  

This allows direct comparison across:

- Transformation choices  
- Scaling strategies  
- Clustering algorithms  

---

### 5. Population Identification by heat maps

- Median marker expression per cluster  
- Enables biological interpretation of clusters  

These labels serve as a reference for:

- Evaluating clustering quality  
- Comparing automated methods with traditional gating  

---


## How to Run

From the project root:

```r
source("scripts/run_pipeline.R")
