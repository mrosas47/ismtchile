#' @title Filtro de datos por región y área -- Filter data by region and area type
#'
#' @description Filtra la base de datos original de forma de incluir sólo la región y el área (urbana o rural) deseadas. La función asume que la data corresponde a la base de dato original del Censo 2017, obtenible a través de \code{load_data()}. \cr Filters the original data so as to include only the desired region and area (urban or rural). The function assumes the data corresponds to the original Censo 2017 database, as can be obtained from \code{load_data()}.
#'
#' @param df objeto \code{data.frame}. Hasta la versión 1.x.x, sólo se acepta el Censo 2017. \cr \code{data.frame} object. As for package version 1.x.x, only the 2017 Chilean census is accepted.
#' @param r integer. Values between 1 and 16 are acceptable for Chile 2017. If r == 99, no region will be defined and work will continue with national level values.
#' @param ur integer. Accepted values are ´1´ and ´2´. Defines whether urban or rural data is requested.
#' @param rfield string. Name of the field corresponding to the region number. Default is ´region´
#' @param urfield string. Name of the field corresponding to the desired area (urban or rural). Default is ´area´
#'
#' @import dplyr
#' @import magrittr
#' @import stringr
#' @import glue
#'
#' @return data.frame object
#'
#' @export region_filter
#'
#' @examples 'void for now'

region_filter <- function(df, r, ur, rfield = 'region', urfield = 'area') {

  names(df)[names(df) == glue('{rfield}')] <- 'region'
  names(df)[names(df) == glue('{urfield}')] <- 'area'

  if (r %in% c(1 : 16, 99) & ur %in% c(1, 2)) {

    filtered_data <- df %>%
      filter(

        region == str_pad(as.character(r), pad = '0', width = 2, side = 'left'),
        area == ur

      )

    return(filtered_data)

  } else if (!r %in% c(1 : 16, 99)) {

    return(message('r must be an integer in range 1:16 for specific region or 99 for national values'))

  } else if (ur != 1 & ur != 2) {

    return(message('ur must be an integer: 1 for urban areas, 2 for rural'))

  }

}

