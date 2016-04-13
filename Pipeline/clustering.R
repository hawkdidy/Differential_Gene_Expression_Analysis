library(Mfuzz)

#First I need to retrieve the expression values of my confirmed DEG

#names of the rows in my list of differential expressed genes 
names <- row.names(probeset.list)

x <- subset(dataset, rownames(dataset)  %in% names)
#turning data subset into expression set object 
eset<-new("ExpressionSet", exprs=as.matrix(x))
#Standardization is done because the clustering is done in a Euclidian space. The mean is made to zero and SD is one.
stand <- standardise(eset)

#estimationg of m parameter for clustering 
mestimate(stand)
#soft clustering
cl <- mfuzz(stand,c=10,m=1.04)
mfuzz.plot(stand,cl=cl,mfrow=c(2,2))
