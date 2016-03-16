require(pROC)
doROCwithAUC <- function(frml, titol,validation = FALSE, test, test_y)
{
  mod <- glm(frml , family = binomial, na.action = "na.omit")

  pred <- predict(mod, type = "response")  
  
  rocobj <- plot.roc(mod$y, pred,  main = titol, ci = TRUE, 
                     percent = TRUE, print.thres = "best") 
  thres <- rocobj$sensitivities - (1 - rocobj$specificities)
  thres.best <- rocobj$thresholds[which(thres == max(thres))] # threshold  de Youden
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
    
  
  if (validation) {
   pred <- predict(mod, newdata = test, type = "response")  
   tab.pred <- table(ifelse(pred >  thres.best, levels(test_y)[2],levels(test_y)[1]), test_y)
  misc.test <- 1  - (sum(diag(tab.pred))/sum(tab.pred))
  return(list(auc = auc_text, pvalue = p.val, thres.best = thres.best, misc.test = misc.test))
  }
  if (!validation) return(list(auc = auc_text, pvalue = p.val, thres.best = thres.best))
}
