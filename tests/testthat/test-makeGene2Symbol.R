context("makeGene2Symbol")

with_parameters_test_that(
    "makeGene2SymbolFromEnsDb", {
        object <- makeGene2SymbolFromEnsDb(
            object = "EnsDb.Hsapiens.v75",
            format = format
        )
        expect_s4_class(object, "Gene2Symbol")
    },
    format = eval(formals(makeGene2SymbolFromEnsDb)[["format"]])
)
