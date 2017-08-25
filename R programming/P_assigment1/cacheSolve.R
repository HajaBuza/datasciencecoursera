# Function that solve the cache matrix

cacheSolve <- function(x,...){
     # get an Inverse of matrix 
     Inversematrix <- x$getInverse()
     # check matrix if Inverse exist return message
     if(!is.null(Inversematrix)) {
          message("getting cached data")
          return(Inversematrix)
     }
     # get matrix from makeCacheMatrix
     data <- x$get()
     Inversematrix <- solve(data) %*% datas
     x$setInverse(Inversematrix)
     Inversematrix
}