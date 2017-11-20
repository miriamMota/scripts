factorDat <- data.frame(Fumador = c(rep("SI",5), "SI","SI", "Si", rep("NO",5),"NO ","No", ""),
                        Trasplant =  rep(c("Dreta","derecha", "Esquerre", "Izquierda"),4),
                        Estadi = c("E1","E1","e1","e2","e3","e3", "E3","e1","e2","e3","e1","e2","e3","e2","e3","e3") )

save(factorDat, file = "data/factorDat.rda")
