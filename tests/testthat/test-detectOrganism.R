context("detectOrganism")

with_parameters_test_that(
    "Homo sapiens", {
        expect_identical(
            object = detectOrganism(object),
            expected = "Homo sapiens"
        )
    },
    object = c(
        "Homo sapiens",
        "hsapiens",
        "GRCh38",
        "hg38",
        "ENSG00000000001",
        "ENST00000000001"
    )
)

with_parameters_test_that(
    "detectOrganism : Mus musculus", {
        expect_identical(
            object = detectOrganism(object),
            expected = "Mus musculus"
        )
    },
    object = c(
        "Mus musculus",
        "mmusculus",
        "GRCm38",
        "mm10",
        "ENSMUSG00000000001",
        "ENSMUST00000000001"
    )
)

with_parameters_test_that(
    "Rattus norvegicus", {
        expect_identical(
            object = detectOrganism(object),
            expected = "Rattus norvegicus"
        )
    },
    object = c(
        "Rattus norvegicus",
        "rnorvegicus",
        "Rnor_6.0",
        "rn5",
        "ENSRNOG00000000001",
        "ENSRNOT00000000001"
    )
)

with_parameters_test_that(
    "Danio rerio", {
        expect_identical(
            object = detectOrganism(object),
            expected = "Danio rerio"
        )
    },
    object = c(
        "Danio rerio",
        "drerio",
        "GRCz10",
        "danRer10",
        "ENSDARG00000000001",
        "ENSDART00000000001"
    )
)

with_parameters_test_that(
    "Drosophila melanogaster", {
        expect_identical(
            object = detectOrganism(object),
            expected = "Drosophila melanogaster"
        )
    },
    object = c(
        "Drosophila melanogaster",
        "dmelanogaster",
        "BDGP6",
        "dm6",
        "FBgn0000001",
        "FBtr0000001"
    )
)

with_parameters_test_that(
    "Caenorhabditis elegans", {
        expect_identical(
            object = detectOrganism(object),
            expected = "Caenorhabditis elegans"
        )
    },
    object = c(
        "Caenorhabditis elegans",
        "celegans",
        "WBcel235",
        "ce11",
        "WBGene00000001"
    )
)

with_parameters_test_that(
    "Gallus gallus", {
        expect_identical(
            object = detectOrganism(object),
            expected = "Gallus gallus"
        )
    },
    object = c(
        "Gallus gallus",
        "ggallus",
        "ENSGALG00000000001",
        "ENSGALT00000000001"
    )
)

with_parameters_test_that(
    "Ovis aries", {
        expect_identical(
            object = detectOrganism(object),
            expected = "Ovis aries"
        )
    },
    object = c(
        "Ovis aries",
        "oaries",
        "Oar_v3.1",
        "oviAri3",
        "ENSOARG00000000001",
        "ENSOART00000000001"
    )
)

test_that("Multiple organisms", {
    ## Function matches only the first genome.
    expect_identical(
        object = detectOrganism(c(
            "ENSG00000000001",
            "ENSG00000000002",
            "ENSMUSG00000000001",
            "ENSMUSG00000000002"
        )),
        expected = "Homo sapiens"
    )
})

test_that("Unsupported organism", {
    expect_error(
        object = detectOrganism("XXX"),
        regexp = "Failed to detect organism"
    )
})
