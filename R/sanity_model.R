#' Method to raise model-specific warnings and errors
#' 
#' @inheritParams marginaleffects
#' @return A warning, an error, or nothing
#' @rdname sanity_model_specific
#' @keywords internal
sanity_model_specific <- function (model, ...) {
    UseMethod("sanity_model_specific", model)
}


#' @rdname sanity_model_specific
sanity_model_specific.default <- function(model, ...) {
    return(invisible(NULL))
}


sanity_model_supported_class <- function(model) {
    supported <- list("betareg",
                      "bife",
                      "brglmFit",
                      "brmsfit",
                      c("bracl", "brmultinom", "brglmFit"),
                      c("brnb", "negbin", "glm"),
                      "clm",
                      "coxph",
                      "crch",
                      "fixest",
                      c("Gam", "glm", "lm"), # package: gam
                      c("gam", "glm", "lm"), # package: mgcv
                      c("geeglm", "gee", "glm"),
                      "glm",
                      "gls",
                      "glmerMod",
                      "glmrob",
                      c("glmmPQL", "lme"),
                      "glimML",
                      "glmx",
                      "hurdle",
                      "hxlr",
                      "ivreg",
                      "iv_robust",
                      "lm",
                      "lmerMod",
                      "lmrob",
                      "lm_robust",
                      "loess",
                      c("lrm", "lm"),
                      c("lrm", "rms", "glm"),
                      c("mblogit", "mclogit"),
                      c("multinom", "nnet"),
                      c("negbin", "glm", "lm"),
                      c("plm", "panelmodel"),
                      "polr",
                      "rq",
                      "speedglm",
                      "speedlm",
                      "stanreg",
                      c("tobit", "survreg"),
                      "truncreg",
                      "zeroinfl")
    flag <- FALSE
    for (sup in supported) {
        if (all(sup %in% class(model))) {
            flag <- TRUE
        }
    }
    if (isFALSE(flag)) {
        support <- paste(sort(unique(sapply(supported, function(x) x[1]))), collapse = ", ")
        msg <- 
'Models of class "%s" are not supported. 

Supported model classes include: %s. 
 
New modeling packages can usually be supported by `marginaleffects` if they include a working `predict` method. If you believe that this is the case, please file a feature request on Github: https://github.com/vincentarelbundock/marginaleffects/issues' 
        msg <- sprintf(msg, class(model)[1], support)
        stop(msg)
    }
}


sanity_model <- function(model, ...) {
    sanity_model_specific(model, ...)
    sanity_model_supported_class(model)
    return(model)
}
