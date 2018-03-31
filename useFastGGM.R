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
