installifnot <- function(pkg) 
{
  if (!is.element(pkg, installed.packages()[,1]))
    install.packages(pkg, dep = TRUE)
  require(pkg, character.only = TRUE)
}

# Example
# installifnot("readxl")
