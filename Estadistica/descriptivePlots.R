############################
## Miriam Mota Foix
## 2016.09.29
############################

############################
## descPlot
############################
###
### dat = data frame amb les variables a realitzar els gràfics
### topdf = TRUE si es volen obtenir els resultats en un pdf
### nameFile = nom del fitxer on guardar els gràfics
###
### Genera gràfics univariants per totes les variables que s'indiquin
###
############################

descPlot <- function(dat, topdf = FALSE, nameFile = "descriptive_plots.pdf"){
  if (topdf) pdf(nameFile)
  par(mfrow = c(4,2))
for (i in 2:dim(dat)[2]) {
  if (class(dat[,i]) == "factor") {
    try(plot(dat[,i], xlab = names(dat)[i], main = "Diagrama de barras"),TRUE)
  }else {
      try(hist(dat[,i], xlab = names(dat)[i], main = "Histograma"),TRUE)
  }
  }
  if (topdf) dev.off()
}
