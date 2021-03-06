% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/metrics-methods.R
\name{metrics}
\alias{metrics}
\alias{metricsPerSample}
\alias{metrics,SummarizedExperiment-method}
\alias{metrics,SingleCellExperiment-method}
\alias{metricsPerSample,SingleCellExperiment-method}
\title{Quality control metrics}
\usage{
metrics(object, ...)

metricsPerSample(object, ...)

\S4method{metrics}{SummarizedExperiment}(object, return = c("tbl_df", "DataFrame"))

\S4method{metrics}{SingleCellExperiment}(object, return = c("tbl_df", "DataFrame"))

\S4method{metricsPerSample}{SingleCellExperiment}(
  object,
  fun = c("mean", "median", "sum"),
  return = c("tbl_df", "DataFrame")
)
}
\arguments{
\item{object}{Object.}

\item{return}{\code{character(1)}.
Return type. Uses \code{\link[base:match.arg]{match.arg()}} internally and defaults
to the first argument in the \code{character} vector.}

\item{fun}{\code{character(1)}.
Mathematical function name to apply.
Uses \code{\link[base:match.arg]{match.arg()}} internally.}

\item{...}{Additional arguments.}
}
\value{
Object of class determined by \code{return} argument.
}
\description{
Quality control metrics
}
\details{
\code{\link[=metrics]{metrics()}} takes data stored in \code{\link[SummarizedExperiment:colData]{colData()}}
and consistently returns a \code{tbl_df} or \code{DataFrame} with \code{sampleName} and
\code{interestingGroups} columns, even when these columns are not defined in
\code{colData()}. This is designed to integrate with plotting functions that use
ggplot2 internally.
}
\section{Functions}{
\itemize{
\item \code{metrics,SummarizedExperiment-method}: Sample-level metrics.

\item \code{metrics,SingleCellExperiment-method}: Cell-level metrics.

\item \code{metricsPerSample,SingleCellExperiment-method}: Sample-level metrics.
}}

\note{
These functions will error intentionally if no numeric columns are
defined in \code{colData()}.

Updated 2019-08-18.
}
\examples{
data(
    RangedSummarizedExperiment,
    SingleCellExperiment,
    package = "acidtest"
)

## SummarizedExperiment ====
object <- RangedSummarizedExperiment
object <- calculateMetrics(object)
x <- metrics(object)
print(x)

## SingleCellExperiment ====
object <- SingleCellExperiment
object <- calculateMetrics(object)
x <- metrics(object)
print(x)
x <- metricsPerSample(object, fun = "mean")
print(x)
}
\author{
Michael Steinbaugh, Rory Kirchner
}
