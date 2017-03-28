stata_Rwin_to_Rlinux <- function(df){
  id_var <- grep("var",names(df))
  names(df)[id_var] <- attr(df, "var.labels")[id_var]
  names(df) <- iconv(names(df), "latin1", "UTF-8")
  names(df) <- gsub(" ","_",names(df))
  names(df) <- gsub("/","_",names(df))
  names(df) <- gsub("-","_",names(df))
  return(df)
}

# dat_enc <- read.dta("dades/pri_20170327/encuesta_conductual.dta")
# dat_1v <- stata_Rwin_to_Rlinux(dat_1v)
