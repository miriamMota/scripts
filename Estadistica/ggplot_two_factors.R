
############################
## Miriam Mota Foix
## 2016.11.15
############################

ggplot_distr <- function(var1,var2, dat) {
  dat_temp <- dat
  dat_temp <- na.omit(dat_temp[,c(var1,var2)])
  
  test.pct = dat_temp %>% group_by(dat_temp[,var2], dat_temp[,var1])  %>%  summarise(count = n()) 
  test.pct$pct <- test.pct$count/sum(test.pct$count)
  colnames(test.pct) <- c("var2","var1","count","pct")
  ggplot(test.pct, aes(x = var1, y = pct,# colour = var1, 
                       fill = var1)) + 
    xlab("") + ylab("%") +
    scale_fill_discrete(name = var1) +
    geom_bar(stat = "identity",width = .5) +
    facet_grid(. ~ var2) +
    coord_flip() +
    scale_y_continuous(labels = percent, limits = c(0,max(test.pct$pct) + 0.05)) + 
    # geom_text(data = test.pct, aes(label = paste0(round(pct*100,1),"%"),                               y = pct + 0.015), size = 4) +
    geom_text(data = test.pct, aes(label = count,   y = pct + 0.012), size = 4) +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5,hjust = 0.5, size = 6)) +
    theme(legend.position = "bottom")
  # theme(axis.text.x=element_blank())
}
  