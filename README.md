Select points by drawing a freehand gate
================
Wajid Jawaid
2016-11-17

<!-- README.md is generated from README.Rmd. Please edit that file -->


Installation
============

**gatepoints** can be installed from Github or through CRAN (Not yet on CRAN).

Github
------

``` {.r}
library(devtools)
install_github("wjawaid/gatepoints")
```

CRAN
----

Once available on CRAN, the package can be downloaded using

``` {.r}
install.packages("gatepoints")
```

Usage example
=============

**gatepoints** provides an easy to use function, **fhs** (freehand select) for gating or selecting points freehand on a plot. Take the simple plot below:

``` {.r}
x <- data.frame(x=1:10, y=1:10, row.names = 1:10)
plot(x, pch = 16, col = "red")
```

![Simple plot.](README-unnamed-chunk-4-1.png)

``` {.r}
library(gatepoints)
selectedPoints <- fhs(x, mark = TRUE)
```

To select an arbitrarily complex region run the above commands and proceed as follows:

1.  Mark region of your choice by **left clicking** around your region of interest.
2.  Close polygon by **right clicking**. On the Windows platform click **stop** after right clicking.

![Selected points](README-unnamed-chunk-7-1.png)

The points can be marked as defined by the user with additional parameters passed to the **points** function. The names of the points as given by the rownames of the data frame **x** will be returned in **selectedPoints**. Additionally the points selected for the gate will be returned as the **gate** attribute.

``` {.r}
selectedPoints
#> [1] "4" "5" "7"
#> attr(,"gate")
#>          x        y
#> 1 6.099191 8.274120
#> 2 8.129107 7.048649
#> 3 8.526881 5.859404
#> 4 5.700760 6.716428
#> 5 5.605314 5.953430
#> 6 6.866882 3.764390
#> 7 3.313575 3.344069
#> 8 2.417270 5.217868
```
