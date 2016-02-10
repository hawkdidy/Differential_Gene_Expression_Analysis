#checking boxplot of raw data
par(mar=c(10,4.5,2,1))
boxplot(rawData,las=3)
#checking boxplot of normalized data
boxplot(normData,las=3)
#hierarchical clustering
eset <- exprs(normData)
distance <- dist(t(eset),method="maximum")
clusters <- hclust(distance)
plot(clusters)

#making negative images
Pset = fitProbeLevelModel(rawData)

pdf(file='plot.pdf')
for (i in 1:69){image(Pset,which=i,main=ph@data$sample[i])}
dev.off()