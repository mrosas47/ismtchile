#' Cálculo de ISMT completo a partir del Censo 2017 -- Full ISMT calculation from 2017 Census.
#'
#' @description 'pending'
#'
#'
#' @import dplyr
#' @import magrittr
#' @import stringr
#' @import glue
#'
#' @return data.frame with ISMT
#' @export full_ismt
#'
#' @examples ismt <- full_ismt(c17, 13, 1)

full_ismt <- function (df, r, ur, rfield = 'region', urfield = 'area', year = 2017, tiphog = 'p01', ocupac = 'p02', ndorms = 'p04', parent = 'p07', muro = 'p03a', techo = 'p03b', suelo = 'p03c', grouping = 'geocode') {

  df0 <- df %>%
    ismtchile::region_filter(r = r, ur = ur) %>%
    ismtchile::cleanup() %>%
    ismtchile::precalc() %>%
    ismtchile::get_pca() %>%
    ismtchile::ismt_scores(r = r)

  return(df0)

}
