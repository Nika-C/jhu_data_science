

### Caching func ###

makeCacheMatrix <- function(x = matrix()) {
  
  inv <- NULL
  
  set <- function(y){
    x <<- y
    inv <<- NULL
  }
  
  get <- function()x
  
  setInverse <- function(inverse) inv <<- inverse
  getInverse <- function()inv
  
  
  list(set=set, get=get,
       setInverse=setInverse, getInverse=getInverse)
}


### Inverting func ###

cacheSolve <- function(x, ...) {
  
        inv <- x$getInverse()
        
        if(!is.null(inv)){
            message("Getting cached inverse!")
            
          return(inv)
        }
        
        mat <- x$get()
        inv <- solve(mat,...)
        x$setInverse(inv)
        message("Setting inverse to cache.")
        
        return(inv)
}

### Example run ###

set.seed(20180104)
x <- matrix(rnorm(9),nrow=3)
mat <- makeCacheMatrix(x)

mat$get()
###
#[,1]       [,2]       [,3]
#[1,] -0.34609930  0.6666193 -0.4132783
#[2,] -0.06772928 -2.5227779  0.1581954
#[3,]  0.05919220 -0.9422448 -0.3385443

## First run
cacheSolve(mat)

####
#Setting inverse to cache.
#[,1]       [,2]       [,3]
#[1,] -2.25770393 -1.3843557  2.1092109
#[2,]  0.03053113 -0.3187669 -0.1862247
#[3,] -0.47971935  0.6451545 -2.0667365

## Second run
cacheSolve(mat)

####
#Getting cached inverse!
#  [,1]       [,2]       [,3]
#[1,] -2.25770393 -1.3843557  2.1092109
#[2,]  0.03053113 -0.3187669 -0.1862247
#[3,] -0.47971935  0.6451545 -2.0667365