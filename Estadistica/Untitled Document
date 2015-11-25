############################
## Miriam Mota Foix
## 24.11.2015
############################

############################
## tabOR
############################
###
### mod = model de regressió logística (sense el summary)
###
### Generar taula amb els coeficients OR , intervals de confiança i p-valors
###
############################

tabOR <- function(mod){
  ORcoef <- exp(mod$coeff) ## OR 
  infORcoef <- exp(confint(mod))[,1] ## IC dels OR 
  supORcoef <- exp(confint(mod))[,2]
  p.val <- summary(mod)$coef[,4]
  tauORcoef <- data.frame(ORcoef, infORcoef,supORcoef,p.val)
  colnames(tauORcoef) <- c("OR", "IC inferior", "IC superior","P.valor")
  xtable(tauORcoef,caption="OR dels coeficients",digits=2)
}