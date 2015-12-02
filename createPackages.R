# http://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/

source("https://raw.githubusercontent.com/miriamMota/scripts/master/installifnot.R")
installifnot("devtools")
installifnot("roxygen2")
pkgDir <- "/home/miriam/scripts/Estadistica/"
setwd(pkgDir)
create("multGGplot")


# agregar funciones a carpeta "R" 

# añadir documentacion en script funcion.R 

#' A Cat Function
#'
#' This function allows you to express your love of cats.
#' @param love Do you love cats? Defaults to TRUE.
#' @keywords cats
#' @export
#' @examples
#' cat_function()

# procesar documento 
setwd("./multGGplot")
document()

# per instalar 
setwd(pkgDir)
install("multGGplot")


install_github('miriamMota/scripts/Estadistica/multGGplot')
