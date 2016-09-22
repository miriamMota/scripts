
############################
## Miriam Mota Foix
## 2016.09.13
############################

############################
## ttestRes
############################
###
### dataframe = nom del data.frame on es troben les variables
### maxNA = percentatge de NA permes
###
### Percentatge de dades faltants per variable (na$perc) i variables amb més de "x" percentatge(na$var). 
###
############################

NAvar <- function(dataframe, maxNA = 0.8){
  na <- list()
  na$perc <- apply(dataframe,2,function(x) sum(is.na(x))/length(x) )
  na$var <- names(na$perc )[na$perc  > maxNA]
  return(na)
}


