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
colnames(design) <- c("Intercept","T1","T2","T3", "T4")
#contrast matrix 
contrast <- makeContrasts( "Intercept-T1","Intercept-T2","Intercept-T3","Intercept-T4"
                           ,"T1-T2","T1-T3","T1-T4",
                            "T2-T3","T2-T4","T3-T4", levels= design )

normfit <-eBayes( contrasts.fit( lmFit(normData.filtered$eset, design), contrast) )

#getting the list of probes
probeset.list <-topTable(normfit,number=100000, adjust="BH", lfc=1)

#Adding gene symbol to dataset 
#retreaving feature data
#featureData(normData) <- getNetAffx(normData, "transcript")
Symbol <- getSYMBOL(rownames(probeset.list), "hugene20sttranscriptcluster.db")


results <- cbind(probeset.list, Symbol)

#writing results to a tab delimated text file
write.table(results,file="DEGS_ALL_CONTRAST.txt",sep= "\t" )

#visualizing genes with highest LFC and probably 
volcanoplot(normfit,highlight=10, coef=2)