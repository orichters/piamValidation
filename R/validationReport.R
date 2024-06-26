#' perform validateScenarios and create an .html report using .Rmd templates
#'
#' @param dataPath one or multiple path(s) to scenario data in .mif or .csv
#'        format
#' @param config name of a config from inst/config
#' @param report specify which .Rmd file should be used to create report
#'
#' @export

validationReport <- function(dataPath, config, report = "default") {


  # convert relative to absolute paths
  dataPath <- normalizePath(dataPath)

  # for config only if no config in inst/config was chosen
  if (file.exists(normalizePath(config, mustWork = F))) {
    config <- normalizePath(config)
  }

  yamlParams <- list(mif = dataPath, cfg = config)

  report_name <- paste0("validation_", report)

  output_path <- paste0(getwd(), "/output")
  if (!dir.exists(output_path)) dir.create(output_path)

  # create default report for given data
  rmarkdown::render(paste0(path.package("piamValidation"),
                           "/markdown/", report_name, ".Rmd"),
                    params = yamlParams,
                    output_file = paste0(output_path, "/", report_name,
                                         format(Sys.time(), "_%Y%m%d-%H%M%S"),
                                         ".html"))

}

