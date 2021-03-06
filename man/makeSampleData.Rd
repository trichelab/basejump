% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/makeSampleData-methods.R
\name{makeSampleData}
\alias{makeSampleData}
\alias{makeSampleData,data.frame-method}
\alias{makeSampleData,DataFrame-method}
\title{Make sample data}
\usage{
makeSampleData(object, ...)

\S4method{makeSampleData}{data.frame}(object)

\S4method{makeSampleData}{DataFrame}(object)
}
\arguments{
\item{object}{Object.}

\item{...}{Additional arguments.}
}
\value{
\code{DataFrame}.
}
\description{
Utility function that prepares metadata to be slotted into
\code{\link[SummarizedExperiment:colData]{colData()}}.
}
\details{
This function adheres to the following conventions:
\itemize{
\item Row names are required. Either define manually (recommended) or pass in as
a rownames column (data.table / tibble style).
Supported colnames: "sampleID", "rowname", "rn".
\item All column names will be converted to lower camel case
(see \code{\link[=camelCase]{camelCase()}} for details).
\item \code{sampleName} column is always placed first.
}

Required columns:
\itemize{
\item \code{sampleName}: Human readable sample names. Note that this column is
useful for plots and doesn't have to match the column names of a
\code{SummarizedExperiment} object, which should use valid names.
}

Blacklisted columns:
\itemize{
\item \code{filename} (use \code{fileName}).
\item \code{id}.
\item \code{interestingGroups}. Defined automatically downstream.
\item \code{sample}. Too vague. Does this represent an ID or human readable name?
\item \code{samplename} (use \code{sampleName}).
}
}
\note{
Updated 2019-10-10.
}
\examples{
object <- DataFrame(
    genotype = rep(c("control", "wildtype"), times = 2L),
    treatment = rep(c("vector", "RNAi"), each = 2L),
    sampleName = paste("sample", seq_len(4L)),
    row.names = paste0("GSM000000", seq_len(4L))
)
makeSampleData(object)
}
\seealso{
\code{makeNames}.
}
