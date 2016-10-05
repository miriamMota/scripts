############################
## Miriam Mota Foix
## 2016.10.05
############################


## IMPORTANTE: Es importante el orden en el que se indican los niveles. 
## Por ejemplo: si un individuo puede tener en las distintas variables positivo negativo y dudoso
## y consideraremos que si tiene dudoso su nuevo nivel es dudoso, pero en el caso de que sea positivo 
## cambiara de categoria, deberemos indicar el el df_lev el orden de los niveles como: negativo, dudoso y positvo

## var_con vector tipo caracter con el nombre de las variables a tener en cuenta
## dat data frame donde se encuentran dichas variables
## df_lev dataframe de dos columnas, donde en la primera tendremos los posibles niveles de las variables y en la segunda el nuevo nivel que se le asignara a la variable que creemos

new_var_cat <- function(dat, var_con, df_lev){
  name_new_var <- "new_var"
  pos_lev <- list()
  for (i in 1:length(var_con)) {
    for (j in 1:length(df_lev[,1])) {
      name_poslev <- as.character(df_lev[,1][j])
      pos_lev[[name_poslev]] <- c(pos_lev[[name_poslev]], grep(df_lev[,1][j],dat[,var_con[i]]))
    }
  }
  
  
  dat[,name_new_var] <- NA
  for (i in 1:length(pos_lev)) {
    dat[,name_new_var][unique(pos_lev[[i]])] <- as.character(df_lev[,2][i])
  }
  #dat[,name_new_var] <- as.factor(dat[,name_new_var])
  return(c(dat[,name_new_var]) )
}


## IMPORTANTE: Es importante el orden en el que se indican los niveles. 
## Por ejemplo: si un individuo puede tener en las distintas variables positivo negativo y dudoso
## y consideraremos que si tiene dudoso su nuevo nivel es dudoso, pero en el caso de que sea positivo 
## cambiara de categoria, deberemos indicar el el df_lev el orden de los niveles como: negativo, dudoso y positvo


## Ejemplo
aa <- as.factor(c("si","si","no","si","no"))
bb <- as.factor(c("si","una","no","si","no"))
cc <- as.factor(c("si","una","una","si","no"))
dat1 <- data.frame(aa,bb,cc)
var_con1 <- c("aa","bb","cc")
df_lev1 <- data.frame(levels(dat[,var_con[2]]),c("No","Si","Si") )
name_new_var1 <- "nova_variable1"

dat1$new <- new_var_cat(dat = dat1, var_con = var_con1, df_lev = df_lev1)
dat1
#View(data.frame(dat$new_var,dat$nova_variable1))




