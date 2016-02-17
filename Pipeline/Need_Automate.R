#me not knowing how to for loop this 
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

x<- c("I","T1","T2","T3","T4")
all.comb <- combn(x,2)
coef.value <- paste(all.comb[1,1:10],all.comb[2,1:10],sep="-")


var.name <- c("IT1", "IT2", "IT3", "IT4", "T12", "T13", "T14", "T23", "T24", "T34")
probesetlist.name <- paste("probeset.list",var.name,sep="")


for (i in 1:10){
  probesetlist.name[i] <- topTable(normfit,coef=coef.value[i],number=100000,adjust="BH",lfc=1)
}