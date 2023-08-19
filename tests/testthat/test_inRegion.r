context("In Region")

test_that("applyGate correctly identifies point within region", {
    t1 <- applyGate(matrix(c(0,0), 1), rbind.data.frame(c(1,1), c(-1,1), c(-1,-1), c(1,-1)))
    t2 <- applyGate(matrix(c(2,2), 1), rbind.data.frame(c(1,1), c(-1,1), c(-1,-1), c(1,-1)))
    expect_true(t1)
    expect_false(t2)
})
