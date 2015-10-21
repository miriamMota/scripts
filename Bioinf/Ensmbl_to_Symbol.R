############################
## Miriam Mota Foix
## 21.10.2015
############################

# source("http://bioconductor.org/biocLite.R")
# biocLite("biomaRt")
library(biomaRt)
require(stringr)



############################
## ensemlTrans_to_symbol
############################
###
### transcript_list = llista "character" amb gens "ensembl Transcript"
### to = tipus ID de sortida
###
############################


ensemlTrans_to_symbol <- function(transcript_list, to='hgnc_symbol'){
ensembl = useEnsembl(biomart="ensembl", dataset="hsapiens_gene_ensembl")
hgnc <- getBM(attributes=c('ensembl_transcript_id',to),
              filters = 'ensembl_transcript_id', 
              values = transcript_list, mart = ensembl)
return(hgnc)
}


############################
## reTT
############################
###
### csv_clcbio = directori amb fitxer .csv inclós. Exemple: "
###             exemple: "/2015-03-DanielEscuin-StPau-A280/DE_ncRNAs_TvsO.csv"
### 
### A una topTable, on la primera columna es un id de "ensembl transcript"
### busca i afegeix en una columna el coresponent "hgnc symbol" i reescriu 
### la topTable amb el mateix nom afegint "_symbol"
############################

reTT <- function(csv_clcbio){
TT <- read.csv(csv_clcbio)
names(TT)[1] <- "ensembl_transcript_id"
enToSym <- ensemlTrans_to_symbol(as.character(TT$ensembl_transcript_id))
TTnew <- merge(TT,enToSym, by="ensembl_transcript_id",all=TRUE)
TTnew <- cbind(TTnew$hgnc_symbol,TTnew[,-ncol(TTnew)])
names(TTnew)[1]<- "hgnc_symbol"
write.csv(TTnew,paste(str_sub(csv_clcbio,end=-5),"_symbol",".csv",sep=""))
}


## Exemple per a fer-ho en tots els arxius d'un directori
all_files <- list.files(pattern=".csv") ## pattern= selecciona que han de tenir en comú
sapply(all_files, FUN=reTT)




