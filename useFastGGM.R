#setwd("path/to/working/directory") can be used to change working directory 

install.packages("R.matlab")
install.packages('ggplot2')
install.packages('network')
install.packages('sna')
#also install FastGGM using their website it cannot be directly installed as above
#then comment out / or delete above install lines


library(R.matlab)
library(FastGGM)
library(network)
library(sna)
library(ggplot2)


#read .mat file and use FastGGM to calculate covariances
#files should be in the working directory
#as.matrix(s1_sample[[1]]) changes data type from list to matrix so that FastGGM can use the imported data
s1_sample<-readMat('s1_sample.mat')
outlist1 <- FastGGM(as.matrix(s1_sample[[1]]))

s2_sample<-readMat('s2_sample.mat')
outlist2 <- FastGGM(as.matrix(s2_sample[[1]]))

s3_sample<-readMat('s3_sample.mat')
outlist3 <- FastGGM(as.matrix(s3_sample[[1]]))

#in order to save an object to file simply use following line
#list --> the object to be saved
# file --> file name to be used
#save(list='outlist1', file='outlist1.Rdata')



#preliminary lines to create network plot out of the data calculated above
#cov=outlist1[[2]]
#cov[cov< 0]<- 0
#cov[cov>0 ]<-1
#gg=network(cov, matrix.type="adjacency")
#ggnet2(gg)


####Clustering
#Install necessary packages with install.packages("packageName") command first
library(cluster)
library(gplots)
library(dendextend)
library(lsa)
epicells=readMat('/Users/omeracar/Box Sync/Genomics_project/sample_epicells.mat') #read file
epicells=epicells[[1]]
epiMatrix=as.matrix(epicells) #I am not sure if this is needed but using anyway, change data to matrix
d1<-cosine(t(epiMatrix))
d1<-1-d1 #calculate cosine similarity and (1-that) is dissimilarity
d1<-as.dist(d1) #in order to use clustering function, convert d1 to dist object
agn1 <- agnes(d1, method ="weighted" ) #agnes is the clustering function, change method for different linkages
dend1_<-as.dendrogram(agn1) 

out<-heatmap.2(epiMatrix,
               #cellnote = mat_data,  # same data set for cell labels
               #main = "agnes, manhattan", # heat map title
               notecol="black",      # change font color of cell labels to black
               density.info="none",  # turns off density plot inside color legend
               trace="none",         # turns off trace lines inside the heat map
               #scale = "row",
               #margins =c(12,9),     # widens margins around plot
               #col=hmcol,       # use on color palette defined earlier
               #breaks=col_breaks,    # enable color transition at specified limits
               dendrogram="row",     # only draw a row dendrogram
               Rowv=dend1_, #
               #RowSideColors=my_col,
               Colv=FALSE,
               cexRow = 0.3)
