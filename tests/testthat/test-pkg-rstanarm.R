requiet("rstanarm")
requiet("emmeans")
requiet("broom")

test_that("stan_glm: no validity", {
    # interactions
    void <- capture.output(
      mod <- stan_glm(am ~ hp + mpg * vs, data = mtcars, family = binomial(link = "logit"))
    )
    expect_marginaleffects(mod, se = FALSE)
    expect_predictions(predictions(mod), se = FALSE)

    # no interactions
    void <- capture.output(
      mod <- stan_glm(am ~ hp + mpg + vs, data = mtcars, family = binomial(link = "logit"))
    )

    # emtrends
    mfx <- marginaleffects(mod, newdata = datagrid(hp = 110, mpg = 20, vs = 0), variables = "hp", type = "link")
    em <- emtrends(mod, ~hp, "hp", at = list(hp = 110, mpg = 20, vs = 0))
    em <- tidy(em)
    expect_equal(mfx$dydx, em$hp.trend)
    expect_equal(mfx$conf.low, em$lower.HPD, tolerance = .00001)
    expect_equal(mfx$conf.high, em$upper.HPD)

    # margins: var is all zeroes and dydx don't match precisely
    # mar <- margins(mod, unit_ses = TRUE, at = list(hp = 110, mpg = 20, vs = 0))
    # mfx <- marginaleffects(mod, variables = "hp", at = list(hp = 110, mpg = 20, vs = 0))
    # expect_equal(mfx$dydx, mar$dydx_hp)
    # expect_equal(mfx$std.error, mar$dydx_hp)
})
