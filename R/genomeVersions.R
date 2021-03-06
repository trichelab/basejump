#' Genome versions
#'
#' Obtain the latest release version from various genome annotation sources.
#'
#' @name genomeVersions
#' @note Updated 2019-10-18.
#'
#' @inheritParams acidroxygen::params
#' @param dmel `logical(1)`.
#'   Return *Drosophila melanogaster* genome release version.
#'
#' @return `character(1)`.
#'   Release version.
#'
#' @seealso
#' Refer to the koopa package for shell variants:
#'
#' - `ensembl-version`.
#' - `flybase-version`.
#' - `gencode-version`.
#' - `refseq-version`.
#' - `wormbase-version`.
#'
#' @examples
#' if (goalie::hasInternet(url = "ftp://ftp.ensembl.org/")) {
#'     ensemblVersion()
#' }
NULL



#' @rdname genomeVersions
#' @export
ensemblVersion <- function() {
    suppressMessages(
        x <- import(
            file = "ftp://ftp.ensembl.org/pub/current_README",
            format = "lines"
        )
    )
    x <- x[[3L]]
    x <- str_split_fixed(x, pattern = boundary("word"), n = 4L)[1L, 3L]
    x
}



#' @rdname genomeVersions
#' @export
gencodeVersion <- function(organism) {
    organism <- match.arg(
        arg = organism,
        choices = c("Homo sapiens", "Mus musculus")
    )
    url <- "https://www.gencodegenes.org"
    if (identical(organism, "Homo sapiens")) {
        shortName <- "human"
        pattern <- "Release [[:digit:]]+"
    } else if (identical(organism, "Mus musculus")) {
        shortName <- "mouse"
        pattern <- "Release M[[:digit:]]+"
    }
    url <- paste0(url, "/", shortName, "/")
    x <- getURL(url)
    x <- str_extract(x, pattern = pattern)
    x <- str_split_fixed(x, pattern = boundary("word"), n = 2L)[1L, 2L]
    x
}



#' @rdname genomeVersions
#' @export
refseqVersion <- function() {
    suppressMessages(
        import(
            file = "ftp://ftp.ncbi.nlm.nih.gov/refseq/release/RELEASE_NUMBER",
            format = "lines"
        )
    )
}



#' @rdname genomeVersions
#' @export
flybaseVersion <- function(dmel = FALSE) {
    assert(isFlag(dmel))
    url <- "ftp://ftp.flybase.net/releases/"
    if (isTRUE(dmel)) {
        x <- getURLDirList(paste0(url, "current/"))
        x <- grep(pattern = "^dmel_r[.0-9]+$", x = x, value = TRUE)
        x <- str_split_fixed(x, pattern = "_", n = 2L)[1L, 2L]
    } else {
        x <- getURLDirList(url)
        x <- grep(pattern = "^FB[0-9]{4}_[0-9]{2}$", x = x, value = TRUE)
    }
    x <- sort(x)
    x <- tail(x, n = 1L)
    x
}



#' @rdname genomeVersions
#' @export
wormbaseVersion <- function() {
    url <- pasteURL(
        "ftp.wormbase.org",
        "pub",
        "wormbase",
        "releases",
        "current-production-release",
        protocol = "ftp"
    )
    x <- getURLDirList(paste0(url, "/"))
    x <- grep(pattern = "letter.WS[0-9]+", x = x, value = TRUE)
    x <- str_split_fixed(x, pattern = "\\.", n = 2L)[1L, 2L]
    x
}
