# bootstrap wilcox y AUC

require(boot)

bs.auc <- function(formula, data, indices) {
  d <- data[indices,] # allows boot to select sample 
  roc <- roc(formula,data=d)
  return(roc$auc) 
}

bs.wilcox <- function(formula, data, indices) {
  d <- data[indices,] # allows boot to select sample 
  test <- wilcox.test(formula, data=d)
  return(test$p.value) 
} 

# set.seed(81)
# results.wilcox <- boot(data=BD, statistic=bs.wilcox, R=1000, formula=proADM.72h~PGD72h_g3)
# paste("Median = ",round(median(results.wilcox$t),3))
# round(quantile(results.wilcox$t,probs=c(0.05,0.95)),3)