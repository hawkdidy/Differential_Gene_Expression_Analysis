#This script will allow you to see the quality of your data and will output a pdf with an image of your microarrays

#checking boxplot of raw data
par(mar=c(10,4.5,2,1))
boxplot(rawData,las=3, target = "core")
#checking boxplot of normalized data
boxplot(normData,las=3, target = "core")
#hierarchical clustering
eset <- exprs(normData)
distance <- dist(t(eset),method="maximum")
clusters <- hclust(distance)
plot(clusters)

arrayQualityMetrics(expressionset = normData[,1:10],
                    outdir = "Report_for_Concordia",
                    force = TRUE,
                    do.logtransform = TRUE)


#making negative images
Pset = fitProbeLevelModel(rawData)

pdf(file='plot.pdf')
for (i in 1:69){image(Pset,which=i,main=ph@data$sample[i])}
dev.off()

#pca
pr <- prcomp(t(eset))
plot(pr$x,col="white",main="PC plot",
     xlim=c(???50,50))
text(pr$x[,1],pr$x[,2],labels=colnames(eset),
     cex=0.7)

ggplot(pr, aes(x = PC1, y = PC2)) + geom_point()


#ggplot histograms
pmexp = pm(rawData)
ph = rawData@phenoData
sampleNames = vector()
logs = vector()
for (i in 1:1)
{
  sampleNames = c(sampleNames,rep(ph@data[i,1],dim(pmexp)[1]))
  logs = c(logs,log2(pmexp[,i]))
}

ph@data

logData = data.frame(logInt=logs,sampleName=sampleNames)

dataHist2 = ggplot(logData, aes(logInt, colour = sampleName)) 
dataHist2 + geom_density()

ph@data[67,1]
dim(pmexp[1,])
dim(pmexp)[1]

hist(rawData[,1],lwd=2,which='pm',ylab='Density',xlab='Log2 intensities',main = "core")
 

hist(rawData)
