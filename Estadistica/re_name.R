
re_name <- function(dat){
  names(dat) <- gsub(".", "_",gsub("..", ".",gsub("..", ".", names(dat),fixed = T), fixed = T),fixed = T)
  names(dat) <- gsub("_$","",names(dat))
  names(dat) <- gsub("^X_","",names(dat))
}