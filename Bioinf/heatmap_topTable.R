############################
## Miriam Mota Foix
## 17.11.2015
############################

#install.packages("ggplot2")
#install.packages("reshape")
require(ggplot2)
require(reshape)


############################
## hm_topTable
############################
###
### tTable = topTable en format data.frame. Amb columnes d'expressions que es volen mostrar
### namePval = nom de la columna del P.valor
### cond1 = nom identificatiu de la condicio 1 de la comparacio(per escollir columnes de mostres que compleixin aixo)
### cond2 = nom identificatiu de la condicio 2 de la comparacio(per escollir columnes de mostres que compleixin aixo)
### pval = valor que considerem diferencialment expressat
### limMax = valor máxim a mostrar a la escala de color
###
### Visualizar las expresiones de cada gen/proteina/miRNA agrupándolas para destacar aquellas que se encuentran up o down
### reguladas, constituyendo perfiles de expresión.
###
############################

hm_topTable <- function(tTable, namePval ,cond1, cond2, pval,limMax=NULL){
  posPval <- which(names(tTable) == namePval)
  DEGc1 <- melt(cbind(tTable[tTable[posPval] < pval,grep(paste(cond1,"|",cond2,sep=""),names(tTable))],rownames(tTable)[which(tTable[posPval] < pval)]))
  names(DEGc1) <- c("Gene","variable","value")
  ggplot(melt(DEGc1), aes(variable,Gene)) +  geom_tile(aes(fill = value), colour = "white")+ 
    scale_fill_gradient(low = "gray87", high = "mediumorchid4",na.value ="black" ,
                        limits=c(min(DEGc1$value),ifelse(invalid(limMax),max(DEGc1$value),limMax) )) +
    xlab("") + 
    ylab("")+
    ggtitle(paste("DEG",cond1,".vs",cond2, " (P.value <",pval ,")",sep="")) +
    theme(panel.background = element_blank()) + 
    theme(axis.text.x = element_text(angle = 450))
}


######### Exemple #######
hm_topTable(tTable = TvsC, namePval = "P.value", cond1 = ".T", cond2 = ".C",  pval = 0.01) #, limMax=250)



