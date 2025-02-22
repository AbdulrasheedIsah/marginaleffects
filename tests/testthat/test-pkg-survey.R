requiet("margins")
requiet("emmeans")
requiet("broom")

test_that("survey: marginaleffects vs. margins vs. emtrends", {
    data("fpc", package = "survey")
    svyd <- survey::svydesign(weights=~weight, 
                              ids=~psuid, 
                              strata=~stratid, 
                              fpc=~Nh, 
                              variables=~x + nh, 
                              data=fpc, 
                              nest=TRUE)
    mod <- survey::svyglm(x ~ nh, design = svyd)
    res <- marginaleffects(mod)
    mar <- suppressMessages(data.frame(margins(mod, unit_ses = TRUE)))
    # TODO: what explains this mismatch?
    expect_equal(res$dydx, as.numeric(mar$dydx_nh))
    expect_equal(res$std.error, as.numeric(mar$SE_dydx_nh), tolerance = 0.0001)
    # emtrends
    em <- emtrends(mod, ~nh, "nh", at = list(nh = 4))
    em <- tidy(em)
    mfx <- marginaleffects(mod, type = "link", newdata = data.frame(nh = 4))
    expect_equal(mfx$dydx, em$nh.trend)
    expect_equal(mfx$std.error, em$std.error)
})
