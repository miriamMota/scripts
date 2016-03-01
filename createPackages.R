# http://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/
# http://r-pkgs.had.co.nz/git.html

require("devtools")
require("roxygen2")
pkgDir <- "/home/miriam/"
setwd(pkgDir)
create("mmotaF")


# agregar funciones a carpeta "R" 

# añadir documentacion en script funcion.R 

#' A prepLearnSets Function
#'
#' Genera datos de entrenamiento a partir de una base de datos mediante diferentes técnicas de cross-validation
#' @param Y.tr vector de datos de clase "factor" donde se indican las condiciones experimentales (a comparar) de cada individuo
#' @param learnSetNames método a utilizar para la generación de "learningsSets". Los diferentes métodos (LOOCV, CV, MCCV, bootstrap) se explican en \code{\link{GenerateLearningsets}} 
#' @param compName nombre de la comparación, se usara como identificador y para el nombre de archivos resultantes
#' @param resultsDir carpeta donde se guardaran los resultados. p.e. "results/". Solo necesario cuando saveLearnSet = TRUE
#' @param fold Gives the number of CV-groups. Used only when method="CV"
#' @param niter Number of iterations (s.details).
#' @param saveLearnSet valor logico que indica si se guardan los resultados en disco
#' @export prepLearnSets
#' @import CMA
#' @author Miriam Mota <mmota.foix@@gmail.com>
#' @seealso Text with \code{\link{GenerateLearningsets}} 
#' @examples
#' # require("CMA")
#' # y <- factor(c(rep("A",10),rep("B",10)))
#' # lSet <- prepLearnSets(Y.tr = y , learnSetNames = "LOOCV", compName = "AvsB", saveLearnSet = F) 
#' @return learningSets datos resultantes, "datos de entrenamiento". Objeto con clase "learningsets".
#' @return learningSetsFileName nombre del archivo guardado con los "datos de entrenamiento"
#' @keywords cma predictor biomarcador clasificador learningsets
#' @references M Slawski, M Daumer and A-L Boulesteix, CMA – a comprehensive Bioconductor package for supervised classification with high dimensional data


### Afegir import a DESCRIPTION Imports: xtable, Hmisc

# procesar documento 
setwd("./mmotaF")
document()

check()
# per instalar 
setwd(pkgDir)
# install("tabORrl")  # desde local


install_github('miriamMota/scripts/mmotaFoix') # desde github
require(tabORrl)
?tabORrl

# http://r-pkgs.had.co.nz/description.html
# http://roxygen.org/roxygen2-manual.pdf
