#' All global variables
#' @noRd
NULL



globalVariables(".")

.version <- packageVersion("basejump")



#' Single-sell barcode pattern
#'
#' Trailing number is to match cellranger output.
#'
#' @export
#' @note Updated 2019-08-21.
#'
#' @examples
#' barcodePattern
barcodePattern <- ")_([ACGT_]{6,})(_[0-9]+)?$"



#' basejump test data URL
#'
#' @export
#' @keywords internal
#' @note Updated 2019-08-21.
#'
#' @examples
#' basejumpTestsURL
basejumpTestsURL <- paste0(
    "http://tests.acidgenomics.com/basejump/",
    "v", .version$major, ".", .version$minor  # nolint
)



#' Shared list of optional default formals
#'
#' @export
#' @note Updated 2019-11-19.
#'
#' @examples
#' formalsList
formalsList <- list(
    color.continuous = quote(
        getOption(
            x = "acid.color.continuous",
            default = acidplots::scale_color_synesthesia_c()
        )
    ),
    color.discrete = quote(
        getOption(
            x = "acid.color.discrete",
            default = acidplots::scale_color_synesthesia_d()
        )
    ),
    fill.continuous = quote(
        getOption(
            x = "acid.fill.continuous",
            default = acidplots::scale_fill_synesthesia_c()
        )
    ),
    fill.discrete = quote(
        getOption(
            x = "acid.fill.discrete",
            default = acidplots::scale_fill_synesthesia_d()
        )
    ),
    flip = quote(
        getOption(x = "acid.flip", default = TRUE)
    ),
    heatmap.color = quote(
        getOption(
            x = "acid.heatmap.color",
            default = acidplots::blueYellow
        )
    ),
    heatmap.correlation.color = quote(
        getOption(
            x = "acid.heatmap.correlation.color",
            default = viridis::viridis
        )
    ),
    heatmap.legend.color = quote(
        getOption(
            x = "acid.heatmap.legend.color",
            default = acidplots::synesthesia
        )
    ),
    heatmap.quantile.color = quote(
        getOption(
            x = "acid.heatmap.quantile.color",
            default = viridis::viridis
        )
    ),
    label = quote(
        getOption(x = "acid.label", default = FALSE)
    ),
    legend = quote(
        getOption(x = "acid.legend", default = TRUE)
    ),
    point.size = quote(
        getOption(x = "acid.point.size", default = 3L)
    )
)



#' Slot names in metadata containing genome information
#'
#' @export
#' @note Updated 2019-08-21.
#'
#' @examples
#' genomeMetadataNames
genomeMetadataNames <- c("organism", "genomeBuild", "ensemblRelease")



#' Sequencing lane grep pattern
#'
#' @export
#' @note Updated 2019-08-21.
#'
#' @examples
#' lanePattern
lanePattern <- "_L([[:digit:]]{3})"



#' Sample metadata blacklist
#'
#' @export
#' @note `sampleID` is set automatically for multiplexed/cell-level data.
#' @note Updated 2019-09-05.
#'
#' @examples
#' metadataBlacklist
metadataBlacklist <- sort(c(
    ## Automatic / used internally:
    "interestingGroups",
    "revcomp",
    "rowname",
    ## > "sampleID",
    ## interestingGroups variants:
    "interestinggroups",
    "intgroup",
    ## sampleID, sampleName variants:
    "ID",
    "Id",
    "id",
    "name",
    "names",
    "sample",
    "samples",
    "sampleId",
    "sampleid",
    "sampleNames",
    "samplename",
    "samplenames"
))



#' Quality control metric columns
#'
#' Column names returned by `calculateMetrics()`.
#'
#' @export
#' @note Previously: "nGene", "log10GenesPerUMI".
#' @note Updated 2019-08-21.
#'
#' @examples
#' metricsCols
metricsCols <- c(
    "nCount",
    "nFeature",
    "nCoding",
    "nMito",
    "log10FeaturesPerCount",
    "mitoRatio"
)



#' Update message
#'
#' @export
#' @keywords internal
#' @note Updated 2019-08-21.
#'
#' @examples
#' message(updateMessage)
updateMessage <- "Run 'updateObject()' to update your object."
