% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lfcThreshold-methods.R
\name{lfcThreshold}
\alias{lfcThreshold}
\alias{lfcThreshold<-}
\alias{lfcThreshold,Annotated-method}
\alias{lfcThreshold<-,Annotated,numeric-method}
\title{Log2 fold change threshold}
\usage{
lfcThreshold(object, ...)

lfcThreshold(object, ...) <- value

\S4method{lfcThreshold}{Annotated}(object)

\S4method{lfcThreshold}{Annotated,numeric}(object) <- value
}
\arguments{
\item{object}{Object.}

\item{value}{Value to assign.}

\item{...}{Additional arguments.}
}
\value{
\code{numeric(1)}.
}
\description{
Log2 fold change threshold
}
\note{
Updated 2019-08-06.
}
\examples{
data(RangedSummarizedExperiment, package = "acidtest")
rse <- RangedSummarizedExperiment

## Annotated
lfcThreshold(rse) <- 0.5
lfcThreshold(rse)
}
