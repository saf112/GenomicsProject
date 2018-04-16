library('lsa')
library(cluster)
library(gplots)
library(dendextend)
library(R.matlab)
library(FastGGM)
library(network)
library(sna)
library(ggplot2)
library(GGally)

epicells=readMat('/Users/omeracar/Box Sync/Genomics_project/mat_files/sample_epicells.mat')
epicells=epicells[[1]]
epiMatrix=as.matrix(epicells)
d1<-cosine(t(epiMatrix))
d1<-1-d1
d1<-as.dist(d1)
agn1 <- agnes(d1, method ="ward" )
dend1_<-as.dendrogram(agn1)
cols_branches <- c("darkred", "forestgreen", "orange", "mediumvioletred")
dend1_ <- color_branches(dend1_,k = 4, col = cols_branches)
labels_colors(dend1_)<-cols_branches

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
               Rowv=dend1_,#sort(rotate.dendrogram1(dend1_,groups)),#,type = "average"),
               #RowSideColors=my_col,
               Colv=FALSE,
               cexRow = 0.3)


#my_col=cols_branches[my_group]

#get 4 clusters
groups<-cutree(dend1_,k = 4)

#get row numbers for every cluster
cl1<-as.integer(labels(groups[groups==1]))
cl2<-as.integer(labels(groups[groups==2]))
cl3<-as.integer(labels(groups[groups==3]))
cl4<-as.integer(labels(groups[groups==4]))

#split data into clusters
cl1Data<-epicells[cl1,]
cl2Data<-epicells[cl2,]
cl3Data<-epicells[cl3,]
cl4Data<-epicells[cl4,]

#mean vector of every cluster
cl1Mean<-colMeans(cl1Data)
cl2Mean<-colMeans(cl2Data)
cl3Mean<-colMeans(cl3Data)
cl4Mean<-colMeans(cl4Data)
