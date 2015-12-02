# http://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/
# http://r-pkgs.had.co.nz/git.html

require("devtools")
install_github('miriamMota/scripts/installifnot')
require(installifnot)
installifnot("roxygen2")
pkgDir <- "/home/miriam/scripts/"
setwd(pkgDir)
create("mmotaFoix")


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
setwd("./tabORrl")
document()

# per instalar 
setwd(pkgDir)
# install("tabORrl")  # desde local


install_github('miriamMota/scripts/Estadistica/tabORrl') # desde github
require(tabORrl)
?tabORrl
