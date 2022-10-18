#' Cálculo de ISMT completo a partir del Censo 2017 -- Full ISMT calculation from 2017 Census.
#'
#' @description Ejecuta el cálculo completo del ISMT
#'
#' @param df objeto \code{data.frame}. Hasta la versión \code{1.x.x}, sólo se acepta el Censo 2017. \cr \cr \code{data.frame} object. As for package version \code{1.x.x}, only the 2017 Chilean census is accepted.
#' @param r integer. Se aceptan valores entre 1 y 16 para Chile 2017. Si \code{r == 99}, no se define una región en particular y se trabaja con valores a nivel nacional. \cr \cr integer. Values between 1 and 16 are acceptable for Chile 2017. If \code{r == 99}, no region will be defined and work will continue with national level values.
#' @param ur integer. Valores aceptables son \code{1} y \code{2}. Define si se requiere zona urbana \code{ur = 1} o rural \code{ur = 2}. \cr \cr integer. Accepted values are \code{1} and \code{2}. Defines whether urban \code{ur = 1} or rural \code{ur = 2} data is requested.
#' @param rfield string. Nombre del campo que corresponde al número de la región. Default es \code{region}. \cr \cr string. Name of the field corresponding to the region number. Default is \code{region}.
#' @param urfield string. Nombre del campo que define el tipo de área (urbana o rural). Default es \code{area}. \cr \cr string Name of the field corresponding to the desired area (urban or rural). Default is \code{area}.
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
#' @return objeto data.frame conteniendo
#' @export full_ismt
#'
#' @examples ismt <- full_ismt(c17, 13, 1)

full_ismt <- function (df, r, ur, rfield = 'region', urfield = 'area', year = 2017, tiphog = 'p01', ocupac = 'p02', ndorms = 'p04', parent = 'p07', muro = 'p03a', techo = 'p03b', suelo = 'p03c', grouping = 'geocode') {

  df0 <- df %>%
    ismtchile::region_filter(r = r, ur = ur, rfield = rfield, urfield = urfield) %>%
    ismtchile::cleanup(tiphog = tiphog, ocupac = ocupac, ndorms = ndorms, parent = parent, muro = muro, techo = techo, suelo = suelo) %>%
    ismtchile::precalc() %>%
    ismtchile::get_pca() %>%
    ismtchile::ismt_scores(r = r, grouping = grouping)

  return(df0)

}
