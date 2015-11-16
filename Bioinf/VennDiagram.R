###################################################
###################################################
## COMPARISONS BETWEEN CASES
###################################################
## ---- To be executed after doing analysis with
## ----  all, females and males
###################################################
## ------------------------------------------------
##  DATA FROM selected.KEGG...csv FILES
##    AND selected.GO...csv FILES
##  MUST BE LOADED (fins que tinguem la funcio xula feta)

library(VennDiagram)

## ------------------------------------------------
## OVERLAPPING OF DOWN-REGULATED KEGG PATHWAYS
file1 <- read.csv("results/TopTable.T1.vs.C.csv")
list1 <- as.character(file1$X[file1$Adj.p.val < 0.05])

file2 <- read.csv("results/TopTable.T2.vs.C.csv")
list2 <- as.character(file2$X[file1$Adj.p.val < 0.05])

file3 <- read.csv("resfile3TopTable.T2.vs.T1.csv")
list3 <- as.character(file3$X[file1$Adj.p.val < 0.05])

mainTitle <- "Venn diagram (Adj.P.val < 0.05)"

## Creating Venn Diagram
venn.plot <- venn.diagram(list(A = list1,
                               B = list2,
                               C = list3),
                          category.names = c("T1.vs.C", "T2.vs.C", "T2.vs.T1"),
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
