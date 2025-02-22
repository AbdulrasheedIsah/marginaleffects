% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/summary.R
\name{summary.marginaleffects}
\alias{summary.marginaleffects}
\title{Summarize a \code{marginaleffects} object}
\usage{
\method{summary}{marginaleffects}(object, conf.level = 0.95, ...)
}
\arguments{
\item{object}{An object produced by the \code{marginaleffects} function}

\item{conf.level}{The confidence level to use for the confidence interval if
\code{conf.int=TRUE}. Must be strictly greater than 0 and less than 1. Defaults
to 0.95, which corresponds to a 95 percent confidence interval.}

\item{...}{Additional arguments are pushed forward to \code{predict()}.}
}
\value{
Data frame of summary statistics for an object produced by the
\code{marginaleffects} function
}
\description{
Summarize a \code{marginaleffects} object
}
