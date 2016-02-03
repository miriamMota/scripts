#####
##### Codi agafat de (Xavier dePedro): https://github.com/xavidp/bpmmirna/blob/master/basicA.R 
#####

### Comprobació de links funcionals

###################################################
## Check that there are no broken links in the report
###################################################
# Use linklint which is fast, easyly installable and run (highly effective program!)
# http://www.linklint.org
# Install in your Debian/Ubuntu computer with: 
# sudo apt-get install linklint

#####
##### Codi agafat de (Xavier dePedro): https://github.com/xavidp/bpmmirna/blob/master/basicA.R 
#####


setwd(dirPrincipal) ## directori des d'on llançem l'script
if (!file.exists("log")) file.create("log") # creem carpeta log si no existeix
report.filename <- "entrega02022016/Results-A409" # ruta i arxiu a comprobar 


## Llançem programa comprobació links
linkLint.output.files <- list.files(file.path(logsRelDir, "linklint"))
if (length(linkLint.output.files) > 0) {
  remove.out <- file.remove(file.path(logsRelDir, "linklint", linkLint.output.files))
}
system(paste0("linklint ", paste0(report.filename, ".html") ," -doc ", 
              file.path(logsRelDir, "linklint"), " > /dev/null 2>&1"))
linkLint.output.txt.files <- list.files(file.path(logsRelDir, "linklint"), ".txt")
linkLint.error.txt.files <- grep("error", linkLint.output.txt.files, fixed = TRUE )
if (length(linkLint.error.txt.files) > 0) {
  files2load <- file.path(logsRelDir, 
                          "linklint", 
                          linkLint.output.txt.files[linkLint.error.txt.files])
  readLines(files2load[1])
  errorInfo <- apply(data.frame(files2load), 1, FUN = readLines)
  print(errorInfo)
}


