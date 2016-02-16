lapply(c("age","sex","race","service","cancer","renal","inf","cpr","sys","heart","prevad","type","frac","po2","ph","pco2","bic","cre","loc"),

       function(var) {

           formula    <- as.formula(paste("status ~", var))
           res.logist <- glm(formula, data = icu, family = binomial)

           summary(res.logist)
       })
