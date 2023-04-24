#' @title Precálculos ISMT -- ISMT Precalculations
#'
#' @description Ejecuta precálculos necesarios para el resto del proceso del ISMT. \cr \cr Executes precalculations necessary for the rest of the ISMT process.
#'
#' @param df objecto \code{data.frame}. Asume que la base de datos ha pasado por \code{cleanup()}. \cr \cr \code{data.frame} object. Assumes the database has been through \code{cleanup()}.
#' @param hacin string. Nombre del campo del indicador de hacinamiento. Default es \code{ind_hacinam}. \cr \cr string. Name of the field with the overcrowding score. Default is \code{ind_hacinam}.
#' @param alleg string. Nombre del campo del indicador de allegamiento. Default es \code{n_hog_alleg}. \cr \cr string. Name of the field with the relative crowding score. Default is \code{n_hog_alleg}.
#' @param esc string. Nombre del campo del indicador de escolaridad del jefe de hogar. Default es \code{a_esc_cont}. \cr \cr string. Name of the field with the scholarship of the home head score. Default is \code{a_esc_cont}.
#' @param mat string. Nombre del campo del indicador de materialidad de la vivienda. Default es \code{ind_mater}. \cr \cr string. Name of the field with the dwelling material score. Default is \code{ind_mater}.
#'
#' @import dplyr
#' @import stringr
#'
#' @return objeto \code{data.frame} con los precálculos necesarios para calcular el ISMT. \cr \cr \code{data.frame} object with the necessary precalculations to calculate ISMT.
#' @export precalc
#'
#' @examples # c17 <- load_data(13, path = loc_dir) |> region_filter(13, 1) |> cleanup() |> precalc()

precalc <- function(df, hacin = 'ind_hacinam', alleg = 'n_hog_alleg', esc = 'a_esc_cont', mat = 'ind_mater') {

  ind_hacinam <- NULL
  n_hog_alleg <- NULL
  a_esc_cont <- NULL
  ind_mater <- NULL
  ind_alleg <- NULL

  normvar <- function(x) {

    (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))

  }


  names(df)[names(df) == stringr::str_glue('{hacin}')] <- 'ind_hacinam'
  names(df)[names(df) == stringr::str_glue('{alleg}')] <- 'n_hog_alleg'
  names(df)[names(df) == stringr::str_glue('{esc}')] <- 'a_esc_cont'
  names(df)[names(df) == stringr::str_glue('{mat}')] <- 'ind_mater'

  calculations <- df |>
    dplyr::mutate(

      ind_hacinam = -1 * ind_hacinam,
      ind_alleg = -1 * n_hog_alleg,

      ptje_esc = normvar(a_esc_cont) * 1000,
      ptje_hacin = normvar(ind_hacinam) * 1000,
      ptje_mater = normvar(ind_mater) * 1000,
      ptje_alleg = normvar(ind_alleg) * 1000

    )

  return(calculations)

}
