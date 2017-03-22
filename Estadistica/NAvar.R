
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

NAvar <- function(df, maxNA = 80){
  na <- list()
  na$perc <- sort( apply(df,2,function(x) round((sum(is.na(x))/length(x) )*100,2)) )
  na$var <- names(na$perc )[na$perc  > maxNA]
  return(na)
}
