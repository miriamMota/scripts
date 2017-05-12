
re_name <- function(data){
  names(data) <- gsub(".", "_",gsub("..", ".",gsub("..", ".", names(data),fixed = T), fixed = T),fixed = T)
  names(data) <- gsub("_$","",names(data))
  names(data) <- gsub("^X_","",names(data))
  return(data)
}

