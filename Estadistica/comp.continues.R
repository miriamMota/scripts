
## Compara totes les variables continues que s'indiquin contra totes les variables continues o factor que es vulgui. Utilitza per a 
## continua vs continua cor.test amb els metodes spearman, pearson o kendal. Per a continua vs factor amb dos nivells U Mann Withney 
## i per més de dos nivells kruskall wallis

## var.cont = vector amb el nom de totes les variables CONTINUES a comparar 
## varClin = vector amb el nom de les variables que es volen comparar amb "var.cont". (poden ser continues o factor)
## dat = data.frame que conté les variables var.cont, varClin 
## nround numero de decimals a arrodonir per mostrar la taula amb els pvalors
## correlation TRUE o FALSE. encaran no funciona! per tant sempre FALSE
## corr.meth nom amb el mètode a utilitzar per calcular les correlacions, poden ser: "pearson", "kendall", "spearman"

## Exporta: 
#  taula amb els p.valors (p.val), preparada per mostrar a latex (p.val_xtable) i amb la seva corresponent llegenda (legend)
#  taula amb els p.valors ajustats (p.val.adj), preparada per mostrar a latex (p.val_adj_xtable) i amb la seva corresponent llegenda (legend_adjust)

### PENDENT: per a continua vs factor tenir en compte tests paramètrics si es vol
### PENDENT: eliminar o desenvolupar el parametre correlation!  


comp.continues <- function(var.cont, varClin, dat, nround = 3, correlation = FALSE, corr.meth = "Spearman"){
  res <- list()
  rm(df.res) ;test.us <- NULL
  for (j in 1:length(varClin)) {
    p.val <- NULL; cor.r <- NA; # ;med1 <- NA; med2 <- NA
    for (i in 1:length(var.cont)) {
      if ((class(dat[ ,varClin[j]]) == "integer") | (class(dat[,varClin[j]]) == "numeric")) {
        cr.ts <- cor.test(dat[,var.cont[i]], dat[ ,varClin[j]], method = tolower(corr.meth) )
        if (correlation) {p.val[i] <- paste(cr.ts$estimate, "(", cr.ts$p.value, ")")
        }else {p.val[i] <- cr.ts$p.value}
        test.us[j] <- corr.meth
      }
      
      if ((class(dat[ ,varClin[j]]) == "factor")) {
        if (length(levels(dat[ ,varClin[j]])) == 2 ) {
          wx.ts <- wilcox.test(dat[,var.cont[i]] ~ dat[,varClin[j]] )
          p.val[i] <- wx.ts$p.value
          # aggregate(dat[,var.cont[i]] ~ dat[ ,varClin[j]] , data = dat, FUN= "median" )
          test.us[j] <- "U Mann-Withney"
        }
        if (length(levels(dat[ ,varClin[j]])) > 2 ) {
          kr.ts <- kruskal.test(dat[,var.cont[i]] ~ dat[,varClin[j]] )
          p.val[i] <- kr.ts$p.value
          test.us[j] <- "Kruskal Wallis"
        }
      }
    }
    
    if (!exists("df.res")) {
      df.res <- data.frame( p.val)
      rownames(df.res) <- var.cont
      colnames(df.res)[j] <- ifelse(test.us[j] == corr.meth, 
                                    paste(gsub("_"," ",varClin[j]), "$ _1$"), 
                                    ifelse(test.us[j] == "U Mann-Withney", 
                                           paste(gsub("_"," ",varClin[j]), "$ _2$"), 
                                           paste(gsub("_"," ",varClin[j]), "$ _3$")))
      
    }else{
      df.res <- cbind(df.res, data.frame( p.val))
      colnames(df.res)[j] <- ifelse(test.us[j] == corr.meth, 
                                    paste(gsub("_"," ",varClin[j]), "$ _1$"), 
                                    ifelse(test.us[j] == "U Mann-Withney", 
                                           paste(gsub("_"," ",varClin[j]), "$ _2$"), 
                                           paste(gsub("_"," ",varClin[j]), "$ _3$")))
      
    }
    
  }
  
  df.res.xtab <- apply(df.res,2, function(x) as.character(round(x,nround)))
  df.res.xtab <- ifelse(df.res.xtab < 0.05, paste0("\\colorbox{thistle}{", df.res.xtab, "}"), df.res.xtab)
  rownames(df.res.xtab) <-  rownames(df.res)
  colnames(df.res.xtab) <- colnames(df.res)
  
  
  df.res.adj <- apply(df.res, 2, function(x)p.adjust(x, method = "fdr") )
  df.res.adj.xtab <- apply(df.res.adj,2, function(x) as.character(round(x,nround)))
  df.res.adj.xtab <- ifelse(df.res.adj.xtab < 0.05, paste0("\\colorbox{thistle}{", df.res.adj.xtab, "}"), df.res.adj.xtab)
  rownames(df.res.adj.xtab) <-  rownames(df.res.adj)
  colnames(df.res.adj.xtab) <- colnames(df.res.adj)
  
  res[["p.val"]] <- df.res
  res[["p.val.adj"]] <- df.res.adj
  res[["p.val_xtable"]] <- df.res.xtab
  res[["p.val_adj_xtable"]] <- df.res.adj.xtab
  res[["legend"]] <- paste("1: ",corr.meth,". P-value \\\\ 2: U Mann-Withney. P-value \\\\ 3: Kruskall Wallis. P-value ")
  res[["legend_adjust"]] <- paste("1: ",corr.meth,". Adjust P-value \\\\ 2: U Mann-Withney. Adjust P-value \\\\ 3: Kruskall Wallis. Adjust P-value ")
  return(res)
  
}


bm <- c("proADM24hnmoll", "proADM48hnmoll", "proADM72hnmoll", "PCT24hµgl", "PCT48hµgl", "PCT72hµgl", "CPP24hpmoll", "CPP48Hpmoll", "CPP72hpmoll")
varClin <- c("Sepsis", "Septic_shock","Alive_Hospital","MV_days","ICU_days", "Hospital_days" )

res <- comp.continues(bm,varClin,dat = dat, nround = 3, correlation = FALSE, corr.meth = "Spearman")

# print(xtable(df.res.xtab[,1:3]), size = "small", sanitize.text.function = function(x) x)
print(xtable(res$p.val_xtable, caption = paste("Comparación biomarcadores vs variables clínicas. \\\\ {\\footnotesize",res[["legend"]]), "}"), size = "small", sanitize.text.function = function(x) x)

print(xtable(res$p.val_adj_xtable, caption = paste("Comparación biomarcadores vs variables clínicas. \\\\ {\\footnotesize",res[["legend_adjust"]]), "}"), size = "small", sanitize.text.function = function(x) x)

