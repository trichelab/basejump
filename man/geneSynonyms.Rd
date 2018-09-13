% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geneSynonyms.R
\name{geneSynonyms}
\alias{geneSynonyms}
\title{Gene Synonyms}
\usage{
geneSynonyms(organism)
}
\arguments{
\item{organism}{\code{string}. Supported organisms:
\itemize{
\item \emph{Homo sapiens}
\item \emph{Mus musculus}
\item \emph{Drosophila melanogaster}
}}
}
\value{
\code{grouped_df}, grouped by \code{geneID} column.
}
\description{
Look up gene synonyms from NCBI.
}
\note{
Synonym support for \emph{Caenorhabditis elegans} is poor on NCBI.
Use the wormbase package instead.
}
\examples{
x <- geneSynonyms(organism = "Homo sapiens")
print(x)
}
\seealso{
Other Annotation Functions: \code{\link{broadClass}},
  \code{\link{convertGenesToSymbols}},
  \code{\link{convertTranscriptsToGenes}},
  \code{\link{convertUCSCBuildToEnsembl}},
  \code{\link{detectOrganism}}, \code{\link{eggnog}},
  \code{\link{emptyRanges}}, \code{\link{hgnc2gene}},
  \code{\link{makeGRanges}}, \code{\link{makeGene2symbol}},
  \code{\link{makeTx2gene}}, \code{\link{mgi2gene}},
  \code{\link{panther}},
  \code{\link{stripTranscriptVersions}}
}
\author{
Michael Steinbaugh
}
\concept{Annotation Functions}