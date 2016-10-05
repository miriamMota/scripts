
dat <- dat_2v
var_con <- var_inf_concom
lev <- levels(dat[,var_con[1]])
name_new_var <- "new_var"



new_var_cat <- function(dat, var_con, df_lev, name_new_var){
  pos_lev <- list()
  for (i in 1:length(var_con)) {
    for (j in 1:length(df_lev[,1])) {
      pos_lev[[as.character(df_lev[,1][j])]] <- c(pos_lev[[as.character(df_lev[,1][j])]], grep(df_lev[,1][j],dat[,var_con[i]]))
    }
  }
  
  
  dat[,name_new_var] <- NA
  for (i in 1:length(pos_lev)) {
    dat[,name_new_var][unique(pos_lev[[i]])] <- as.character(df_lev[,2][i])
  }
  #dat[,name_new_var] <- as.factor(dat[,name_new_var])
  return(c(dat[,name_new_var]) )
}


aa <- as.factor(c("si","si","no","si","no"))
bb <- as.factor(c("si","una","no","si","no"))
cc <- as.factor(c("si","una","una","si","no"))
dat1 <- data.frame(aa,bb,cc)
var_con1 <- c("aa","bb","cc")
df_lev1 <- data.frame(levels(dat[,var_con[2]]),c("No","Si","Si") )
name_new_var1 <- "nova_variable1"

new_var_cat(dat = dat1, var_con = var_con1, df_lev = df_lev1, name_new_var = name_new_var1)
#View(data.frame(dat$new_var,dat$nova_variable1))




