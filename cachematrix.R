## These functions provide memoized matrix inversion

## Returns the specified, invertible matrix in a wrapper (decorator)
## that provides a memoized (cached) access to its inverse
## via the solve() function.
## 
## Additionally, the function is_cached() is exposed to allow testing
## the caching behaviour of the decorator.
##
makeCacheMatrix <- function(x = matrix()) {
  cached_solution <- NULL

  solve_memoized <- function() {
    if (is.null(cached_solution)) {
      cached_solution <<- solve(x)
    }
    cached_solution
  }

  list(
    is_cached = function() !is.null(cached_solution),
    solve = solve_memoized
  )
}

## Takes a matrix decorated by the makeCacheMatrix function
## and returns its inverse, using the solve() function.
## 
## Note: This function is redundant, and exists only to match
## the assignment. All the beef is in makeCacheMatrix().
##
cacheSolve <- function(x) {
  x$solve()
}
