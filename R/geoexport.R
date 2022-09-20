#' Exportar data espacial -- Export spatial data
#'
#' @description Exporta la data espacial derivada del cálculo del ISMT y posterior ejecución de \code{geomerge()} para espacializar. \cr \cr Exports spatial data derived from the calculation of ISMT and the execution of \code{geomerge()}.
#'
#' @param df objeto \code{data.frame}. La función asume una geodata obtenida desde \code{geomerge()}. \cr \cr \code{data.frame} object. Assumes a geodata obtained from \code{geomerge()}.
#' @param r integer. Número de la región de trabajo. Usado para nombrar el archivo. \cr \cr integer. Number of the working region. Used to name the file.
#' @param path string. Ubicación de la carpeta donde se deberían guardar los archivos. Si no se provee una ubicación, se crea la carpeta \code{C:/ISMT_Files/geodata} y se utiliza como \code{path}. \cr \cr string/ Location of the directory where files should be saved. If empty, creates new directory \code{C:/ISMT_Files/geodata}, which is then used as \code{path}.
#'
#' @return Retorna el archivo en la carpeta especificada. \cr \cr Returns file in specified folder.
#' @export geoexport
#'
#' @import tidyverse
#' @import sf
#' @import glue
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
