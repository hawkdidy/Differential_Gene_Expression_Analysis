#adding pheno data and heatmapping, testing grounds 

phenoData <- read.csv("~/GitHub/Thesis-Project/Pipeline/phenoData.txt", sep="")
rawData@phenoData = phenoData

pheno <- phenoData



pData(rawData) <- pheno

pData(rawData)

eset <- subset(dataset, rownames(dataset) %in% row.names(probeset.list))

eset <- exprs(probeset.list)
heatmap(eset, scale = "none", na.rm = TRUE, margins = c(15, 7), distfun = function(x) {
  dist(x, method = "euclidian")
}, hclustfun = function(x) {
  hclust(x, method = "average")
}, ColSideColors = as.character(2 + as.numeric(pheno$time)))


