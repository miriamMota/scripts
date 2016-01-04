############################
## Miriam Mota Foix
## 24.11.2015
############################

require(VennDiagram)

## Funcions necessaries per extreure la llista d'elements 
## tant x com y en tots els casos es una llista de caracters.
Intersect <- function (x) {  
  if (length(x) == 1) {
    unlist(x)
  } else if (length(x) == 2) {
    intersect(x[[1]], x[[2]])
  } else if (length(x) > 2){
    intersect(x[[1]], Intersect(x[-1]))
  }
}

Union <- function (x) {  
  if (length(x) == 1) {
    unlist(x)
  } else if (length(x) == 2) {
    union(x[[1]], x[[2]])
  } else if (length(x) > 2) {
    union(x[[1]], Union(x[-1]))
  }
}

Setdiff <- function (x, y) {
  xx <- Intersect(x)
  yy <- Union(y)
  setdiff(xx, yy)
}



############################
## Venn_diag
############################
###
### filenames = vector de nombres de los ficheros .csv ("topTable")
### pathfile = ruta donde se encuentran los ficheros y donde se dejaran los resultados.
### metPval = nom de la columna utilizada com a criteri de selecció. De normal "Adj.p.val" o "P.value"
### cond2 = nom identificatiu de la condicio 2 de la comparacio(per escollir columnes de mostres que compleixin aixo)
### pval = valor que considerem com a criteri per a seleccionar "features"
### plt =  TRUE / FALSE. si volem que es mostrin els grafics a R directament
### pltPdf = TRUE / FALSE. Per generar gràfics en pdf
### eul = TRUE / FALSE. Generar grafic de euler (similar al de Venn pero mida de cercles proporcional a "features")
### csv= TRUE / FALSE. Genera les llistes amb elements comuns
###
### Generar diagrames de Venn i Euler. Amb les corresponents llistes d'elements que es troben a cada regió dels diagrames
###
############################

VennEul_diag <- function(filenames,pathfile,metPval,pval,plt=TRUE,pltPdf=TRUE,eul=FALSE,csv=TRUE){
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
  venn.plot <- venn.diagram(list_genes_sel,
                            category.names = compName,
                            fill = rainbow(length(compName)),
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
    set <- NULL
    for (i in 1: length(compName)){
      set <- c(set, rep(compName[i],length(list_genes_sel[[i]])))
    }  
    v <- venneuler(data.frame(elements=c(unlist(list_genes_sel)), 
                              sets= set))
    if(pltPdf){
      pdf(paste0(pathfile,"VennEuler",metPval,pval,".pdf"))
      plot(v)
      dev.off()
    }
    if(plt){plot(v)}
  }
  
  names(list_genes_sel) <- compName
  combs <-  unlist(lapply(1:length(list_genes_sel), 
                          function(j) combn(names(list_genes_sel), j, simplify = FALSE)),
                   recursive = FALSE)
  names(combs) <- sapply(combs, function(i) paste0(i, collapse = ""))
  #str(combs)
  
  elements <- lapply(combs, function(i) Setdiff(list_genes_sel[i], list_genes_sel[setdiff(names(list_genes_sel), i)]))
  n.elements <- sapply(elements, length)
  list_res <- list(elements= elements, n.elements=n.elements) 
  
  
  seq.max <- seq_len(max(n.elements))
  mat <- sapply(elements, "[", i = seq.max)
  mat[is.na(mat)] <- ""
  vennElements <- rbind(t(data.frame(n.elements)),data.frame(mat))
  
  if(csv) {
    write.csv(vennElements,file="results/VennElements.csv",row.names=FALSE)
  }
  return(vennElements)
}


#a <-VennEul_diag (filenames = c("TopTable.T1.vs.C.csv","TopTable.T2.vs.C.csv","TopTable.T2.vs.T1.csv","TopTable.T.vs.C.csv"),
#                  pathfile = "results/",
#                  metPval = "Adj.p.val",
#                  pval = 0.05 ,
#                  eul=TRUE)
