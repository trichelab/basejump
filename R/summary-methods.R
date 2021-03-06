#' Object summaries
#'
#' @name summary
#' @keywords internal
#' @note Updated 2019-11-19.
#'
#' @inheritParams acidroxygen::params
#' @param ... Additional arguments.
#'
#' @return Invisible `NULL`.
#'
#' @examples
#' data(
#'     RangedSummarizedExperiment,
#'     SummarizedExperiment_transcripts,
#'     package = "acidtest"
#' )
#'
#' ## Gene2Symbol ====
#' object <- Gene2Symbol(RangedSummarizedExperiment)
#' summary(object)
#'
#' ## Tx2Gene ====
#' object <- Tx2Gene(SummarizedExperiment_transcripts)
#' summary(object)
NULL



#' @rdname summary
#' @name summary
#' @importFrom S4Vectors summary
#' @usage summary(object, ...)
#' @export
NULL



## Updated 2019-07-22.
`summary,Gene2Symbol` <-  # nolint
    function(object) {
        m <- metadata(object)
        showSlotInfo(list(
            genes = length(unique(object[["geneID"]])),
            symbols = length(unique(object[["geneName"]])),
            format = m[["format"]],
            organism = m[["organism"]],
            genomeBuild = m[["genomeBuild"]],
            ensemblRelease = m[["ensemblRelease"]],
            id = m[["id"]],
            version = as.character(m[["version"]]),
            date = m[["date"]]
        ))
    }



#' @rdname summary
#' @export
setMethod(
    f = "summary",
    signature = signature("Gene2Symbol"),
    definition = `summary,Gene2Symbol`
)



## Updated 2019-07-22.
`summary,Tx2Gene` <-  # nolint
    function(object) {
        m <- metadata(object)
        showSlotInfo(list(
            transcripts = length(unique(object[["transcriptID"]])),
            genes = length(unique(object[["geneID"]])),
            organism = m[["organism"]],
            genomeBuild = m[["genomeBuild"]],
            ensemblRelease = m[["ensemblRelease"]],
            id = m[["id"]],
            version = as.character(m[["version"]]),
            date = m[["date"]]
        ))
    }



#' @rdname summary
#' @export
setMethod(
    f = "summary",
    signature = signature("Tx2Gene"),
    definition = `summary,Tx2Gene`
)
