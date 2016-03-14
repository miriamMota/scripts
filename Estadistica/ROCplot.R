require(pROC)
doROCwithAUC <- function(frml, titol)
{
  mod <- glm(frml , family = binomial, na.action = "na.omit")
  pred <- predict(mod, type = "response")  
  rocobj <- plot.roc(mod$y, pred,  main = titol, ci = TRUE, 
                     percent = TRUE, print.thres = "best") 
  ciobj <- ci.se(rocobj, boot.n = 100,progress = "none")
  plot(ciobj, type = "shape", col = "#aaddddAA") # plot as a blue shape
  plot(ci(rocobj, of = "thresholds", thresholds = "best",progress = "none"), col = "red")
  ic <- rocobj$ci
  auc_text <- paste(round(ic[2],2), "% (", 
                    round(ic[1],1), " - ", 
                    round(ic[3],1), "%)", sep = "")
  p.val <- summary(mod)$coef[,4][2]
  text(40, 5, 
       paste("AUC:", auc_text), #"\n p-val:", round(p.val,2)),
       #paste("AUC:", round(ic[2],1), "%", "(",round(ic[1],1), 
       #      "%", "-", round(ic[3],1), "%", ")\n p-val:", round(p.val,5)),
       cex = .8)
  
}
