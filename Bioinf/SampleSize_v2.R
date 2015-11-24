############################
## Miriam Mota Foix
## 16.10.2015
############################


require(xlsx)
require(ssize)
library(gdata) # for nobs()
# http://bioinformatics.mdanderson.org/MicroarraySampleSize/


#################
## ExpressAndTop.Estudi.P.L.T12vsN.L.T12.csv 
#################
###
### TT= TopTable completa
### grupo1 = part esquerra de la comparació
### grupo2 = part dreta de la comparació
#################
###
### Per defecte, agafa:
###  els 100 primers gens de la top table
###  un foldChange de 2 
###  la desviacions corresponents a la nostra topTable
###
#################


sampleSize <- function(TT,grupo1,grupo2){
TT_selec <- TT[1:100,]
#TT_selec <- TT
sdc1 <- unlist(apply(TT_selec[,grep(paste(grupo1, "|", grupo2,sep=""),names(TT_selec))],1,sd,na.rm=TRUE)) ## sd per gen
length(sdc1)                    
lFC1 <- mean(abs(TT_selec$logFC)); lFC1  
SD1 <- mean(sdc1); SD1          

#fixem parametres
sig.level <- 0.05
power <- 0.8
fold.change <- 2

# calculem mides mostrals
all.size  <- ssize(sd=sdc1, delta=fold.change,sig.level=sig.level, power=power)

# grafiquem
pdf(paste("sampleSize.",grupo1,"vs",grupo2,".pdf",sep=""))
ssize.plot(all.size, lwd=2, col="magenta", xlim=c(1,20))
xmax <- par("usr")[2]-1;
ymin <- par("usr")[3] + 0.05
legend(x=xmax, y=ymin,
       legend= strsplit( paste("fold change=",round(fold.change,2),",",
                               "alpha=", sig.level, ",",
                               "power=",power,",",
                               "# genes=",nobs(sdc1) , sep=''), "," )[[1]],
       xjust=1, yjust=0, cex=0.90)
title("Sample Size to Detect 2-Fold Change")
dev.off()
}

###############
####### EXAMPLE
###############
TT <- read.csv2("ExpressAndTop.Estudi.XXXvsYYY.csv",row.names=1, header=TRUE) ## topTable results
sampleSize(TT, grupo1 = "XXX", grupo2 = "YYY")


