## Author: Wajid Jawaid
## Email: wj241@cam.ac.uk
## Date: 14 November 2016

##' Freehand select
##'
##' Freehand select function. First generate a 2D plot using R's plot function, 
##' then select gate region by left clicking. Close polygon by right clicking.
##' The function will return the rownames of the enclosed points by the rownames
##' of th co-ordinates given in \code{data}.
##' @title Freehand select
##' @param data Data frame or matrix of co-ordinates. (x,y) co-ordinates for each
##' point will be on rows. Rownames of selected points will be returned.
##' @param mark Default TRUE. Predicate marking of selected points.
##' @param ... Additional parameters passed to \code{\link{points}}.
##' @return Retunns character vector of rownames of the selected points from \code{data}.
##' @author Wajid Jawaid
##' @export
##' @examples
##' \dontrun{
##' x <- cbind(1:10, 1:10)
##' rownames(x) <- 1:10
##' plot(x, pch = 16, col = "red")
##' fhs(x)
##' }
##' @importFrom graphics locator lines points
fhs <- function(data, mark = TRUE, ...) {
    cat("Mark region on plot.\n")
    if (!(is.data.frame(data) || is.matrix(data))) stop("data must be a data frame or matrix")
    if (is.null(rownames(data))) rownames(data) <- 1:nrow(data)
    sel <- locator(type = "l")
    numPoints <- length(sel$x)
    lines(x = sel$x[c(1, numPoints)], y = sel$y[c(1, numPoints)])
    sel <- as.data.frame(sel)
    xr <- range(sel$x)
    yr <- range(sel$y)
    xPass <- (data[,1] > xr[1]) & (data[,1] < xr[2])
    yPass <- (data[,2] > yr[1]) & (data[,2] < yr[2])
    data <- data[xPass & yPass,]
    inROI <- character()
    for (i in 1:nrow(data)) {
        if (inRegion(as.numeric(data[i,]), sel)) {
            inROI <- c(inROI, rownames(data)[i])
        }
    }
    if (mark) points(data[inROI,1:2], ...)
    attr(inROI, "gate") <- sel
    return(inROI)
}

##' Subfunction
##'
##' Subfunction
##' @title Subfunction for \link{fhs}
##' @param data Vector of (x,y)
##' @param v Data frame of ordered vertices with (x,y) co-ordinates in rows
##' @return Returns logical of whether point is in polygon
##' @author Wajid Jawaid
inRegion <- function(data, v) {
    voi <- data[2] >= v[,2]
    ind <- which(as.logical(abs(diff(c(voi, voi[1])))))
    mod <- nrow(v)                # Modulo system for cycling
    ind0 <- ind - 1
    voi[(c(ind0, ind0+1) %% mod) + 1] <- TRUE
    v <- v[voi,]                        # Only keep edges with at least 1 vertex below poi
    v$b <- data[1] >= v[,1]             # Check poi is inbetween x vals
    v$i <- abs(diff(c(v$b, v$b[1])))
    for (i in which(v$i == 1)) {        # Check poi is above edge at x
        i1 <- i
        i2 <- (i %% nrow(v)) + 1
        if (!all(v[c(i1, i2),2] < data[2])) {
            lsm <- solve(cbind(v[c(i1, i2),1], 1)) %*% matrix(v[c(i1, i2),2], ncol =1)
            lsm <- matrix(c(data[1], 1), 1) %*% lsm
            if (data[2] < lsm) v$i[i1] <- 0
        }
    }
    ifelse((sum(v$i) %% 2) == 1, TRUE, FALSE)
}
