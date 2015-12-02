#' installifnot Function
#'
#' Comprueba si un paquete esta instalado y si no lo instala y carga.
#' @param pkg Nombre del paquete en formato caracter
#' @keywords install
#' @export
#' @examples
#' installifnot("readxl")


installifnot <- function(pkg) 
{
  if (!is.element(pkg, installed.packages()[,1]))
    install.packages(pkg, dep = TRUE)
  require(pkg, character.only = TRUE)
}
