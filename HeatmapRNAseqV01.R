# Load necessary libraries
library(readr)
library(reshape2)
library(pheatmap)
library(RColorBrewer)
library(viridis)
library(edgeR)

# You may need to set the working directory first
# setwd("~/RProjects/BINF6310NEU/")

# Define a function to prepare the data
PrepareData <- function(filename, libpath) {
  
  # Read dataset
  dataset <- read_csv(filename)
  
  # Rename the first column to "Genes"
  names(dataset)[1] <- "Genes"
  
  # Load gene symbol mapping information
  entrez.cja <- readRDS(libpath)
  
  # Match gene IDs in dataset with gene IDs in entrez.cja and replace them with corresponding symbols
  idx <- match(dataset$Genes, entrez.cja$gene_id)
  dataset$Genes <- entrez.cja$symbol[idx]
  
  return(dataset) 
}

# Specify the path for the gene symbol mapping information
libpath <- "data/entrez.rds"

# Prepare the normalized and non-normalized datasets
dataset.norm <- PrepareData("data/cjaponica_data_normalized.csv", libpath)
dataset.nonorm <- PrepareData("data/cjaponica_data.csv", libpath)

# Set seed for reproducibility
set.seed(123)

# Create two heatmaps without clustering using the prepared dataset
# Heatmap without row and column clustering
pheatmap(dataset.norm[,-1], color = viridis(5), cluster_rows = FALSE, cluster_cols = FALSE, fontsize_number = 1, border_color=NA)

# Heatmap with row and column clustering
pheatmap(dataset.norm[,-1], color = viridis(5), cluster_rows = TRUE, cluster_cols = TRUE, fontsize_number = 1, border_color=NA)

# Differential gene expression analysis
# Define sample conditions and create a DESeq dataset object
colData <- DataFrame(condition = factor(rep(c("Control", "Medium", "High"), each = 5)))
dds <- DESeqDataSetFromMatrix(countData = round(dataset.nonorm[,-1],0), colData = colData, design = ~ condition)

# Run DESeq2 analysis
dds <- DESeq(dds)
res <- results(dds)

# Get the 30 genes with smallest p-values
top_genes <- head(order(res$pvalue), 30)

# Remove genes with missing symbols
gene.names <- dataset.norm[top_genes,1]
top_genes <- top_genes[!is.na(unlist(gene.names))]

# Extract the DEGs from the normalized dataset
dataset.norm.deg <- dataset.norm[top_genes,]
dataset.norm.deg <- as.data.frame(dataset.norm.deg)
rownames(dataset.norm.deg) <- unlist(dataset.norm.deg[,1])

# Create a heatmap with row and column clustering for the DEGs in the normalized dataset
pheatmap(dataset.norm.deg[,-1], color = viridis(50), cluster_rows = TRUE, cluster_cols = TRUE, fontsize_number = 1, 
         border_color=NA, labels_row = dataset.norm.deg[,1])
