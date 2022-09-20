#' Obtener criterio AIM para análisis de componentes principales -- Get AIM criteria for principal components analysis.
#'
#' @description Carga el criterio de corte estadístico AIM para el análisis de componentes principales. Descarga el archivo con la tabla de referencia a \code{path} para futuro uso. \cr \cr Loads AIM criteria for statistical cuts for principal components analysis. Downloads file with reference table to \code{path} for future use.
#'
#' @param year integer. Default es \code{2017}, que es el único año válido para la versión \code{1.x.x}. \cr \cr integer. Default is \code{2017}, which is the only valid year for version \code{1.x.x}.
#' @param path string. Ubicación de la carpeta donde se deberían guardar los archivos. En caso de no proveer una ubicación, se creará un carpeta \code{C:/ISMT_Files/data}, que se usará como \code{path}. \cr \cr string. Location of the directory where files should be saved. If empty, will create a \code{C:/ISMT_Files/data} folder, which will be used as \code{path}.
#'
#' @return objeto \code{data.frame} con los valores del criterio AIM para APC. \cr \cr \code{data.frame} object with the values for the AIM criteria for PCA.
#' @export get_criteria
#'
#' @import tidyverse
#' @import glue
#'
#' @examples 'void for now'

get_criteria <- function(year = 2017, path = '') {

  if (path == '') {

    message('"path is void"; files will be saved to C:/ISMT_Files/data')

    dir.create('C:/ISMT_Files')
    dir.create('C:/ISMT_Files/data')
    path = 'C:/ISMT_Files/data'

  } else {

    message(glue('Files will be saved to {path}'))

  }

  download.file(url = 'https://drive.google.com/uc?export=download&id=1y3_afJ9ik0CsTzMveM398RZl4s27nZnk', destfile = glue('{path}/ISMT_criteria.csv'))

  criteria <- read.csv2(glue('{path}/ISMT_criteria.csv'))

  return(criteria)

}
