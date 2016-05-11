#This script will load and normilize your data
#directory for the Concordia data 
mydir <- "C:\\Users\\hakim\\Desktop\\Bioinformatics_Thesis_Concordia_Microarry_Data" #insert own directory here
#directory for Mars 500
mydir <- "C:\\Users\\hakim\\Desktop\\MARS500"

#listing the files from directory using special CEL file read function
celList <- list.celfiles(mydir, full.names=TRUE)
#reading data from cellist and setting annotation package to approiate one for this microarray
rawData <- read.celfiles(celList, pkgname='pd.hugene.2.0.st')
#normalizing the data using RMA algorithm
normData <- oligo::rma(rawData, target="core")
#retreaving feature data
featureData(normData) <- getNetAffx(normData, "transcript")


