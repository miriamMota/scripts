installifnot <- function(package) {if (!require(package)) install.packages(package)}
installifnot("gdata")
installifnot("dplyr")

df <- data.frame(name=letters[1:4], value=c(rep(TRUE, 2), rep(FALSE, 2))) # exemple data.frame
target <- c("b", "c", "a", "d") # exemple vector pel qual endreçar
df$name <- reorder.factor(df$name, new.order=target)
df %>% arrange(name)