---

## Exercise 5 (Breakout Activity) - Heatmaps for RNAseq

In this exercise, your task is to modify the R code (see HeatmapRNAseqV01.R) provided to produce more interpretable heatmaps and to alter the way differentially expressed genes (DEGs) are determined.

### Task 1: Improve Heatmap Interpretability

The pheatmap function in the R package `pheatmap` is a powerful tool for visually exploring gene expression data. However, depending on the dataset and the specific research question, different settings of the function can provide different insights.

Your task is to modify the options of the `pheatmap` function to improve the interpretability of the heatmaps. Specifically, consider changing the following parameters:

1. **Clustering Options:** Consider whether row and column clustering (i.e., reordering rows and columns to bring similar ones together) would help or hinder your understanding of the data. Would keeping the original order of the genes and/or samples be more helpful, or should some form of hierarchical clustering be used?

2. **Colors:** The choice of color can greatly influence the readability of your heatmap. Try out different color palettes (e.g., `RColorBrewer`, `viridis`, or create your own) and decide which one provides the best contrast for your data.

3. **Labels:** Consider the size and clarity of your labels. Depending on the size of your dataset, you might want to adjust the size of the labels or even omit them altogether for better readability.

### Task 2: Select Differentially Expressed Genes (DEGs) Using a Different Method

In the provided code, DEGs are selected based on their p-values, with the top 30 genes with the smallest p-values being chosen. However, this might not always be the best approach. For example, you might also want to consider the fold change (i.e., the ratio of the average expressions in two conditions), the false discovery rate (FDR), or a combination of these factors.

Your task is to modify the DEG selection process to use a different criterion. Consider the following approaches:

1. **Fold change:** Select the top genes with the largest absolute fold change. This will give you the genes that are most up- or down-regulated.

2. **False discovery rate (FDR):** Select the top genes with the smallest FDRs. This will help control the expected proportion of false positives among your DEGs.

3. **Combination of p-value, fold change, and FDR:** Develop a more complex selection criterion that considers all of these factors. For example, you could select genes that have a fold change above a certain threshold, a p-value below a certain threshold, and an FDR below a certain threshold.

Remember, the goal is to produce a list of DEGs that is most relevant to your specific research question. Good luck!

---
