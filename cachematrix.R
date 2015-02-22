## cacheMatrix.R contains 2 functions, makeCacheMatrix and cacheSolve
## makeCacheMatrix is used to create a list of functions to set and retrieve 
## cached matrix values.
## cacheSolve is used to calculate and return the inverse of the matrix and 
## stored the value in cache. 
## On the next invocation of cacheSolve, the function will return the cached 
## value instead of redoing the calculation.

## makeCacheMatrix accepts a matrix and returns a list of functions.
## The list includes functions to get and set the value of matrix and its 
## inverse.
## input: x where x is matrix
## output: list()

## usage: 
## a = makeCacheMatrix(matrix())
## a$set(matrix())
## a$get()
## a$setinverse(solve(matrix()))
## a$getinverse()

makeCacheMatrix <- function(x = matrix()) {
	## initializes value of x and m
	## x: matrix
	## m: inverse of matrix
	m <- NULL
    
	## function set() 
	## re-initializes x and m values if matrix differs from original matrix
	set <- function(y) {
		if (!identical(x,y)) {
			x <<- y
			m <<- NULL    
		}
	}
  
	## function get()
	## returns value of matrix
	get <- function() x
  
	## function setinverse()
	## stores the inverse of matrix into m
	setinverse <- function(inverseMatrix) m <<- inverseMatrix
  
	## function getinverse()
	## returns the value of the inverse of matrix
	getinverse <- function() m
    
	## returns a list of functions
	list(set = set, get = get,
		setinverse = setinverse,
		getinverse = getinverse)
}



## cacheSolve accepts a list of functions created by makeCacheMatrix and 
## returns the inverse of the matrix
## input: x where x is the list of functions created by makeCacheMatrix
## output: m where m is matrix

## usage:
## a = makeCacheMatrix(matrix())
## m = cacheSolve(a)  # performs first calculation and stored value
## m = cacheSolve(a)  # retrieve stored value

cacheSolve <- function(x, ...) {
	## gets the cached value of the inverse of matrix
	m <- x$getinverse()
  
	## if m is not NULL, then we shall return the cached value
	if (!is.null(m)) {
		message("getting cached inverse matrix")
		return(m)
	}
  
	## otherwise we get the matrix value
	data <- x$get()
  
	## perform calculation of the inverse matrix
	## Based on the definition of solve(...), the 2nd parameter may
	## change the value returned by solve. With only a single parameter,
	## solve() assumes the 2nd parameter to be the identity matrix and
	## solve will return the inverse of the matrix (1st parameter).
	## If we had use solve(data, ...), we need to keep track of the 
	## ... values so that we can recalculate the inverse when the 2nd
	## parameter is different.

	m <- solve(data)
  
	## store the value of the inverse of matrix
	x$setinverse(m)
  
	## Return a matrix that is the inverse of 'x'
	return(m)
}
