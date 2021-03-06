#' @name calculateMetrics
#' @inherit bioverbs::calculateMetrics
#' @author Michael Steinbaugh, Rory Kirchner
#'
#' @note Input a raw count matrix. Do not use size factor adjusted or log
#'   normalized counts here.
#' @note Updated 2019-10-09.
#'
#' @inheritParams acidroxygen::params
#' @param prefilter `logical(1)`.
#'   Drop very low quality samples/cells from the object.
#'   This can resize the number of columns but the rows (i.e. features) do not
#'   change with this operation.
#' @param ... Additional arguments.
#'
#' @return
#' - `matrix` / `Matrix`: `DataFrame` containing metrics.
#' - `SingleCellExperiment` / `SummarizedExperiment`: Modified object, with
#'   metrics in [`colData()`][SummarizedExperiment::colData].
#'
#' @examples
#' data(SingleCellExperiment, package = "acidtest")
#'
#' ## SingleCellExperiment ====
#' object <- SingleCellExperiment
#' x <- calculateMetrics(object)
#' print(x)
NULL



#' @rdname calculateMetrics
#' @name calculateMetrics
#' @importFrom bioverbs calculateMetrics
#' @usage calculateMetrics(object, ...)
#' @export
NULL



## Updated 2019-08-27.
`calculateMetrics,matrix` <-  # nolint
    function(
        object,
        rowRanges = NULL,
        prefilter = FALSE
    ) {
        assert(
            hasValidDimnames(object),
            hasRows(object),
            isAny(rowRanges, c("GRanges", "NULL")),
            isFlag(prefilter)
        )
        if (isTRUE(prefilter)) {
            originalDim <- dim(object)
            object <- nonzeroRowsAndCols(object)
        }
        message(sprintf(
            fmt = "Calculating %d sample %s.",
            ncol(object),
            ngettext(
                n = ncol(object),
                msg1 = "metric",
                msg2 = "metrics"
            )
        ))
        codingFeatures <- character()
        mitoFeatures <- character()
        missingBiotype <- function() {
            message(sprintf(
                fmt = paste0(
                    "Calculating metrics without biotype information.\n",
                    "'rowRanges' required to calculate: %s."
                ),
                toString(c("nCoding", "nMito", "mitoRatio"))
            ))
        }
        ## Calculate nCoding and nMito, which requires annotations.
        if (!is.null(rowRanges)) {
            assert(
                is(rowRanges, "GRanges"),
                hasValidNames(rowRanges)
            )
            ## Error on missing features.
            setdiff <- setdiff(rownames(object), names(rowRanges))
            if (hasLength(setdiff)) {
                stop(sprintf(
                    fmt = "Features missing in 'rowRanges()': %s",
                    toString(setdiff, width = 200L)
                ))
            }
            ## Subset ranges to match matrix.
            assert(isSubset(rownames(object), names(rowRanges)))
            rowRanges <- rowRanges[rownames(object)]
            rowData <- mcols(rowRanges, use.names = TRUE)
            assert(
                hasRownames(rowData),
                identical(rownames(rowData), names(rowRanges))
            )
            if (isSubset("broadClass", colnames(rowData))) {
                ## Drop rows with NA broad class.
                keep <- !is.na(rowData[["broadClass"]])
                assert(is(keep, "Rle"))
                rowData <- rowData[keep, , drop = FALSE]
                ## Coding features.
                keep <- rowData[["broadClass"]] == "coding"
                assert(is(keep, "Rle"))
                codingFeatures <- rownames(rowData[keep, , drop = FALSE])
                message(sprintf(
                    fmt = "%d coding %s detected.",
                    length(codingFeatures),
                    ngettext(
                        n = length(codingFeatures),
                        msg1 = "feature",
                        msg2 = "features"
                    )
                ))
                ## Mitochondrial features.
                keep <- rowData[["broadClass"]] == "mito"
                assert(is(keep, "Rle"))
                mitoFeatures <- rownames(rowData[keep, , drop = FALSE])
                message(sprintf(
                    fmt = "%d mitochondrial %s detected.",
                    length(mitoFeatures),
                    ngettext(
                        n = length(mitoFeatures),
                        msg1 = "feature",
                        msg2 = "features"
                    )
                ))
            } else {
                missingBiotype()
            }
        } else {
            missingBiotype()
        }
        ## Using S4 run-length encoding here to reduce memory overhead.
        ## We're following the naming conventions used in Seurat 3.
        ## Note that "nCount" represents "nUMI" for droplet scRNA-seq data.
        nCount <- Rle(as.integer(colSums(object)))
        nFeature <- Rle(as.integer(colSums(object > 0L)))
        nCoding <- if (hasLength(codingFeatures)) {
            mat <- object[codingFeatures, , drop = FALSE]
            Rle(as.integer(colSums(mat)))
        } else {
            Rle(NA_integer_)
        }
        nMito <- if (hasLength(mitoFeatures)) {
            mat <- object[mitoFeatures, , drop = FALSE]
            Rle(as.integer(colSums(mat)))
        } else {
            Rle(NA_integer_)
        }
        log10FeaturesPerCount <- log10(nFeature) / log10(nCount)
        mitoRatio <- nMito / nCount
        data <- DataFrame(
            nCount = nCount,
            nFeature = nFeature,
            nCoding = nCoding,
            nMito = nMito,
            log10FeaturesPerCount = log10FeaturesPerCount,
            mitoRatio = mitoRatio,
            row.names = colnames(object)
        )
        ## Apply low stringency pre-filtering.
        ## This keeps only samples/cells with non-zero features.
        if (isTRUE(prefilter)) {
            ## Novelty score.
            keep <- !is.na(data[["log10FeaturesPerCount"]])
            data <- data[keep, , drop = FALSE]
            ## Minimum number of read counts per sample.
            keep <- data[["nCount"]] > 0L
            data <- data[keep, , drop = FALSE]
            ## Minimum number of features (i.e. genes) per sample.
            keep <- data[["nFeature"]] > 0L
            data <- data[keep, , drop = FALSE]
            n1 <- nrow(data)
            n2 <- originalDim[[2L]]
            if (n1 < n2) {
                message(sprintf(
                    fmt = "Prefilter: %d / %d %s (%s).",
                    n1, n2,
                    ngettext(
                        n = n1,
                        msg1 = "sample",
                        msg2 = "samples"
                    ),
                    percent(n1 / n2)
                ))
            }
        }
        data
    }



#' @rdname calculateMetrics
#' @export
setMethod(
    f = "calculateMetrics",
    signature = signature("matrix"),
    definition = `calculateMetrics,matrix`
)



## Updated 2019-08-23.
`calculateMetrics,Matrix` <-  # nolint
    appendToBody(
        fun = `calculateMetrics,matrix`,
        values = list(
            quote(rowSums <- Matrix::rowSums),
            quote(colSums <- Matrix::colSums)
        )
    )



#' @rdname calculateMetrics
#' @export
setMethod(
    f = "calculateMetrics",
    signature = signature("Matrix"),
    definition = `calculateMetrics,Matrix`
)



## nolint start

## DelayedArray methods disabled until bug fix:
## https://github.com/Bioconductor/DelayedArray/issues/55

## Consider using DelayedArray for very large datasets.
## > if (ncol(counts) >= 1E6L) {
## >     counts <- DelayedArray(counts)
## > }

## Updated 2019-10-09.
## > `calculateMetrics,DelayedArray` <-  # nolint
## >     appendToBody(
## >         fun = `calculateMetrics,matrix`,
## >         values = list(
## >             quote(rowSums <- DelayedMatrixStats::rowSums2),
## >             quote(colSums <- DelayedMatrixStats::colSums2)
## >         )
## >     )

## > #' @rdname calculateMetrics
## > #' @export
## > setMethod(
## >     f = "calculateMetrics",
## >     signature = signature("DelayedArray"),
## >     definition = `calculateMetrics,DelayedArray`
## > )

## DelayedArray is erroring on Bioconductor 3.10 devel:
## test-calculateMetrics.R:5: error: matrix-like
## object 'is_pristine' not found
## 1: rlang::eval_tidy(code, args)
## 2: calculateMetrics(object, prefilter = TRUE) at test-calculateMetrics.R:5
## 3: calculateMetrics(object, prefilter = TRUE)
## 4: .local(object, ...)
## 5: nonzeroRowsAndCols(object) at /work/R/calculateMetrics-methods.R:56
## 6: nonzeroRowsAndCols(object)
## 7: .local(object, ...)
## 8: rowSums(object)
## 9: rowSums(object)
## 10: .local(x, rows, cols, na.rm, dim., ...)
## 11: DelayedArray:::is_pristine
## 12: get(name, envir = asNamespace(pkg), inherits = FALSE)

## nolint end



## Updated 2019-08-23.
`calculateMetrics,RangedSummarizedExperiment` <-  # nolint
    function(object, prefilter = FALSE) {
        ## Drop zero rows and columns to first to speed up calculations.
        if (isTRUE(prefilter)) {
            object <- nonzeroRowsAndCols(object)
        }
        metrics <- calculateMetrics(
            object = counts(object),
            rowRanges = rowRanges(object),
            prefilter = prefilter
        )
        if (isTRUE(prefilter)) {
            object <- object[, rownames(metrics), drop = FALSE]
        }
        ## Update the metrics in column data.
        colData <- colData(object)
        colData <- colData[
            ,
            setdiff(colnames(colData), colnames(metrics)),
            drop = FALSE
            ]
        assert(identical(rownames(colData), rownames(metrics)))
        colData <- cbind(colData, metrics)
        colData(object) <- colData
        validObject(object)
        object
    }



#' @rdname calculateMetrics
#' @export
setMethod(
    f = "calculateMetrics",
    signature = signature("RangedSummarizedExperiment"),
    definition = `calculateMetrics,RangedSummarizedExperiment`
)



## Updated 2019-08-23.
`calculateMetrics,SingleCellExperiment` <-  # nolint
    `calculateMetrics,RangedSummarizedExperiment`



#' @rdname calculateMetrics
#' @export
setMethod(
    f = "calculateMetrics",
    signature = signature("SingleCellExperiment"),
    definition = `calculateMetrics,SingleCellExperiment`
)
