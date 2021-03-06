## This code depends on biomaRt and Ensembl, which can time out.

context("extra | matchHumanOrthologs")

test_that("matchHumanOrthologs", {
    genes <- c(
        "ENSMUSG00000000001", "ENSMUSG00000000003",
        "ENSMUSG00000000028", "ENSMUSG00000000031",
        "ENSMUSG00000000037", "ENSMUSG00000000049"
    )
    object <- matchHumanOrthologs(genes, ensemblRelease = 87L)
    expected <- tibble(
        geneID = c(
            "ENSMUSG00000000001",
            "ENSMUSG00000000003",
            "ENSMUSG00000000028",
            "ENSMUSG00000000031",
            "ENSMUSG00000000037",
            "ENSMUSG00000000049"
        ),
        hgncID = c(
            "ENSG00000065135",
            NA,
            "ENSG00000093009",
            NA,
            "ENSG00000102098",
            "ENSG00000091583"
        ),
        geneName = c(
            "Gnai3",
            "Pbsn",
            "Cdc45",
            "H19",
            "Scml2",
            "Apoh"
        ),
        hgncName = c(
            "GNAI3",
            NA,
            "CDC45",
            NA,
            "SCML2",
            "APOH"
        )
    )
    expect_identical(object, expected)
})
