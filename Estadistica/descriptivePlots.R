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

descPlot <- function(data, topdf = FALSE, nameFile = "descriptive_plots.pdf"){
  if (topdf) pdf(nameFile)
  par(mfrow = c(3,2))
  for (i in 2:dim(data)[2]) {
    if (class(data[,i]) == "factor") {plot(data[,i], xlab = names(data)[i], main = "Histograma")
    }else {
      hist(data[,i], xlab = names(data)[i], main = "Histograma")
    }
  }
  if (topdf) dev.off()
}