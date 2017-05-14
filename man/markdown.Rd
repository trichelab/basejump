% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/markdown.R
\name{mdList}
\alias{mdList}
\alias{md_list}
\title{Markdown utilities.}
\usage{
mdList(character, ordered = FALSE)
}
\arguments{
\item{character}{Character vector.}

\item{ordered}{Ordered \code{TRUE} or unordered \code{FALSE} list in Markdown
format.}
}
\value{
Character vector.
}
\description{
Markdown list.
}
\examples{
mdList(c("milk", "eggs"))
mdList(c("milk", "eggs"), ordered = TRUE)
}