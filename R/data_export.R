#' Export ISMT data
#'
#' @param df data.frame
#' @param r integer
#' @param path string
#' @param format string
#'
#' @return message
#' @export data_export
#'
#' @import tidyverse
#'
#' @examples 'void for now'

data_export <- function(df, r , path = '', format = 'rds') {

  if (path == '') {

    message('"path is void"; files will be saved to C:/ISMT_Files/data')

    dir.create('C:/ISMT_Files')
    dir.create('C:/ISMT_Files/data')
    path = 'C:/ISMT_Files/data'

  } else {

    message(glue('Files will be saved to {path}'))

  }

  if (format == 'rds') {

    df %>% saveRDS(glue('{path}/ISMT_R{r}_data.rds'))

  } else if (format == 'csv') {

    df %>% write.csv2(glue('{path}/ISMT_R{r}_data.csv'))

  }

}
