############################
## Miriam Mota Foix
## 09.09.2015
############################

# Convertir variables a clase corresponent  i primer mirada dades depurar

reclass <- function(dat,nlev){
  tipus <- apply(dat,2, function(x) 
    ifelse((dim(table(x))<nlev )| (sum(grepl("[aA-zZ]",x)) >0), "cat","cont")) ## comprobem cat o cont
  for ( i in 1:length(tipus)) ifelse(tipus[i] == "cont", dat[,i]<- as.numeric(as.character(dat[,i])), dat[,i] <- as.factor(dat[,i]))
  return(dat)
}

