installBiocifnot <- function(pckgName){
  if (!(require(pckgName, character.only = TRUE))) {
    source("http://Bioconductor.org/biocLite.R")
    biocLite(pckgName)
    require(pckgName)
  }
}
# Example 
# installBiocifnot("CMA")

installifnot <- function(pckgName){
  if (!(require(pckgName, character.only = TRUE))) {
    install.packages(pckgName, dep = TRUE)
    require(pckgName)
  }
}
# Example 
# installifnot("xlsx")

installGitifnot <- function(pathPackage, proxy = FALSE, urlproxy = "conf_www.ir.vhebron.net", portproxy = 8081){
  if (!(require(pathPackage, character.only = TRUE))) {
    installifnot("devtools")
    # require(curl)
    if(proxy) set_config(use_proxy(url=urlproxy, port=portproxy)) 
    install_github(pathPackage)
    require(pathPackage)
    
  }
}
# Example 
# installGitifnot("miriammota/mmotaF")
