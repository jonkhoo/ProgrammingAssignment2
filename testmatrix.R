## This contains the test file for cachematrix.R
source("cachematrix.R")

## Generate the matrix
size <- 1000
m <- matrix(rnorm(size^2), nrow=size, ncol=size)

## Calculate the inverse matrix and the time taken for calculation
print("Calling solve()")
print("a1 <- solve(m)")
s<-system.time(a1 <- solve(m))
print(s)

## Make matrix and perform cachesolve
b <- makeCacheMatrix(m)
print("Calling cacheSolve()")
print("a2 <- cacheSolve(b)")
s<-system.time(a2 <- cacheSolve(b))
print(s)

## Perform cachesolve another time
print("Calling cacheSolve() second time")
print("a3 <- cacheSolve(b)")
s<-system.time(a3 <- cacheSolve(b))
print(s)

## Test whether the answers match
print("Testing the matrix")
print("a1 == a2 && a1 == a3")
s<-identical(a1, a2) & identical(a1, a3)
print(s)
