
require(ssize)
library(gdata) # for nobs()
# http://bioinformatics.mdanderson.org/MicroarraySampleSize/

#################
## ExpressAndTop
#################
TT <- read.csv2("results/ExpressAndTop.Estudi.XXXvsYYY.csv",row.names=1, header=TRUE) ## topTable results
TT_selec <- TT[1:100,]
#TT_selec <- TT
sd_genes <- unlist(apply(TT_selec[,grep("P.H.T12|P.L.T12",names(TT_selec))],1,sd,na.rm=TRUE)) ## sd per gen
length(sd_genes)   ## número de gens seleccionats
FC <- mean(abs(TT_selec$logFC)); FC
      

#fixem parametres
sig.level <- 0.05
power <- 0.8
fold.change <- 2 ## També es pot utilitzar el FC

# calculem mides mostrals
all.size  <- ssize(sd=sd_genes, delta=fold.change,sig.level=sig.level, power=power)

# grafiquem
pdf("results/sampleSize.XXXvsYYY.pdf")
ssize.plot(all.size, lwd=2, col="magenta", xlim=c(1,20))
xmax <- par("usr")[2]-1;
ymin <- par("usr")[3] + 0.05
legend(x=xmax, y=ymin,
       legend= strsplit( paste("log fold change=",round(fold.change,2),",",
                               "alpha=", sig.level, ",",
                               "power=",power,",",
                               "# genes=",nobs(sd_genes) , sep=''), "," )[[1]],
       xjust=1, yjust=0, cex=0.90)
title(paste("Sample Size to Detect",fold.change,"- Fold Change"))
dev.off()