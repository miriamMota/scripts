#' A multGGplot Function
#'
#' Similar a par(mfrow=c(row,col)) para "ggplot"
#' @param plots separados por coma
#' @param cols número de columnas
#' @keywords multiGGplot
#' @export
#' @examples
#' multGGplot(plot1,plot2,plot3,plot4, cols=2)

multGGplot <- function(..., plotlist = NULL, file, cols = 1, layout = NULL) {
  install_github('miriamMota/scripts/installifnot')
  installifnot(grid)
  
  plots <- c(list(...), plotlist)
  numPlots = length(plots)
  
  if (is.null(layout)) {
      layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  if (numPlots == 1) {
      print(plots[[1]])
  } else {
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    for (i in 1:numPlots) {
      
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

