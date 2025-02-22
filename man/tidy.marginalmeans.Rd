% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidy.R
\name{tidy.marginalmeans}
\alias{tidy.marginalmeans}
\title{Tidy a \code{marginalmeans} object}
\usage{
\method{tidy}{marginalmeans}(x, conf.int = TRUE, conf.level = 0.95, ...)
}
\arguments{
\item{x}{An object produced by the \code{marginalmeans} function.}

\item{conf.int}{Logical indicating whether or not to include a confidence interval.}

\item{conf.level}{The confidence level to use for the confidence interval if
\code{conf.int=TRUE}. Must be strictly greater than 0 and less than 1. Defaults
to 0.95, which corresponds to a 95 percent confidence interval.}

\item{...}{Additional arguments are pushed forward to \code{predict()}.}
}
\value{
A "tidy" \code{data.frame} of summary statistics which conforms to the
\code{broom} package specification.
}
\description{
Tidy a \code{marginalmeans} object
}
