
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
data <- dat <- dat_all[,c("antecedente_de_sifilis",nameVarSel)]

varExpl <- nameVarSel#[!grepl("vhc|a_contacto", nameVarSel) ]
VR <- "antecedente_de_sifilis"




## projecte de funcio
var2mod <- NULL
nullmod <- glm(as.formula( paste(VR, "~", "1")), data =  na.omit(data), family = binomial)
unimod <- lapply(varExpl,
                 function(var) {
                   
                   formula    <- as.formula(paste( VR, " ~ ", var))
                   res.logist <- glm(formula, data =  na.omit(data), 
                                         family = binomial)
                   c(var, res.logist$aic, anova(nullmod, res.logist,test = "LRT" )$Pr[2])
                 })



df <- data.frame(matrix(unlist(unimod), nrow = length(unimod), byrow = T),stringsAsFactors = FALSE, row.names = 1)
colnames(df) <- c("AIC","p_value")
df$AIC <- as.numeric(df$AIC)
df$p_value <- as.numeric(df$p_value)
df_sel <- df[df$p_value < 0.1,]
print(round(df_sel,3))
cat( "Variable candidata a entrar", rownames(df)[(df$AIC == min(df$AIC)) & (df$p_value < 0.1) ])
var2mod <- rownames(df)[(df$AIC == min(df$AIC)) & (df$p_value < 0.1) ]


for (i in 1:length(varExpl)) {
mod <- glm(as.formula( paste(VR, "~", paste(var2mod,collapse = "+" ) )), data =  na.omit(data), family = binomial)
print(round(tabOR_lr(mod,xtab = F),3))
modvar <- lapply(varExpl[!grepl(paste0(var2mod,collapse = "|"),varExpl)],
                 function(var) {
                   
                   formula    <- as.formula(paste( VR, " ~ ",paste(var2mod,collapse = "+"),"+", var ))
                   res.logist <- glm(formula, data =  na.omit(data), 
                                     family = binomial)
                   c(var, res.logist$aic, anova(mod, res.logist,test = "LRT" )$Pr[2])
                 })



df <- data.frame(matrix(unlist(modvar), nrow = length(modvar), byrow = T),stringsAsFactors = FALSE, row.names = 1)
colnames(df) <- c("AIC","p_value")
df$AIC <- as.numeric(df$AIC)
df$p_value <- as.numeric(df$p_value)
df_sel <- df[df$p_value < 0.1,]
print(round(df_sel,3))
varSelStep <- rownames(df)[(df$AIC == min(df$AIC)) & (df$p_value < 0.1) ]
var2mod <- c(var2mod, varSelStep )
if (length(varSelStep) == 0) {
  print(glm(as.formula( paste(VR, "~", paste(var2mod,collapse = "+" ) )), data =  na.omit(data), family = binomial))
  break 
  }

cat( "Variable candidata a entrar", varSelStep)

}