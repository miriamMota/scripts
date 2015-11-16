installifnot <- function (pckgName) {
  if (!(require(pckgName, character.only = TRUE))){
    install.packages(pckgName)
    require(pckgName, character.only = TRUE)
  }
}

