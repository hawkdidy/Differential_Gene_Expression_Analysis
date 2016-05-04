#me not knowing how to for loop this 
probeset.list12 <-topTable(normfit,coef="T1-T2",number=100000, adjust="BH", p.value = 0.05)
probeset.list13 <-topTable(normfit,coef="T1-T3",number=100000, adjust="BH", p.value = 0.05)
probeset.list14 <-topTable(normfit,coef="T1-T4",number=100000, adjust="BH", p.value = 0.05)
probeset.list15 <-topTable(normfit,coef="T1-T5",number=100000, adjust="BH", p.value = 0.05)
probeset.list23 <-topTable(normfit,coef="T2-T3",number=100000, adjust="BH", p.value = 0.05)
probeset.list24 <-topTable(normfit,coef="T2-T4",number=100000, adjust="BH", p.value = 0.05)
probeset.list25 <-topTable(normfit,coef="T2-T5",number=100000, adjust="BH", p.value = 0.05)
probeset.list34 <-topTable(normfit,coef="T3-T4",number=100000, adjust="BH", p.value = 0.05)
probeset.list35 <-topTable(normfit,coef="T3-T5",number=100000, adjust="BH", p.value = 0.05)
probeset.list45 <-topTable(normfit,coef="T4-T5",number=100000, adjust="BH", p.value = 0.05)

Symbol <- getSYMBOL(rownames(probeset.list12), "hugene20sttranscriptcluster.db")
probeset.list12 <- cbind(probeset.list12, Symbol)
Symbol <- getSYMBOL(rownames(probeset.list13), "hugene20sttranscriptcluster.db")
probeset.list13 <- cbind(probeset.list13, Symbol)
Symbol <- getSYMBOL(rownames(probeset.list14), "hugene20sttranscriptcluster.db")
probeset.list14 <- cbind(probeset.list14, Symbol)
Symbol <- getSYMBOL(rownames(probeset.list15), "hugene20sttranscriptcluster.db")
probeset.list15 <- cbind(probeset.list15, Symbol)
Symbol <- getSYMBOL(rownames(probeset.list23), "hugene20sttranscriptcluster.db")
probeset.list23 <- cbind(probeset.list23, Symbol)
Symbol <- getSYMBOL(rownames(probeset.list24), "hugene20sttranscriptcluster.db")
probeset.list24 <- cbind(probeset.list24, Symbol)
Symbol <- getSYMBOL(rownames(probeset.list25), "hugene20sttranscriptcluster.db")
probeset.list25 <- cbind(probeset.list25, Symbol)
Symbol <- getSYMBOL(rownames(probeset.list34), "hugene20sttranscriptcluster.db")
probeset.list34 <- cbind(probeset.list34, Symbol)
Symbol <- getSYMBOL(rownames(probeset.list35), "hugene20sttranscriptcluster.db")
probeset.list35 <- cbind(probeset.list35, Symbol)
Symbol <- getSYMBOL(rownames(probeset.list45), "hugene20sttranscriptcluster.db")
probeset.list45 <- cbind(probeset.list45, Symbol)



write.table(probeset.list12,file="DEGS_T12_CONTRAST_Mars.txt",sep= "\t" )
write.table(probeset.list13,file="DEGS_T13_CONTRAST_Mars.txt",sep= "\t" )
write.table(probeset.list14,file="DEGS_T14_CONTRAST_Mars.txt",sep= "\t" )
write.table(probeset.list15,file="DEGS_T15_CONTRAST_Mars.txt",sep= "\t" )
write.table(probeset.list23,file="DEGS_T23_CONTRAST_Mars.txt",sep= "\t" )
write.table(probeset.list24,file="DEGS_T24_CONTRAST_Mars.txt",sep= "\t" )
write.table(probeset.list25,file="DEGS_T25CONTRAST_Mars.txt",sep= "\t" )
write.table(probeset.list34,file="DEGS_T34_CONTRAST_Mars.txt",sep= "\t" )
write.table(probeset.list35,file="DEGS_T35_CONTRAST_Mars.txt",sep= "\t" )
write.table(probeset.list45,file="DEGS_T45_CONTRAST_Mars.txt",sep= "\t" )

write.table(probeset.list12,file="DEGS_T12_CONTRAST_Conc.txt",sep= "\t" )
write.table(probeset.list13,file="DEGS_T13_CONTRAST_Conc.txt",sep= "\t" )
write.table(probeset.list14,file="DEGS_T14_CONTRAST_Conc.txt",sep= "\t" )
write.table(probeset.list15,file="DEGS_T15_CONTRAST_Conc.txt",sep= "\t" )
write.table(probeset.list23,file="DEGS_T23_CONTRAST_Conc.txt",sep= "\t" )
write.table(probeset.list24,file="DEGS_T24_CONTRAST_Conc.txt",sep= "\t" )
write.table(probeset.list25,file="DEGS_T25CONTRAST_Conc.txt",sep= "\t" )
write.table(probeset.list34,file="DEGS_T34_CONTRAST_Conc.txt",sep= "\t" )
write.table(probeset.list35,file="DEGS_T35_CONTRAST_Conc.txt",sep= "\t" )
write.table(probeset.list45,file="DEGS_T45_CONTRAST_Conc.txt",sep= "\t" )

x<- c("T1","T2","T3","T4","T5")
all.comb <- combn(x,2)
coef.value <- paste(all.comb[1,1:10],all.comb[2,1:10],sep="-")


var.name <- c("T12", "T13", "T14", "T15", "T23", "T24", "T25", "T34", "T35", "T45")
probesetlist.name <- paste("probeset.list",var.name,sep="")


for (i in 1:10){
  probesetlist.name[i] <- topTable(normfit,coef=coef.value[i],number=100000,adjust="BH",p.value = 0.05)
}
