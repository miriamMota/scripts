#' Reclass Function
#'
#' Convierte variables a clase correspondiente (para data.frame)
#' @param dat Base de datos en formato "data.frame"
#' @param nlev Maximo de niveles para considerar una variable factor
#' @keywords reclass
#' @export
#' @examples
#' reclass(data(mtcars))

############################
## Miriam Mota Foix
## 09.09.2015
############################

# 

reclass <- function(dat,nlev){
  tipus <- apply(dat,2, function(x) 
    ifelse((dim(table(x))<nlev )| (sum(grepl("[aA-zZ]",x)) >0), "cat","cont")) ## comprobem cat o cont
  for ( i in 1:length(tipus)) ifelse(tipus[i] == "cont", dat[,i]<- as.numeric(as.character(dat[,i])), dat[,i] <- as.factor(dat[,i]))
  return(dat)
}

