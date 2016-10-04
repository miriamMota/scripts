load("dades/ana_enc_1v.Rdata")
## necessari
percNA <- apply(dat_all[,nameVarSel],2, function(x)(sum(is.na(x))/length(x))*100)
namesPercNA <- names(percNA)[percNA > 10]

for (i in 1:length(namesPercNA))
{
  dat_all[,namesPercNA[i]] <- as.character(dat_all[,namesPercNA[i]])
  dat_all[is.na(dat_all[,namesPercNA[i]]) , namesPercNA[i]]  <- "NSNC"
  dat_all[,namesPercNA[i]] <- as.factor(dat_all[,namesPercNA[i]])
}
data1 <- dat <- dat_all[,c("antecedente_de_sifilis",nameVarSel)]

varExpl1 <- nameVarSel#[!grepl("vhc|a_contacto", nameVarSel) ]
VR1 <- "antecedente_de_sifilis"




## projecte de funcio
stepLR <- function(VR, varExpl, data, var2mod = NA, trace = T  ){
  for (i in 1:length(varExpl)) {
    if (sum(is.na(var2mod)) >= 1) {
      frml <- as.formula( paste(VR, "~", "1"))
      mod <- glm(frml , data =  na.omit(data), family = binomial)
    }else{  
      frml <- as.formula( paste(VR, "~", paste(var2mod,collapse = "+" )))
      mod <- glm(frml , data =  na.omit(data), family = binomial)
      if (trace) cat(as.character(frml),"\n");print(round(tabOR_lr(mod,xtab = F),3))
    }
    
    modvar <- lapply(varExpl[!grepl(paste0(var2mod,collapse = "|"),varExpl)],
                     function(var) {
                       if (sum(is.na(var2mod)) >= 1) {
                         formula    <- as.formula(paste( VR, " ~ ", var))
                       }else{  
                         formula    <- as.formula(paste( VR, " ~ ",paste(var2mod,collapse = "+"),"+", var ))
                       }
                       res.logist <- glm(formula, data =  na.omit(data), 
                                         family = binomial)
                       c(var, res.logist$aic, anova(mod, res.logist,test = "LRT" )$Pr[2])
                     })
    
  
  
  df <- data.frame(matrix(unlist(modvar), nrow = length(modvar), byrow = T),stringsAsFactors = FALSE, row.names = 1)
  colnames(df) <- c("AIC","p_value")
  df$AIC <- as.numeric(df$AIC)
  df$p_value <- as.numeric(df$p_value)
  df_sel <- df[df$p_value < 0.1,]
  #cat("Paso 1")
  if (trace) print(round(df_sel,3))
  varSelStep <- rownames(df)[(df$AIC == min(df$AIC,na.rm = T)) & (df$p_value < 0.1) ]
  var2mod <- c(var2mod, varSelStep )
  var2mod <- na.omit(var2mod)
  if (length(varSelStep) == 0) {
    modfin <- list()
    modfin[[1]] <- glm(as.formula( paste(VR, "~", paste(var2mod,collapse = "+" ) )), data =  na.omit(data), family = binomial)
    modfin[[2]] <- glm(as.formula( paste(VR, "~", paste(var2mod,collapse = "+" ) )), data =  na.omit(data[,c(VR,var2mod)]), family = binomial)
    return(modfin)
    break 
  }
  if (trace) cat( "Variable candidata a entrar", varSelStep,"\n")
  }
}


modfin <- stepLR(VR1,varExpl1, data1)
summary(modfin[[1]])
tabOR_lr(modfin[[1]])

summary(modfin[[2]])
tabOR_lr(modfin[[2]])
