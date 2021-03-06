% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aggregate-methods.R
\name{aggregate}
\alias{aggregate}
\alias{aggregateCols}
\alias{aggregateRows}
\alias{aggregateRows,matrix-method}
\alias{aggregateRows,sparseMatrix-method}
\alias{aggregateRows,SummarizedExperiment-method}
\alias{aggregateCols,matrix-method}
\alias{aggregateCols,sparseMatrix-method}
\alias{aggregateCols,SummarizedExperiment-method}
\alias{aggregateCols,SingleCellExperiment-method}
\title{Aggregate rows or columns}
\usage{
aggregateCols(object, ...)

aggregateRows(object, ...)

\S4method{aggregateRows}{matrix}(
  object,
  groupings,
  fun = c("sum", "mean", "geometricMean", "median")
)

\S4method{aggregateRows}{sparseMatrix}(
  object,
  groupings,
  fun = c("sum", "mean", "geometricMean", "median")
)

\S4method{aggregateRows}{SummarizedExperiment}(
  object,
  col = "aggregate",
  fun = c("sum", "mean", "geometricMean", "median")
)

\S4method{aggregateCols}{matrix}(
  object,
  groupings,
  fun = c("sum", "mean", "geometricMean", "median")
)

\S4method{aggregateCols}{sparseMatrix}(
  object,
  groupings,
  fun = c("sum", "mean", "geometricMean", "median")
)

\S4method{aggregateCols}{SummarizedExperiment}(
  object,
  col = "aggregate",
  fun = c("sum", "mean", "geometricMean", "median")
)

\S4method{aggregateCols}{SingleCellExperiment}(object, fun = c("sum", "mean", "geometricMean", "median"))
}
\arguments{
\item{object}{Object.}

\item{groupings}{\code{factor}.
Defines the aggregation groupings. The new aggregate names are defined as
the \code{factor} \link[base:levels]{levels}, and the original, unaggregated names
are defined as the \link[base:names]{names}.}

\item{fun}{\code{character(1)}.
Name of the aggregation function.
Uses \code{\link[base:match.arg]{match.arg()}} internally.}

\item{col}{\code{character(1)}.
Name of column in either \code{\link[SummarizedExperiment:rowData]{rowData()}} or
\code{\link[SummarizedExperiment:colData]{colData()}} that defines the desired
aggregation groupings.}

\item{...}{Additional arguments.}
}
\value{
Modified object, with aggregated rows (features) or columns
(samples).
}
\description{
Aggregate gene/transcript features (rows) or sample replicates (columns).
}
\details{
\code{\link[=aggregateRows]{aggregateRows()}} works down the rows, and is designed to aggregate features
(e.g. genes or transcripts). Most commonly, the \code{\link[=aggregateRows]{aggregateRows()}} function
can be used to aggregate counts from transcript-level to gene-level.
\code{\link[=aggregateCols]{aggregateCols()}} works across the columns, and is designed to aggregate
sample replicates.
}
\note{
Updated 2019-08-18.
}
\section{Methods (by class)}{

\itemize{
\item \code{matrix}, \code{sparseMatrix}:
Aggregate rows or columns using a grouping \code{factor}.
\item \code{SummarizedExperiment}:
Aggregate rows or columns of data slotted in
\code{\link[SummarizedExperiment:assays]{assays()}} using an automatically
generated grouping \code{factor}, which is obtained from a user-defined column
(\code{col} argument) in either the
\code{\link[SummarizedExperiment:rowData]{rowData()}} or
\code{\link[SummarizedExperiment:colData]{colData()}} of the object. Slot an
\code{aggregate} column into \code{\link[SummarizedExperiment:rowData]{rowData()}}
for \code{\link[=aggregateRows]{aggregateRows()}}, or into
\code{\link[SummarizedExperiment:colData]{colData()}} for \code{\link[=aggregateCols]{aggregateCols()}}. This
method will define the \code{groupings} automatically, and perform the
aggregation.
\item \code{SingleCellExperiment}:
Aggregate \code{\link[SummarizedExperiment:assays]{assays()}} across cell-level
groupings, defined by a column in
\code{\link[SummarizedExperiment:colData]{colData()}}. Inherits from
\code{SummarizedExperiment}, and still relies upon slotting an \code{aggregate}
column into \code{\link[SummarizedExperiment:colData]{colData()}}. Note that these
groupings will map to cells, so care must be taken to properly aggregate
samples.
}
}

\examples{
## Example data ====
counts <- matrix(
    data = c(
        0L, 1L, 1L, 1L,
        1L, 0L, 1L, 1L,
        1L, 1L, 0L, 1L,
        1L, 1L, 1L, 0L
    ),
    nrow = 4L,
    ncol = 4L,
    byrow = TRUE,
    dimnames = list(
        paste0("transcript", seq_len(4L)),
        paste(
            paste0("sample", rep(seq_len(2L), each = 2L)),
            paste0("replicate", rep(seq_len(2L), times = 2L)),
            sep = "_"
        )
    )
)
class(counts)
print(counts)

genes <- factor(paste0("gene", rep(seq_len(2L), each = 2L)))
names(genes) <- rownames(counts)
print(genes)

samples <- factor(paste0("sample", rep(seq_len(2L), each = 2L)))
names(samples) <- colnames(counts)
print(samples)

## sparseMatrix
sparse <- as(counts, "sparseMatrix")
class(sparse)
print(sparse)

## SummarizedExperiment
se <- SummarizedExperiment::SummarizedExperiment(
    assays = SimpleList(counts = counts),
    colData = DataFrame(
        sampleName = as.factor(names(samples)),
        aggregate = samples
    ),
    rowData = DataFrame(aggregate = genes)
)
print(se)

## aggregateRows ====
aggregateRows(counts, groupings = genes)
aggregateRows(sparse, groupings = genes)
aggregateRows(se)

## aggregateCols ====
aggregateCols(counts, groupings = samples)
aggregateCols(sparse, groupings = samples)
aggregateCols(se)
}
\seealso{
\itemize{
\item \code{stats::aggregate()}.
\item \code{S4Vectors::aggregate()}.
\item \code{Matrix.utils::aggregate.Matrix()}.
}
}
\author{
Michael Steinbaugh, Rory Kirchner
}
