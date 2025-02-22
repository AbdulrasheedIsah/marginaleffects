#' @include set_coef.R
#' @rdname @set_coef
#' @keywords internal
#' @export
set_coef.merMod <- function(model, coefs) {
    # in 'merMod', predictions work the slot called "beta", which is unnamed
    # `fixef(model)` returns the same thing named
    beta <- methods::slot(model, "beta")
    beta[match(names(coefs), names(lme4::fixef(model)))] <- as.numeric(coefs)
    methods::slot(model, "beta") <- beta
    model
}

#' @include get_coef.R
#' @rdname @get_coef
#' @export
get_coef.merMod <- function(model, ...) {
    lme4::fixef(model)
}


#' @rdname get_predict
#' @export
get_predict.merMod <- function(model,
                               newdata = insight::get_data(model),
                               type = "response",
                               conf.level = NULL,
                               ...) {

    get_predict.default(model,
                        newdata = newdata,
                        type = type,
                        conf.level = conf.level,
                        ...)
}

