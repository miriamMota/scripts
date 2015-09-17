# Adding percentage to bar plots:
mybars <- function(factor, dec = 0, color = 7)
{
  x <- summary(factor)
  l <- length(x)
  perc <- round(100 * x / sum(x), dec)
  info <- paste(perc, "%", sep = "")
  barplot(x, main = label(factor), ylab="Frequency", col = color)
  text(1.2 * (0:(l - 1)) + 0.7, x / 2, info)
}