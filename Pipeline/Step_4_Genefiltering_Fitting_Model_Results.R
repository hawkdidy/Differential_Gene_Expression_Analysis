#This script will remove genes with low variance as well as the affy control probes
#Then it will fit a linear models to determine the mean values of your genes and use ebayes to shrink the variance
#a t-test will then be done to get you the DEGs and a volcano plot to visualize 

#filtering of genes, removing all control probes and seeing what is filtered 
con <- db(pd.hugene.2.0.st)

probes.control <- dbGetQuery(con, "select fsetid from featureSet where
                             type in ('5','6','7','8','9','10','11','12','13','14','15','16','17');")[,1]

normData.filtered <- nsFilter(normData, require.entrez=FALSE, remove.dupEntrez=FALSE, feature.exclude = probes.control)
normData.filtered$filter.log                    

#Creating a design matrix based on the experiment and then a linear model for estimating mean expression values 
#bayes for shrinking the ste and getting DEGS
group <- factor(c((rep.int(0,13)),rep.int(1,14),rep.int(2,14)
                  ,rep.int(3,14),rep.int(4,14)))

design <- model.matrix(~ 0 + group)
colnames(design) <- c("I","T1","T2","T3", "T4")
#contrast matrix 
contrast <- makeContrasts( "I-T1","I-T2","I-T3","I-T4"
                           ,"T1-T2","T1-T3","T1-T4",
                            "T2-T3","T2-T4","T3-T4", levels= design )

normfit <-eBayes( contrasts.fit( lmFit(normData.filtered$eset, design), contrast) )

#getting the list of probes
probeset.listIT1 <-topTable(normfit,coef="I-T1",number=100000, adjust="BH", lfc=1)
probeset.listIT2 <-topTable(normfit,coef="I-T2",number=100000, adjust="BH", lfc=1)
probeset.listIT3 <-topTable(normfit,coef="I-T3",number=100000, adjust="BH", lfc=1)
probeset.listIT4 <-topTable(normfit,coef="I-T4",number=100000, adjust="BH", lfc=1)
probeset.listT12 <-topTable(normfit,coef="T1-T2",number=100000, adjust="BH", lfc=1)
probeset.listT13 <-topTable(normfit,coef="T1-T3",number=100000, adjust="BH", lfc=1)
probeset.listT14 <-topTable(normfit,coef="T1-T4",number=100000, adjust="BH", lfc=1)
probeset.listT23 <-topTable(normfit,coef="T2-T3",number=100000, adjust="BH", lfc=1)
probeset.listT24 <-topTable(normfit,coef="T2-T4",number=100000, adjust="BH", lfc=1)
probeset.listT34 <-topTable(normfit,coef="T3-T4",number=100000, adjust="BH", lfc=1)


write.table(probeset.listIT2,file="DEGS_IT2_CONTRAST.txt",sep= "\t" )
write.table(probeset.listIT3,file="DEGS_IT3_CONTRAST.txt",sep= "\t" )
write.table(probeset.listIT4,file="DEGS_IT4_CONTRAST.txt",sep= "\t" )
write.table(probeset.listT12,file="DEGS_T12_CONTRAST.txt",sep= "\t" )
write.table(probeset.listT13,file="DEGS_T13_CONTRAST.txt",sep= "\t" )
write.table(probeset.listT14,file="DEGS_T14_CONTRAST.txt",sep= "\t" )
write.table(probeset.listT23,file="DEGS_T23_CONTRAST.txt",sep= "\t" )
write.table(probeset.listT24,file="DEGS_T24_CONTRAST.txt",sep= "\t" )
write.table(probeset.listT34,file="DEGS_T34_CONTRAST.txt",sep= "\t" )


#Adding gene symbol to dataset 
#Symbol <- getSYMBOL(rownames(probeset.list), "hugene20sttranscriptcluster.db")
#results <- cbind(probeset.list, Symbol)

#writing results to a tab delimated text file
write.table(results,file="DEGS_ALL_CONTRAST.txt",sep= "\t" )

#visualizing genes with highest LFC and probably 
volcanoplot(normfit,highlight=10, coef=2)
