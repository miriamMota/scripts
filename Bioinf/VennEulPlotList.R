############################
## Miriam Mota Foix
## 04.01.2016
############################

require(VennDiagram)

## Funcions necessaries per extreure la llista d'elements 
## tant x com y en tots els casos es una llista de caracters.
Intersect <- function(x) {  
  if (length(x) == 1) {
    unlist(x)
  } else if (length(x) == 2) {
    intersect(x[[1]], x[[2]])
  } else if (length(x) > 2) {
    intersect(x[[1]], Intersect(x[-1]))
  }
}

Union <- function(x) {  
  if (length(x) == 1) {
    unlist(x)
  } else if (length(x) == 2) {
    union(x[[1]], x[[2]])
  } else if (length(x) > 2) {
    union(x[[1]], Union(x[-1]))
  }
}

Setdiff <- function(x, y) {
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
### eul = TRUE / FALSE. Generar grafic de euler (similar al de Venn pero mida de cercles proporcional a número de "features")
### venn = TRUE / FALSE. Generar diagrama de venn
### csv= TRUE / FALSE. Genera les llistes amb elements comuns
### comp = string amb el nom de la comparacio amb la que es guardaran els arxius
### posStart = numero. Posicio on comença a tallar el nom de l'arxiu per guardar la comparacio
### posStop = numero. Posicio on acaba de tallar el nom de l'arxiu per guardar la comparacio
### colFeat = string del nom de la colummna on estan els features (Gens, mirna, proteines, etc)
### sepcsv = separador de camps al csv
### deccsv = "." o "," segons com estiguin separats els decimals
### 
### Generar diagrames de Venn i Euler. Amb les corresponents llistes d'elements que es troben a cada regió dels diagrames
###
############################

VennEul_diag <- function(filenames, pathfile, metPval, pval, comp = "", posStart = 9, posStop = 18,
                         colFeat = "X", sepcsv = ",", deccsv = ".",
                         plt = TRUE, pltPdf = TRUE, venn = TRUE, eul = FALSE, csv = TRUE){
  require(VennDiagram)
  files <- list()
  list_genes_sel <- list()
  for (i in 1:length(filenames)) {
    files[[i]] <-  read.csv(paste0(pathfile, filenames[i]),sep = sepcsv ,dec = deccsv)
    colpval <- which(names(files[[i]]) == metPval)
    colFeature <- which(names(files[[i]]) == colFeat)
    list_genes_sel[[i]] <- as.character(files[[i]][,colFeat][files[[i]][,colpval] < pval])
  }
  mainTitle <- paste0("Venn diagram (" , metPval, " < ", pval,")")
  
  ## Creating Venn Diagram
  compName <- paste0(substr(filenames, start = posStart, stop = posStop),"_")
  if (venn) {
    venn.plot <- venn.diagram(list_genes_sel,
                              category.names = compName,
                              fill = rainbow(length(compName)),
                              #fill = c("tomato", "orchid4", "turquoise3"),
                              alpha = 0.50,
                              resolution = 600,
                              cat.cex = 0.9,
                              main = mainTitle,
                              filename = NULL)
    
    if (pltPdf) {
      pdf(paste0(pathfile,"VennDiagram",metPval,pval,comp,".pdf"))
      grid.draw(venn.plot)
      dev.off()
    }
    if (plt) {grid.draw(venn.plot)}
  }
  
  if (eul) {
    require(venneuler)
    set <- NULL
    for (i in 1:length(compName)) {
      set <- c(set, rep(compName[i],length(list_genes_sel[[i]])))
    }  
    v <- venneuler(data.frame(elements = c(unlist(list_genes_sel)), 
                              sets = set))
    if (pltPdf) {
      pdf(paste0(pathfile,"VennEuler",metPval,pval,comp,".pdf"))
      plot(v, main = paste0("Euler diagram (" , metPval, " < ", pval,")"))
      dev.off()
    }
    if (plt) {plot(v,main = paste0("Euler diagram (" , metPval, " < ", pval,")"))}
  }
  
  names(list_genes_sel) <- compName
  combs <-  unlist(lapply(1:length(list_genes_sel), 
                          function(j) combn(names(list_genes_sel), j, simplify = FALSE)),
                   recursive = FALSE)
  names(combs) <- sapply(combs, function(i) paste0(i, collapse = ""))
  #str(combs)
  
  elements <- lapply(combs, function(i) Setdiff(list_genes_sel[i], list_genes_sel[setdiff(names(list_genes_sel), i)]))
  n.elements <- sapply(elements, length)
  list_res <- list(elements = elements, n.elements = n.elements) 
  
  
  seq.max <- seq_len(max(n.elements))
  mat <- sapply(elements, "[", i = seq.max)
  mat[is.na(mat)] <- ""
  vennElements <- rbind(t(data.frame(n.elements)),data.frame(mat))
  
  if (csv) {
    write.csv(vennElements,file = paste0("results/VennElements.",comp,".csv"), row.names = FALSE)
  }
  return(vennElements)
}

# a <- VennEul_diag(filenames = c("topTableOvar.PosvsAden.Pos.csv","topTableOvar.PosvsDeep.Pos.csv","topTableOvar.PosvsPelv.Pos.csv",
#                            "topTablePelv.PosvsAden.Pos.csv","topTablePelv.PosvsDeep.Pos.csv","topTableAden.PosvsDeep.Pos.csv"),
#              pathfile = "results/",
#              metPval = "P.Value",
#              pval = 0.01 ,
#              eul = TRUE,
#              venn = FALSE,
#              comp = "Endo.Pos",
#              posStop = 26,
#              sepcsv = "\t",
#              deccsv = ",",
#              colFeat = "Name")
