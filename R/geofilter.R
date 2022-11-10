#' @title Geofilter: filtro en base a datos geográficos || Geofilter: filter based in geographical data
#'
#' @param df Objeto \code{data.frame} corresponiente a la base de datos censales del año especificado. \cr \code{data.frame} object corresponding to the census database of the specified year.
#'
#' @param year \code{int}. Año de la base de datos. Para la versión \code{2.x.x}, acepta las bases de los censos 2017, 2012, 2002, 1992 y 1982. Default es \code{2017}. \cr \code{int}. Year of the database. For version \code{2.x.x}, census bases for years 2017, 2012, 2002, 1992 and 1982 are accepted.
#'
#' @param r \code{int}. Número de la región de trabajo. Para los años 2017 y 2012 se aceptan valores en \code{range(1 : 16, 99)}, y para los años 2002, 1992 y 1982 se aceptan valores en \code{range(1 : 15, 99)}. \cr \code{int}. Number od the working region. For years 2017 and 2012 values in \code{range(1 : 16, 99)} are accepted, while for years 2002, 1992 and 1982 values in \code{range(1 : 15, 99)}.
#'
#' @param area \code{int}. Código del tipo de área: \code{1} para \code{URBANO} o \code{2} para \code{RURAL}. Adicionalmente se da la opción \code{3} para \code{TODO}. A nivel de data, la categoría \code{RURAL} es válida para todos los censos; sin embargo, se debe considerar para posteriores análisis que solo 2017 y 2012 cuentan con coberturas geográficas para las áreas rurales. \cr \code{int}. Area type code: \code{1} for \code{URBANO} or \code{2} for \code{RURAL}. Aditionally, the option \code{3} for \code{TODO} is provided. At a data level, the \code{RURAL} category is valid for all censusses; however, it must be considerered for futher analysis that only 2017 and 2012 have spatial data for rural areas.
#'
#' @param rfield \code{int}. Nombre de la variable que contiene el código de región. Default es \code{id_region}. \cr \code{int}. Name of the variable that contains the region code.
#'
#' @param urfield \code{int}. Nombre de la variable que contiene el tipo de área. Default es \code{tipo_area}. \code{int}. Name of the variable that contains the area type. Default is \code{tipo_area}.
#'
#' @import dplyr
#' @import magrittr
#' @import stringr
#' @import glue
#'
#' @return Objeto \code{data.frame} con la data filtrada. \cr \code{data.frame} object with the filtered data.
#'
#' @export geofilter
#'
#' @examples c17rx <- region_filter(c17, 13, 1)
#'
geofilter <- function(df, year, r, area, rfield = 'id_region', urfield = 'tipo_area') {

  clone <- df

  names(clone)[names(clone) == glue('urfield')] <- 'tipo_area'

  rc = str_pad(

    r,
    width = 2,
    side = 'left',
    pad = '0'

  )

  if (

    r %in% c(1 : 16, 99) &
    area %in% c(1, 2)

  ) {

    if (area == 1) {key <- 'URBANO'} else if (area == 2) {key <- 'RURAL'}

    f <- clone %>%
      filter(

        id_region == rc,
        tipo_area == key

      )

    return(f)

  } else {

    return(

      message(

        'There seems to be an invalid parameter. Note that "r" can only be in range(1 : 16) and "area" can only be in range(1, 2). For debugging purposes, make sure both are class integer.'

      )

    )

  }

}
