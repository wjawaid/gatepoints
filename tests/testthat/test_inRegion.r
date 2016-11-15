context("In Region")

test_that("inRegion correctly identifies point within region", {
    t1 <- inRegion(c(0,0), rbind.data.frame(c(1,1), c(-1,1), c(-1,-1), c(1,-1)))
    t2 <- inRegion(c(2,2), rbind.data.frame(c(1,1), c(-1,1), c(-1,-1), c(1,-1)))
    expect_that(t1, is_true())
    expect_that(t2, is_false())
})
