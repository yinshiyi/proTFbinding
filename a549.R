library(dplyr)
library(tidyr)
setwd("C:/Users/Shiyi Yin/AppData/Local/Packages/CanonicalGroupLimited.Ubuntu20.04onWindows_79rhkp1fndgsc/LocalState/rootfs/home/shiyi/proTFbinding")
a<-read.table("promoter.bed")
b<-read.table("samplename")
a549<-b%>% filter(V2=="A")
as.vector(a$V8[995])

a_sep<-separate_rows(a,V8, V9)
final_a<-a_sep[which(a_sep$V8%in%a549$V1),]
final_a$V6=final_a$V9
write.table(final_a[,c(-1,-7,-8,-9)],file="a549.bed", quote = F,col.names = F,row.names = F)
#bin	chrom	chromStart	chromEnd	name	score	sourceCount	sourceIds	sourceScores