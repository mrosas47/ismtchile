#' Precalculations: normalized indicator scores
#'
#' @param df data.frame object. As for alpha version, assumes database has been through cleanup() function.
#' @param hacin string. Hacinamiento indicator field. Default is 'ind_hacinam'
#' @param alleg string. Allegamiento indicator field. Default is 'ind_alleg'
#' @param esc string. Escolaridad indicator field. Default is 'ind_esc'
#' @param mat string. Hacinamiento indicator field. Default is 'ind_mater'
#'
#' @import tidyverse
#' @import glue
#'
#' @return data.frame object
#' @export precalc
#'
#' @examples 'void for now'

precalc <- function(df, hacin = 'ind_hacinam', alleg = 'n_hog_alleg', esc = 'a_esc_cont', mat = 'ind_mater') {

  names(df)[names(df) == glue('{hacin}')] <- 'ind_hacinam'
  names(df)[names(df) == glue('{alleg}')] <- 'n_hog_alleg'
  names(df)[names(df) == glue('{esc}')] <- 'a_esc_cont'
  names(df)[names(df) == glue('{mat}')] <- 'ind_mater'

  calculations <- df %>%
    mutate(

      ind_hacinam = -1 * ind_hacinam,
      ind_alleg = -1 * ind_mater,

      ptje_esc = ismtchile::normvar(a_esc_cont) * 1000,
      ptje_hacin = ismtchile::normvar(ind_hacinam) * 1000,
      ptje_mater = ismtchile::normvar(ind_mater) * 1000,
      ptje_alleg = ismtchile::normvar(ind_alleg) * 1000

    )

  return(calculations)

}
