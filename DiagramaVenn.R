Intersect <- function (x) {  
  # Multiple set version of intersect
  # x is a list
  if (length(x) == 1) {
    unlist(x)
  } else if (length(x) == 2) {
    intersect(x[[1]], x[[2]])
  } else if (length(x) > 2){
    intersect(x[[1]], Intersect(x[-1]))
  }
}

Union <- function (x) {  
  # Multiple set version of union
  # x is a list
  if (length(x) == 1) {
    unlist(x)
  } else if (length(x) == 2) {
    union(x[[1]], x[[2]])
  } else if (length(x) > 2) {
    union(x[[1]], Union(x[-1]))
  }
}

Setdiff <- function (x, y) {
  # Remove the union of the y's from the common x's. 
  # x and y are lists of characters.
  xx <- Intersect(x)
  yy <- Union(y)
  setdiff(xx, yy)
}

require(VennDiagram) # XXXXXX
require(venneuler)   # XXXXXX


Venn_diag_3 <- function(filenames,pathfile,metPval,pval,plt=TRUE,pltPdf=TRUE,eul=FALSE){
  files <- list()
  list_genes_sel <- list()
  for (i in 1:length(filenames)){
    files[[i]] <-  read.csv(paste0(pathfile, filenames[i]))
    colpval <- which(names(files[[i]]) == metPval)
    list_genes_sel[[i]] <- as.character(files[[i]]$X[files[[i]][,colpval] < pval])
    }
  mainTitle <- paste0("Venn diagram (" , metPval, " < ", pval,")")
  
  ## Creating Venn Diagram
  compName <- paste0(substr(filenames, start=10, stop=17),"_")
  venn.plot <- venn.diagram(list(A = list_genes_sel[[1]],
                                 B = list_genes_sel[[2]],
                                 C = list_genes_sel[[3]]),
                            category.names = compName,
                            fill = rainbow(3),
                            #fill = c("tomato", "orchid4", "turquoise3"),
                            alpha = 0.50,
                            resolution = 600,
                            cat.cex = 0.9,
                            main = mainTitle,
                            filename = NULL)
  
  if(pltPdf){
    pdf(paste0(pathfile,"VennDiagram",metPval,pval,".pdf"))
    grid.draw(venn.plot)
    dev.off()
  }
  if(plt){grid.draw(venn.plot)}
  
  if(eul){
    v <- venneuler(data.frame(elements=c(unlist(list_genes_sel)), 
                              sets= c(rep(compName[1],length(list_genes_sel[[1]])),
                                      rep(compName[2],length(list_genes_sel[[2]])),
                                      rep(compName[3],length(list_genes_sel[[3]])))))
    if(pltPdf){
      pdf(paste0(pathfile,"VennEuler",metPval,pval,".pdf"))
      plot(v)
      dev.off()
    }
    if(plt){plot(v)}
  }
  
  xx.1 <- list(list1,list2,list3)
  names(xx.1) <- compName
  combs <-  unlist(lapply(1:length(xx.1), 
                          function(j) combn(names(xx.1), j, simplify = FALSE)),
                   recursive = FALSE)
  names(combs) <- sapply(combs, function(i) paste0(i, collapse = ""))
  #str(combs)
  
  elements <- lapply(combs, function(i) Setdiff(xx.1[i], xx.1[setdiff(names(xx.1), i)]))
  n.elements <- sapply(elements, length)
  list_res <- list(elements= elements, n.elements=n.elements) 
  return(list_res)
}


#a <-Venn_diag_3 (c("TopTable.T1.vs.C.csv","TopTable.T2.vs.C.csv","TopTable.T2.vs.T1.csv"),
#                    "results/", "Adj.p.val", 0.05 ,eul=TRUE)



