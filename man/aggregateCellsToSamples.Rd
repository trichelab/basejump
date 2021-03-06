% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aggregateCellsToSamples-methods.R
\name{aggregateCellsToSamples}
\alias{aggregateCellsToSamples}
\alias{aggregateCellsToSamples,SingleCellExperiment-method}
\title{Aggregate cells to samples}
\usage{
aggregateCellsToSamples(object, ...)

\S4method{aggregateCellsToSamples}{SingleCellExperiment}(
  object,
  fun = c("sum", "mean", "geometricMean", "median")
)
}
\arguments{
\item{object}{Object.}

\item{fun}{\code{character(1)}.
Name of the aggregation function.
Uses \code{\link[base:match.arg]{match.arg()}} internally.}

\item{...}{Additional arguments.}
}
\value{
\code{SummarizedExperiment}.
Object with cell-level counts aggregated to sample-level.
}
\description{
Utilty function that factilites cell-to-sample aggregation. By default, this
function will sum the counts across cells to sample level.
}
\details{
Internally \code{\link[=aggregateCellsToSamples]{aggregateCellsToSamples()}} automatically obtains the
cell-to-sample groupings and then performs aggregation with the
\code{\link[=aggregateCols]{aggregateCols()}} function.
}
\note{
Updated 2019-07-28.
}
\examples{
data(SingleCellExperiment, package = "acidtest")

## SingleCellExperiment ====
object <- SingleCellExperiment
x <- aggregateCellsToSamples(object)
print(x)
}
