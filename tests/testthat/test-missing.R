tmp <- mtcars
tmp$am <- as.logical(tmp$am)
for (i in seq_along(tmp)) {
    tmp[[i]][sample(1:nrow(tmp), 1)] <- NA
}

test_that("original data with NAs do not pose problems in glm and lm.", {
    mod1 <- lm(hp ~ mpg + drat + wt + factor(gear), data = tmp)
    mod2 <- glm(vs ~ mpg + drat + wt + factor(gear), data = tmp, family = binomial)
    expect_s3_class(tidy(marginaleffects(mod1)), "data.frame")
    expect_s3_class(tidy(marginaleffects(mod2)), "data.frame")
})

test_that("newdata with NAs do not pose problems in lm.", {
    mod <- lm(hp ~ mpg + drat + wt + factor(gear), data = tmp)

datagrid(model = mod, drat = c(NA, 10))

    mfx <- marginaleffects(mod, newdata = datagrid(drat = c(NA, 10)))
    expect_s3_class(tidy(mfx), "data.frame")
})
