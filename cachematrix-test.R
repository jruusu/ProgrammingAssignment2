#
# Tests for R Programming / Programming Assignment 2: Lexical Scoping
#

# Source the implementation
source("cachematrix.R")

# Contain tests in an anonymous function to avoid polluting the global environment
(function() {
  
  # Runs the specified test function and prints out the result
  run_test <- function(test) {
    result <- test()  
  
    if(identical(result$expected, result$observed)) {
      print(paste("PASS", result$test, collapse=" "))
    } else {
      print(paste("FAIL", result$test, collapse=" "))
      print(result[c("expected", "observed")])
    }
  
  }
  
  # Define tests
  tests <- c(
    function () {
      list(
        test = "makeCacheMatrix returns a list",
        expected = class(list()),
        observed = class(makeCacheMatrix())
      )
    },
    function () {
      list(
        test = "solution is initially not cached",
        expected = FALSE,
        observed = makeCacheMatrix()$is_cached()
      )
    },
    function () {
      list(
        test = "decorator's solve() returns inverse of a 2x2 matrix",
        expected = matrix(c(-2,3,3,-4), 2, 2),
        observed = makeCacheMatrix(matrix(c(4,3,3,2), 2, 2))$solve()
      )
    },
    function () {
      cacheMatrix <- makeCacheMatrix(matrix(c(4,3,3,2), 2, 2))
      cacheMatrix$solve()
      
      list(
        test="decorator's solve() result is cached",
        expected = TRUE,
        observed = cacheMatrix$is_cached()
      )
    },
    function () {
      list(
        test = "cacheSolve returns the inverse of a decorated 2x2 matrix",
        expected = matrix(c(-2,3,3,-4), 2, 2),
        observed = cacheSolve(makeCacheMatrix(matrix(c(4,3,3,2), 2, 2)))
      )
    }
  )
  
  # Run tests
  lapply(tests, run_test)

})()
