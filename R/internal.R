# Validity checks ==============================================================
# Good example on how to set informative validity checks:
# http://adv-r.had.co.nz/S4.html
.valid <- function(list) {
    invalid <- Filter(f = Negate(isTRUE), x = list)
    if (has_length(invalid)) {
        unlist(invalid)
    } else {
        TRUE
    }
}



# Prototype metadata ===========================================================
.prototypeMetadata <- list(
    version = packageVersion("basejump.classes"),
    date = Sys.Date()
)

.hasPrototypeMetadata <- function(object) {
    is_subset(
        x = names(.prototypeMetadata),
        y = names(metadata(object))
    )
}

.assertHasPrototypeMetadata <- function(object) {
    assert_is_subset(
        x = names(.prototypeMetadata),
        y = names(metadata(object))
    )
}



# Prototype genome metadata ====================================================
.prototypeGenomeMetadata <- c(
    .prototypeMetadata,
    list(
        organism = character(),
        genomeBuild = character(),
        ensemblRelease = integer()
    )
)

.genomeMetadata <- function(object) {
    metadata <- metadata(object)
    prototypeMetadata <- .prototypeGenomeMetadata %>%
        .[setdiff(names(.), names(metadata))]
    c(prototypeMetadata, metadata)
}

.hasGenomeMetadata <- function(object) {
    all(genomeMetadataNames %in% names(metadata(object)))
}

.assertHasGenomeMetadata <- function(object) {
    if (!isTRUE(.hasGenomeMetadata(object))) {
        stop(paste0(
            "Object does not contain genome information.\n",
            "Requires: ", toString(genomeMetadataNames)
        ))
    }
    .assertHasPrototypeMetadata(object)
}