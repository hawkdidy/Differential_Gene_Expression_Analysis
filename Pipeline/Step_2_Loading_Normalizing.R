#This script will load and normilize your data
#directory for the data
mydir <- "C:\\Users\\hakim\\Desktop\\Bioinformatics_Thesis_Concordia_Microarry_Data" #insert own directory here


#listing the files from directory using special CEL file read function
celList <- list.celfiles(mydir, full.names=TRUE)
#reading data from cellist and setting annotation package to approiate one for this microarray
rawData <- read.celfiles(celList, pkgname='pd.hugene.2.0.st')
#normalizing the data using RMA algorithm
normData <- rma(rawData, target="core")
#retreaving feature data
featureData(normData) <- getNetAffx(normData, "transcript")
