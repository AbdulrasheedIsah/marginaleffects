skip_if(getRversion() < 4.1) # different graphics engines
skip_on_ci()
skip_on_cran()

test_that("plot_cme(mod, 'hp', 'wt')", {
    mod <- lm(mpg ~ hp * wt, data = mtcars)
    p <- plot_cme(mod, effect = "hp", condition = "wt")
    vdiffr::expect_doppelganger("plot_cme basic", p)
})

test_that("plot(mfx)", {
    mod <- glm(am ~ hp + wt, data = mtcars)
    mfx <- marginaleffects(mod)
    p <- plot(mfx)
    vdiffr::expect_doppelganger("plot basic", p)
})
