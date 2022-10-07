#' @title Cálculo de ISMT completo a partir del Censo 2017 -- Full ISMT calculation from 2017 Census.
#'
#' @param df objeto \code{data.frame}. Se espera el Censo 2017. \cr \cr \code {data.frame} object. Expects 2017 Census.
#' @param r integer. Número de la región de trabajo. \cr \cr integer. Number of the working region.
#' @param ur integer. Define el tipo de área a trabajar (urbana \code{1} o rural \code{2}).
#' @param rfield string. Nombre del campo que corresponde al número de la región. Default es \code{region}. \cr \cr string. Name of the field corresponding to the region number. Default is \code{region}.
#' @param urfield string. Nombre del campo que define el tipo de área (urbana o rural). Default es \code{area}. \cr \cr string Name of the field corresponding to the desired area (urban or rural). Default is \code{area}.
#' @param year integer. Default es \code{2017}, que es la única disponible para la versión \code{1.x.x}. \cr \cr integer. Default is \code{2017}, which is the only supported for version \code{1.x.x}.
#' @param tiphog string. Nombre del campo de tipo de hogar. Default es \code{p01}. \cr \cr string. Name of the home type field. Default is \code{p01}.
#' @param ocupac string. Nombre del campo de ocupación de la vivienda. Default es \code{p02}. \cr \cr string. Name of the home occupation field. Default is \code{p02}.
#' @param ndorms string. Nombre del campo con el número de dormitorios del hogar. Default es \code{p04}. \cr \cr string. Name of the number of bedrooms field. Default is \code{p04}.
#' @param parent string. Nombre del campo de parentesco. Default es \code{p07}. \cr \cr string. Name of the familial relationship field. Default is \code{p07}.
#' @param muro string. Nombre del campo de condición del muro. Default es \code{p03a}. \cr \cr string. Name of the wall condition field. Default is \code{p03a}.
#' @param techo string. Nombre del campo de condición del techo. Default es \code{p03b}. \cr \cr string. Name of the ceiling condition field. Default is \code{p03b}.
#' @param suelo string. Nombre del campo de condición del suelo. Default es \code{p03c}. \cr \cr string. Name of the floor condition field. Default is \code{p03c}.
#' @param grouping string. Nombre del campo con la variable de la unidad espacial agrupadora. Default es \code{geocode}. \cr \cr string. Name of the field with the spacial grouping unit variable. Default is \code{geocode}.
#'
#' @import dplyr
#' @import magrittr
#' @import stringr
#' @import glue
#'
#' @return
#' @export
#'
#' @examples
full_ismt <- function (df, r, ur, rfield = 'region', urfield = 'area', year = 2017, tiphog = 'p01', ocupac = 'p02', ndorms = 'p04', parent = 'p07', muro = 'p03a', techo = p03b, suelo = 'p03c', grouping = 'geocode') {

  df0 <- df %>%
    ismtchile::region_filter(r = r, ur = ur) %>%
    ismtchile::cleanup() %>%
    ismtchile::precalc() %>%
    ismtchile::get_pca() %>%
    ismtchile::ismt_scores(criteria = criteria, r = r)

  return(df0)

}