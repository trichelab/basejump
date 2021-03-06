context("calculateMetrics")

with_parameters_test_that(
    "matrix-like", {
        object <- calculateMetrics(object, prefilter = TRUE)
        expect_s4_class(object, "DataFrame")
        ## Check for run-length encoding.
        expect_true(all(bapply(object, is, class2 = "Rle")))
        ## Check that expected values match.
        ## Parameterized unit test is changing `nCount` to NA.
        x <- object[1L, c("nCount", "nFeature", "nMito"), drop = TRUE]
        x <- lapply(x, decode)
        y <- list(
            nCount = 61091L,
            nFeature = 264L,
            nMito = NA_integer_
        )
        expect_identical(x, y)
    },
    object = list(
        Matrix = counts(sce)
        ## nolint start
        ## > DelayedArray = DelayedArray(counts(sce))
        ## nolint end
    )
)

with_parameters_test_that(
    "SummarizedExperiment", {
        x <- calculateMetrics(object)
        expect_s4_class(x, "SummarizedExperiment")
    },
    object = list(
        SummarizedExperiment = rse,
        SingleCellExperiment = sce
    )
)

test_that("Low pass prefiltering", {
    ## All barcodes in example should pass.
    object <- sce
    x <- calculateMetrics(object, prefilter = TRUE)
    expect_identical(ncol(x), ncol(object))
    ## Simulate some poor barcodes.
    counts(object)[, seq_len(2L)] <- 0L
    x <- calculateMetrics(object, prefilter = TRUE)
    expect_identical(ncol(x), ncol(object) - 2L)
})
