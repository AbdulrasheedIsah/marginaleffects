#' @include get_coef.R
#' @rdname get_coef
#' @export
get_coef.polr <- function(model, ...) {
    out <- insight::get_parameters(model)
    out <- stats::setNames(out$Estimate, out$Parameter)
    names(out) <- gsub("Intercept: ", "", names(out))
    return(out)
}


#' @include set_coef.R
#' @rdname set_coef
#' @export
set_coef.polr <- function(model, coefs) {
    # in basic model classes coefficients are named vector
    idx <- match(names(model$coefficients), names(coefs))
    model[["coefficients"]] <- coefs[idx]
    idx <- match(names(model$zeta), names(coefs))
    model[["zeta"]] <- coefs[idx]
    model
}


#' @include get_group_names.R
#' @rdname get_group_names
#' @export
get_group_names.polr <- function(model, ...) {
    resp <- insight::get_response(model)
    if (is.factor(resp)) {
        out <- levels(resp)
    } else {
        out <- unique(resp)
    }
    return(out)
}


#' @include get_vcov.R
#' @rdname get_vcov
#' @export
get_vcov.polr <- function(model, ...) {
    out <- suppressMessages(insight::get_varcov(model))
    return(out)
}


#' @include get_predict.R
#' @rdname get_predict
#' @export
get_predict.polr <- function(model,
                             newdata = insight::get_data(model),
                             type = "probs",
                             conf.level = NULL,
                             ...) {

    type <- sanity_type(model, type)

    # hack: 1-row newdata returns a vector, so get_predict.default does not learn about groups
    if (nrow(newdata) == 1) {
        hack <- TRUE
        newdata <- newdata[c(1, 1), , drop = FALSE]
    } else {
        hack <- FALSE
    }

    out <- get_predict.default(model,
                               newdata = newdata,
                               type = type,
                               conf.level = conf.level,
                               ...)

    if (isTRUE(hack)) {
        out <- out[out$rowid == 1, ]
    }

    return(out)
}


#' @include set_coef.R
#' @rdname set_coef
#' @export
set_coef.glmmPQL <- function(model, coefs) {
    model[["coefficients"]][["fixed"]][names(coefs)] <- coefs
    model
}


#' @rdname get_predict
#' @export
get_predict.glmmPQL <- function(model,
                                newdata = insight::get_data(model),
                                type = "response",
                                conf.level = NULL,
                                ...) {

    type <- sanity_type(model, type)

    out <- stats::predict(model, newdata = newdata, type = type, ...)
    out <- data.frame(
        rowid = seq_len(nrow(newdata)),
        predicted = out)
    return(out)
}

