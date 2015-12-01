# http://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/

source("https://raw.githubusercontent.com/miriamMota/scripts/master/installifnot.R")
installifnot("devtools")
installifnot("roxygen2")
setwd("/home/miriam/scripts/Estadistica/")
create("cats2")


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
setwd("./reclass")
document()

# per instalar 
setwd("..")
install("reclass")


install_github("reclass", 'miriamMota/scripts/Estadistica')
