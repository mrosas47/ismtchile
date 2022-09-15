#' Export geodata
#'
#' @param df data.frame. Expects processed shapefile data frame after geomerge()
#' @param r integer. Working region
#' @param path string. Path where files should be saved. Default is '', which creates C:/ISMT_Files/geodata
#'
#' @return message
#' @export geoexport
#'
#' @import tidyverse
#' @import sf
#'
#' @examples 'void for now'

geoexport <- function(df, r, path = '') {

  if (path == '') {

    message('"path is void"; files will be saved to C:/ISMT_Files/geodata')

    dir.create('C:/ISMT_Files')
    dir.create('C:/ISMT_Files/geodata')
    path = 'C:/ISMT_Files/geodata'

  } else {

    message(glue('Files will be saved to {path}'))

  }

  df %>% write_sf(glue('{path}/ISMT_R{r}_geodata.shp'))

  message('Geodata successfully exported!')

}
