#' @name Ensembl2Entrez
#' @inherit Ensembl2Entrez-class
#' @inheritParams params
#'
#' @param format `string`. Formatting method to apply:
#' - `"1:1"`: *Recommended.* Return with 1:1 mappings. For Ensembl genes that
#'   don't map 1:1 with Entrez, pick the oldest Entrez ID. Genes that don't map
#'   to Entrez will contain `NA` in `entrezID` column.
#' - `"long"`: Return 1:many in long format.
#'
#' @examples
#' data(rse)
#' x <- Ensembl2Entrez(rse)
#' print(x)
NULL



Ensembl2Entrez.DataFrame <-  # nolint
    function(
        object,
        format = c("1:1", "long")
    ) {
        assert_has_rows(object)
        format <- match.arg(format)

        cols <- c("geneID", "entrezID")
        if (!all(cols %in% colnames(object))) {
            stop(paste0(
                "Object does not contain Ensembl-to-Entrez mappings.\n",
                "Requires: ", toString(cols)
            ))
        }

        data <- object[, cols, drop = FALSE]

        # Expand to long format.
        data <- expand(data)

        # Inform the user about genes that don't map to Entrez.
        unmapped <- data[["geneID"]][which(is.na(data[["entrezID"]]))]
        assert_that(!any(duplicated(unmapped)))
        if (has_length(unmapped)) {
            message(paste(length(unmapped), "genes don't map to Entrez."))
        }

        # Inform the user about how many genes multi-map to Entrez.
        multimapped <- unique(data[["geneID"]][duplicated(data[["geneID"]])])
        if (has_length(multimapped)) {
            message(paste(
                length(multimapped), "genes map to multiple Entrez IDs."
            ))
        }

        if (format == "1:1") {
            message(paste(
                "Returning with 1:1 mappings using oldest Entrez ID per gene."
            ))
            entrez <- object[["entrezID"]]
            assert_is_list(entrez)
            names(entrez) <- object[["geneID"]]
            map <- lapply(
                X = entrez,
                FUN = function(x) {
                    if (all(is.na(x))) {
                        NA_integer_
                    } else {
                        sort(x)[[1L]]
                    }
                }
            )
            entrez <- unlist(map)
            data <- DataFrame(
                geneID = names(entrez),
                entrezID = as.integer(entrez),
                row.names = rownames(object)
            )
        } else if (format == "long") {
            message("Returning 1:many in long format.")
        }

        metadata(data) <- metadata(object)
        metadata(data)[["format"]] <- format
        new(Class = "Ensembl2Entrez", data)
    }



Ensembl2Entrez.GRanges <-  # nolint
    function(object) {
        data <- as(object, "DataFrame")
        metadata(data) <- metadata(object)
        do.call(
            what = Ensembl2Entrez,
            args = list(
                object = data,
                format = format
            )
        )
    }
formals(Ensembl2Entrez.GRanges) <- formals(Ensembl2Entrez.DataFrame)



Ensembl2Entrez.SummarizedExperiment <-  # nolint
    function(object) {
        object <- as.SummarizedExperiment(object)
        data <- rowData(object)
        rownames(data) <- rownames(object)
        do.call(
            what = Ensembl2Entrez,
            args = list(
                object = data,
                format = format
            )
        )


    }
formals(Ensembl2Entrez.SummarizedExperiment) <-
    formals(Ensembl2Entrez.DataFrame)



#' @rdname Ensembl2Entrez
#' @export
setMethod(
    f = "Ensembl2Entrez",
    signature = signature("DataFrame"),
    definition = Ensembl2Entrez.DataFrame
)



#' @rdname Ensembl2Entrez
#' @export
setMethod(
    f = "Ensembl2Entrez",
    signature = signature("GRanges"),
    definition = Ensembl2Entrez.GRanges
)



#' @rdname Ensembl2Entrez
#' @export
setMethod(
    f = "Ensembl2Entrez",
    signature = signature("SummarizedExperiment"),
    definition = Ensembl2Entrez.SummarizedExperiment
)