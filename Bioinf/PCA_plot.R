plotPCA <- function ( X, labels=NULL, colors=NULL, var = "",dataDesc="", scale=FALSE, formapunts=NULL, myCex=NULL,xmin=min(pcX$x[,1])-10,xmax=max(pcX$x[,1])+1,ymin =min(pcX$x[1,])-10 ,ymax= max(pcX$x[1,])+1, ...)
{
  pcX<-prcomp(t(X))
  loads<- round(pcX$sdev^2/sum(pcX$sdev^2)*100,1)
  xlab<-c(paste("PC1",loads[1],"%"))
  ylab<-c(paste("PC2",loads[2],"%"))
  if (is.null(colors)) colors=colores
  plot(pcX$x[,1:2],xlab=xlab,ylab=ylab,
       xlim=c(xmin,xmax),ylim=c(ymin,ymax),pch=formapunts, col=colors)
  text(pcX$x[,1],pcX$x[,2],labels,pos=3,cex=myCex, col=colors)
  title(paste(var, dataDesc, sep=" "), cex=0.2)
}