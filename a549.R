library(dplyr)
library(tidyr)
###########
# get the directory of current file
# devtools::install_github("rstudio/rstudioapi")
# rstudioapi::getSourceEditorContext()$path
# dirname(rstudioapi::getSourceEditorContext()$path)
###########
#setwd("C:/Users/Shiyi Yin/AppData/Local/Packages/CanonicalGroupLimited.Ubuntu20.04onWindows_79rhkp1fndgsc/LocalState/rootfs/home/shiyi/proTFbinding")
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

######
# reading in the raw bed file or a smaller window file
# future scaling up, i can download the whole dataframe from ucsc
# http://genome.ucsc.edu/cgi-bin/hgTables?hgsid=1262006667_RjGTapTAm4SH8VfqtVluPZs8R8j9&clade=mammal&org=Human&db=hg38&hgta_group=regulation&hgta_track=encRegTfbsClustered&hgta_table=encRegTfbsClustered&hgta_regionType=genome&position=chr11%3A126%2C257%2C094-126%2C271%2C394&hgta_outputType=primaryTable&hgta_outFileName=
a2<-read.table("raw_peak.gz")
a<-read.table("promoter.bed")

# reformat the sample source and peak score column
a_sep<-separate_rows(a,V8, V9)
a2_sep<-separate_rows(a2,V8, V9)

########
# reading in the sample code and sample full name table
b<-read.table("samplename")

########
# filter only with A549 cells which is a nsclc cancer cell line
a549<-b%>% filter(V2=="A")
HEK293<-b%>% filter(V2=="h")


###############
# filter the raw bed file based on if each entry is from a549 source
final_a<-a_sep[which(a_sep$V8%in%a549$V1),]
final_a549_full<-a2_sep[which(a2_sep$V8%in%a549$V1),]
############
# assign a549 score from the above matching to the main score to display
final_a$V6=final_a$V9
final_a549_full$V6=final_a549_full$V9
###########
# write the output bed file for visualization
# remember to set useScore=1 before visualization, this is now done manually, can be scripted in future
write.table(final_a[,c(-1,-7,-8,-9)],file="a549.bed", quote = F,col.names = F,row.names = F)
write.table(final_a549_full[,c(-1,-7,-8,-9)],file="a549_full.bed", quote = F,col.names = F,row.names = F)
#system("sed '1 s/^/track name=A549 useScore=1\n/' a549_full.bed > a549_full_visualization.bed")

##########
# notes of the column biological meanings
#bin	chrom	chromStart	chromEnd	name	score	sourceCount	sourceIds	sourceScores