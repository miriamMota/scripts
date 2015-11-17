###################################################
## Venn Diagram
###################################################

library(VennDiagram)

## ------------------------------------------------
## Seleccio toptables i llistat de genes
file1 <- read.csv("results/TopTable.T1.vs.C.csv")
list1 <- as.character(file1$X[file1$Adj.p.val < 0.05])

file2 <- read.csv("results/TopTable.T2.vs.C.csv")
list2 <- as.character(file2$X[file1$Adj.p.val < 0.05])

file3 <- read.csv("resfile3TopTable.T2.vs.T1.csv")
list3 <- as.character(file3$X[file1$Adj.p.val < 0.05])

mainTitle <- "Venn diagram (Adj.P.val < 0.05)" ## Titol

## Creació Venn Diagram
venn.plot <- venn.diagram(list(A = list1,
                               B = list2,
                               C = list3),
                          category.names = c("T1.vs.C", "T2.vs.C", "T2.vs.T1"), ## Comparacions
                          fill = rainbow(3),
                          #fill = c("tomato", "orchid4", "turquoise3"),
                          alpha = 0.50,
                          resolution = 600,
                          cat.cex = 0.9,
                          main = mainTitle,
                          filename = NULL)
pdf(paste(mainTitle,"pdf",sep="."))
grid.draw(venn.plot)
dev.off()
