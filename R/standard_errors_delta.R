standard_errors_delta_marginalmeans <- function(model,
                                                variables,
                                                newdata,
                                                type,
                                                ...) {
    get_marginalmeans(model = model,
                      variables = variables,
                      newdata = newdata,
                      type = type,
                      ...)$marginalmean
}

standard_errors_delta_marginaleffects <- function(model,
                                                  variable,
                                                  newdata,
                                                  type,
                                                  ...) {
    get_dydx(model = model,
             variable = variable,
             newdata = newdata,
             type = type,
             ...)$dydx
}

#' Compute standard errors using the delta method
#'
#' @inheritParams marginaleffects
#' @param FUN a function which accepts a `model` and other inputs and returns a
#'   vector of estimates (marginal effects, marginal means, etc.)
#' @param index data.frame over which we aggregate J_mean (matches tidy() output)
#' @return vector of standard errors
#' @noRd
standard_errors_delta <- function(model,
                                  vcov,
                                  type,
                                  FUN,
                                  index = NULL,
                                  ...) {

    numDeriv_method <- sanitize_numDeriv_method()

    # delta method does not work for these models
    bad <- c("brmsfit", "stanreg")
    if (any(bad %in% class(model))) {
        return(NULL)
    }

    # TODO: this is a terrible sanity check
    coefs <- get_coef(model)
    vcov <- vcov[names(coefs), names(coefs), drop = FALSE]

    # input: named vector of coefficients
    # output: gradient
    inner <- function(x) {
        model_tmp <- set_coef(model, stats::setNames(x, names(coefs)))
        g <- FUN(model = model_tmp, type = type, ...)
        return(g)
    }

    J <- numDeriv::jacobian(func = inner,
                            x = coefs,
                            method = numDeriv_method)
    colnames(J) <- names(get_coef(model))

    if (!is.null(index)) {
        J_mean <- stats::aggregate(J, by = index, FUN = mean, na.rm = TRUE)
    } else {
        J_mean <- NULL
    }

    # Var(dydx) = J Var(beta) J'
    # computing the full matrix is memory-expensive, and we only need the diagonal
    # algebra trick: https://stackoverflow.com/a/42569902/342331
    se <- sqrt(colSums(t(J %*% vcov) * t(J)))


    attr(se, "J") <- J
    attr(se, "J_mean") <- J_mean

    return(se)
}
