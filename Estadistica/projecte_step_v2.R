############################
## Miriam Mota Foix
## 2016.10.04
############################


## projecte de funcio
stepLR <- function(VR, varExpl, data, var2mod = NA, trace = TRUE  ){
  for (i in 1:length(varExpl)) {
    ## Creació de model null o de model inicial
    if (sum(is.na(var2mod)) >= 1) {
      frml <- as.formula( paste(VR, "~", "1"))
      mod <- glm(frml , data =  na.omit(data), family = binomial)
    }else{  
      frml <- as.formula( paste(VR, "~", paste(var2mod,collapse = "+" )))
      mod <- glm(frml , data =  na.omit(data), family = binomial)
      if (trace) {
        cat(paste(VR, "~", paste(var2mod,collapse = " + " )),"\n")
        print(round(tabOR_lr(mod,xtab = F),3))
      }
    }
    
    ## Incloem cadascuna de les variables explicatives una per una i guardem: nom, aic i pvalor de la comparació entre models
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
    
  
  ## Creem taula amb les informacions per a cadascuna de les variables
  df <- data.frame(matrix(unlist(modvar), nrow = length(modvar), byrow = T),stringsAsFactors = FALSE, row.names = 1)
  colnames(df) <- c("AIC","p_value")
  df$AIC <- as.numeric(df$AIC)
  df$p_value <- as.numeric(df$p_value)
  ## Taula amb variables significatives al afegir-les al model
  df_sel <- df[df$p_value < 0.1,]
  if (trace & dim(df_sel)[1] > 0) print(round(df_sel,3))
  
  # Variable candidata a entrar al model
  varSelStep <- rownames(df)[(df$AIC == min(df$AIC,na.rm = T)) & (df$p_value < 0.1) ]
  # Variables explicatives a incloure al model
  var2mod <- c(var2mod, varSelStep )
  var2mod <- na.omit(var2mod)
  
  ## model final. Quan ja no hi ha més variables per entrar o quan no hi ha cap que sigui significativa.
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



data("mtcars")
mtcars$vs <- as.factor(mtcars$vs)
mtcars$am <- as.factor(mtcars$am)
modfin <- stepLR(VR = "vs",varExpl = c("hp", "am", "carb"), data = mtcars, trace = T )
summary(modfin[[1]])
summary(modfin[[2]])
