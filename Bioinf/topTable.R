topTable <- function(cond1,cond2,BD,res=TRUE){
  w_stat <- NULL; w_pval <- NULL; mean_g1 <- NULL; mean_g2 <- NULL;lab <- NULL
  for (i in 1: nrow(BD)){
    tt <- t.test(BD[i,grep(cond1,names(BD))], BD[i, grep(cond2,names(BD))]) ## i = files, grep= condicio experimental
    da_c1 <- BD[i,grep(cond1,names(BD))]
    da_c2 <-  BD[i, grep(cond2,names(BD))]
    ww <- wilcox.test(c(unlist(da_c1),unlist(da_c2)) ~ c(rep(cond1,length(da_c1)), rep(cond2,length(da_c2))))
    w_stat[i] <- ww$statistic
    w_pval[i] <- ww$p.value
    mean_g1[i] <- tt$estimate[1]
    mean_g2[i] <-tt$estimate[2]
    lab[i] <- rownames(BD)[i] 
  }
  topT <- data.frame (w_stat, w_pval ,p.adjust(w_pval,method="fdr"), mean_g1, mean_g2, mean_g1-mean_g2)
  names(topT) <- c("w","P.value","Adj.p.val",paste("mean",cond1), paste("mean",cond2),"FC")
  rownames(topT) <- lab
  topT <- cbind(topT,BD[ ,grep(paste(cond1,"|",cond2,sep=""),names(BD))])
  topT <- topT[order(topT$Adj.p.val,topT$P.value),]
  write.csv(topT,paste("results/TopTable",cond1, ".vs",cond2,".csv",sep="" ))
  if(res)return(topT)
}

TvsC <- topTable(cond1 = ".T",cond2 = ".C",BD=dat)
