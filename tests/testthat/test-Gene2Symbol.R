context("Gene2Symbol")

format <- eval(formals(`Gene2Symbol,SummarizedExperiment`)[["format"]])

with_parameters_test_that(
    "Gene2Symbol", {
        object <- Gene2Symbol(rse, format = format)
        expect_s4_class(object, "Gene2Symbol")
        expect_identical(colnames(object), c("geneID", "geneName"))
    },
    format = format
)

rm(format)

test_that("No mappings", {
    object <- rse
    mcols(rowRanges(object))[["geneName"]] <- NULL
    expect_error(
        object = Gene2Symbol(object),
        regexp = "geneName"
    )
})

test_that("summary", {
    x <- Gene2Symbol(rse)
    output <- capture.output(summary(x))
    expect_identical(
        head(output, n = 1L),
        paste("genes:", nrow(rse))
    )
})
