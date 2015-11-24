############################
## Miriam Mota Foix
## 23.11.2015
############################

hm_ord <- function(tTab, colPval="Adj.p.val",pval=0.05,ordC=TRUE,cond1,cond2 ){
  tt_hm <- read.csv(paste("results/",tTab,sep="" ))
  rownames(tt_hm) <- tt_hm$X
  which_colpval <- which(names(tt_hm) == colPval)
  samples <-  grep(paste0("[A-Z]",cond1,"|","[A-Z]",cond2),names(tt_hm),value=TRUE)
  hm_dat <- as.matrix(tt_hm[tt_hm[which_colpval] < pval, samples])
  colors <- as.character(targets$Colores[targets$SampleName%in%samples])
  
  if(ordC){
    heatmap(hm_dat, col=colorRampPalette(c("gray87","mediumorchid4"))(100),ColSideColors= colors,
            main=paste(substr(tTab, start=10, stop=18), "(", colPval,"=",pval,")"), cexRow= 0.5, cexCol=0.5)
  }
  if(!ordC){
    heatmap(hm_dat, col=colorRampPalette(c("gray87","mediumorchid4"))(100),ColSideColors= colors,
            main=paste(substr(tTab, start=10, stop=18), "(", colPval,"=",pval,")"), cexRow= 0.5, cexCol=0.5, Colv=NA)
  }
}  

filenames= grep("vs",dir("results/"),value=TRUE)
par(oma= c(3,3,3,3))



pdf("results/heatmapsRowcol.pdf") 
for (i in 1:length(filenames))  {
  par(oma= c(3,3,3,3))
  try(hm_ord(tTab= filenames[i],colPval="Adj.p.val",pval=0.05,
             cond1=paste(".", strsplit(filenames[i],"[.]")[[1]][2], sep="")  ,
             cond2=paste(".", strsplit(filenames[i],"[.]")[[1]][4], sep="")  ))
  }
dev.off()
