#' Adding ISMT data to shapefile
#'
#' @param df data.frame object, corresponding to the data obtained from the previous steps. Assumes 'df' will be grouped by the appropriate geographic unit; in case of Censo2017, the grouping variable is 'geocode', which through the ismt_scores() function has been renamed 'zona'.
#' @param shp simple feature object (ESRI shapefile). Usage is intended for the shapefile downloaded through load_shp(), or, alternatively, the official shapefile obtained directly from INE. If downloaded directly from INE, make sure the geographic unit matches the grouping used in the calculation process.
#' @param grouping.df string. Name of the field containing the grouping variable in the data table.
#' @param grouping.shp string. Name of the field containing the grouping variable in the shapefile.
#'
#' @return data.frame object.
#' @export geomerge
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
