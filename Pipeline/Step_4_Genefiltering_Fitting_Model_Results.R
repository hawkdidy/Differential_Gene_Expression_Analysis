#This script will remove genes with low variance as well as the affy control probes
#Then it will fit a linear models to determine the mean values of your genes and use ebayes to shrink the variance
#a t-test will then be done to get you the DEGs and a volcano plot to visualize 

#filtering of genes, removing all control probes and seeing what is filtered 
eset <- getMainProbes(normData)
normData.filtered <- nsFilter(eset, require.entrez = FALSE, 
                              remove.dupEntrez = FALSE)normData.filtered <- nsFilter(normData, require.entrez=FALSE, remove.dupEntrez=FALSE, feature.exclude = probes.control)
normData.filtered$filter.log               

#Creating a design matrix based on the experiment and then a linear model for estimating mean expression values 
#bayes for shrinking the ste and getting DEGS
group <- factor(c((rep.int(0,13)),rep.int(1,14),rep.int(2,14)
                  ,rep.int(3,14),rep.int(4,14)))

design <- model.matrix(~ 0 + group)
colnames(design) <- c("I","T1","T2","T3", "T4")
#contrast matrix 
contrast <- makeContrasts( "I-T1","T1-T2","T2-T3","T3-T4",
                           levels= design )

normfit <-eBayes( contrasts.fit( lmFit(normData.filtered$eset, design), contrast) )

#getting the list of probes
probeset.list <-topTable(normfit,number=100000, adjust="BH", lfc=1)


#Adding gene symbol to dataset 
Symbol <- getSYMBOL(rownames(probeset.list), "hugene20sttranscriptcluster.db")
results <- cbind(probeset.list, Symbol)


#writing results to a tab delimated text file
write.table(results,file="DEGS_ALL_CONTRAST.txt",sep= "\t" )

#visualizing genes with highest LFC and probably 
volcanoplot(normfit,highlight=10, coef=2)
