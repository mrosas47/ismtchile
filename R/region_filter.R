#' @title Filtro de datos por región y área -- Filter data by region and area type
#'
#' @description Filtra la base de datos original de forma de incluir sólo la región y el área (urbana o rural) deseadas. La función asume que la data corresponde a la base de dato original del Censo 2017, obtenible a través de \code{load_data()}. \cr \cr Filters the original data so as to include only the desired region and area (urban or rural). The function assumes the data corresponds to the original Censo 2017 database, as can be obtained from \code{load_data()}.
#'
#' @param df objeto \code{data.frame}. Hasta la versión \code{1.x.x}, sólo se acepta el Censo 2017. \cr \cr \code{data.frame} object. As for package version \code{1.x.x}, only the 2017 Chilean census is accepted.
#' @param r integer. Se aceptan valores entre 1 y 16 para Chile 2017. Si \code{r == 99}, no se define una región en particular y se trabaja con valores a nivel nacional. \cr \cr integer. Values between 1 and 16 are acceptable for Chile 2017. If \code{r == 99}, no region will be defined and work will continue with national level values.
#' @param ur integer. Valores aceptables son \code{1} y \code{2}. Define si se requiere zona urbana \code{ur = 1} o rural \code{ur = 2}. \cr \cr integer. Accepted values are \code{1} and \code{2}. Defines whether urban \code{ur = 1} or rural \code{ur = 2} data is requested.
#' @param rfield string. Nombre del campo que corresponde al número de la región. Default es \code{region}. \cr \cr string. Name of the field corresponding to the region number. Default is \code{region}.
#' @param urfield string. Nombre del campo que define el tipo de área (urbana o rural). Default es \code{area}. \cr \cr string Name of the field corresponding to the desired area (urban or rural). Default is \code{area}.
#'
#' @import dplyr
#' @import magrittr
#' @import stringr
#' @import glue
#'
#' @return objeto \code{data.frame} con la información censal filtrada para la región de trabajo. \cr \cr \code{data.frame} object with the census information filtered for the working region.
#'
#' @export region_filter
#'
#' @examples c17 <- load_data(13, path = loc_dir) %>% region_filter(13, 1)

region_filter <- function(df, r, ur, rfield = 'region', urfield = 'area') {

  names(df)[names(df) == glue('{rfield}')] <- 'region'
  names(df)[names(df) == glue('{urfield}')] <- 'area'

  if (r %in% c(1 : 16, 99) & ur %in% c(1, 2)) {

    filtered_data <- df %>%
      filter(

        region == r,
        area == ur

      )

    return(filtered_data)

  } else if (!r %in% c(1 : 16, 99)) {

    return(message('r must be an integer in range 1:16 for specific region or 99 for national values'))

  } else if (ur != 1 & ur != 2) {

    return(message('ur must be an integer: 1 for urban areas, 2 for rural'))

  }

}

