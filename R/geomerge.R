#' Espacializando data del ISMT -- Spacializing ISMT data
#'
#' @description Espacializa la data obtenida del cálculo del ISMT mediante la unión con un shapefile de la unidad espacial correspondiente. \cr \cr Spacializes the data obtained from ISMT caclulation through merging with a shapefile of the corresponding spatial unit.
#'
#' @param df objeto \code{data.frame}. Asume que los datos estarán agrupados a la unidad espacial correspondiente al shapefile especificado, tras la ejecución de \code{ismt_scores()}.
#' @param shp objeto \code{simple feature} (ESRI shapefile). El uso esperado incluye el shapefile censal, disponible en la página oficial del Censo o a través de \code{load_shp()} para zonas urbanas y localidades rurales.
#' @param grouping.df string. Nombre del campo con la variable agrupadora en la tabla de datos \cr \cr string. Name of the field containing the grouping variable in the data table.
#' @param grouping.shp string. Nombre del campo con la variable agrupadora en el shapefile. \cr \cr string. Name of the field containing the grouping variable in the shapefile.
#'
#' @return objeto \code{data.frame} con la información espacializada, lista para exportar. \cr \cr \code{data.frame} object containing the spacialized information, ready for export.
#' @export geomerge
#'
#' @import glue
#' @import tidyverse
#' @import sf
#'
#' @examples 'void for now'

geomerge <- function(df, shp, grouping.df = 'zona', grouping.shp = 'GEOCODIGO') {

  names(df)[names(df) == glue('{grouping.df}')] <- 'zona'
  names(shp)[names(shp) == glue('{grouping.shp}')] <- 'zona'

  df <- df %>%
    mutate(

      zona = str_pad(zona, width = 11, pad = '0', side = 'left')

    )

  shp <- shp %>%
    mutate(

      zona = str_pad(zona, width = 11, pad = '0', side = 'left')

    )

  merged <- merge(shp, df, by = 'zona')

  return(merged)

}
