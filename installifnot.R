installBiocifnot <- function(pckgName){
  if (!(require(pckgName, character.only = TRUE))) {
    source("http://Bioconductor.org/biocLite.R")
    biocLite(pckgName)
  }
}
# Example 
# installBiocifnot("CMA")

installifnot <- function(pckgName){
  if (!(require(pckgName, character.only = TRUE))) {
    install.packages(pckgName, dep = TRUE)
  }
}
# Example 
# installifnot("xlsx")

installGitifnot <- function(pathGit, pckgName){
  if (!(require(pckgName, character.only = TRUE))) {
    installifnot("devtools")
    install_github(file.path(pathGit,pckgName))
  }
}
# Example 
# installGitifnot("miriammota/","mmotaF")
