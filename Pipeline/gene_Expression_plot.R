#Input here the the affy ID of your gene of interest
gene <- 16676983

#getting expression data from affy object and converting to dataframe
reset <- exprs(normData)
dataset <- data.frame(reset)

#Subset the data set to recieve a row with the gene expression data over all time points of that gene 
x <- subset(dataset, rownames(dataset) == gene)

#taking the transpost of the data frame for easier plotting
x <- t(x) 

#parsing the gene expression per time point  
t2 <- x[1:14]
t1 <- x[15:28]
t3 <- x[29:42]
t4 <- x[43:57]
t5<- x[58:69]


#Gene expression plot on all time points for a gene 
explot <- plot_ly(y = t1, type = "box") %>%
  add_trace(y = t2, type = "box")%>%
  add_trace(y = t3, type = "box") %>%
  add_trace(y = t4, type = "box") %>%
  add_trace(y = t5, type = "box")

#display plot

explot
