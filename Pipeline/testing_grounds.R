#adding pheno data and heatmapping, testing grounds 

phenoData <- read.csv("~/GitHub/Thesis-Project/Pipeline/phenoData.txt", sep="")

pheno <- phenoData

probeset.list<- head(probeset.list,n=100)


pData(rawData) <- pheno

pData(rawData)

reset <- exprs(normData)
dataset <- data.frame(reset)
eset <- subset(dataset, rownames(dataset) %in% row.names(probeset.list))

eset <- exprs(probeset.list)
heatmap(eset, scale = "none", na.rm = TRUE, margins = c(15, 7), distfun = function(x) {
  dist(x, method = "euclidian")
}, hclustfun = function(x) {
  hclust(x, method = "average")
}, ColSideColors = as.character(2 + as.numeric(pheno$time)))


library(gplots)

y <- eset

hr <- hclust(as.dist(1-cor(t(y), method="pearson")), method="average");
hc <- hclust(as.dist(1-cor(y, method="kendall")), method="average") 
mycl <- cutree(hr, h=max(hr$height)/1.3);
mycolhc <- rainbow(length(unique(mycl)), start=0.1, end=0.9);
mycolhc <- mycolhc[as.vector(mycl)]
myheatcol <- greenred(75)

heatmap.2(y, Rowv=as.dendrogram(hr), Colv=as.dendrogram(hc), col=myheatcol, scale="row", density.info="none",
          trace="none", key = FALSE, cexRow = 0.7, cexCol = 0.8, srtRow = NULL, srtCol= 20, 
          labRow = TRUE, main = "Heatmap",  RowSideColors=mycolhc, labCol= TRUE )
heatmap(y, col=topo.colors(75), scale="none", ColSideColors=t, cexRow=0.5)
y <- as.matrix(y)

t <- t(pheno[,2])
ncol(t)
t<-as.character(t)
color <- c("#edf8e9","#bae4b3","#74c476","#31a354","#006d2c")
time<- c("t1","t2","t3","t4","t5")

t <- sub("t5", "#006d2c", t, ignore.case = FALSE)

t = factor(t,levels = c("t1","t2","t3","t4","t5"), 
           labels = c("#edf8e9","#bae4b3","#74c476","#31a354","#006d2c"))

