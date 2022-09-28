#' Exportar datos del ISMT -- Export ISMT data
#'
#' @description Exporta datos resultantes de la ejecución del cálculo del ISMT a la carpeta especificada. \cr \cr Exports data resulting from the calculation of ISMT to the specified directory.
#'
#' @param df objeto \code{data.frame}, que corresponde a la data a exportar. \cr \code{data.frame} object, corresponding to the data to be exported.
#' @param r integer. Número de la región trabajada. Se especifica para dar nombre al archivo. \cr \cr integer. Number of the working region. Specified to name the file.
#' @param path string. Ubicación de la carpeta donde se deberían guardar los archivos. En caso de no proveer una ubicación, se creará un carpeta \code{C:/ISMT_Files/data}, que se usará como \code{path}. \cr \cr string. Location of the directory where files should be saved. If empty, will create a \code{C:/ISMT_Files/data} folder, which will be used as \code{path}.
#' @param format string. Formato para guardar el archivo. Default es \code{rds}, y también se acepta \code{csv}. \cr \cr string. Format for the saved file. Default is \code{rds}, but \code{csv} is also accepted.
#'
#' @return Retorna el archivo en la carpeta. \cr \cr Returns the file in directory.
#' @export data_export
#'
#' @import tidyverse
#'
#' @examples c17 %>% data_export(13, loc_dir)

data_export <- function(df, r , path = '', format = 'rds') {

  region <- str_pad(as.charatcer(r), pad = '0', side = 'left', width = 2)

  if (path == '') {

    message('"path is void"; files will be saved to C:/ISMT_Files/data')

    dir.create('C:/ISMT_Files')
    dir.create('C:/ISMT_Files/data')
    path = 'C:/ISMT_Files/data'

  } else {

    message(glue('Files will be saved to {path}'))

  }

  if (format == 'rds') {

    df %>% saveRDS(glue('{path}/ISMT_R{region}_data.rds'))

  } else if (format == 'csv') {

    df %>% write.csv2(glue('{path}/ISMT_R{r}_data.csv'))

  }

}
