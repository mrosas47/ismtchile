#' Get AIM criteria for PCA
#'
#' @param year integer
#' @param path string
#'
#' @return data.frame
#' @export get_criteria
#'
#' @import tidyverse
#'
#' @examples 'void for now'

get_criteria <- function(year = 2017, path = '') {

  if (path == '') {

    message('"path is void"; files will be saved to C:/ISMT_Files/data')

    dir.create('C:/ISMT_Files')
    dir.create('C:/ISMT_Files/data')
    path = 'C:/ISMT_Files/data'

  } else {

    messages(glue('Files will be saved to {path}'))

  }

  download.file(url = 'https://drive.google.com/uc?export=download&id=1y3_afJ9ik0CsTzMveM398RZl4s27nZnk', destfile = glue('{path}/ISMT_criteria.csv'))

  criteria <- read.csv2(glue('{path}/ISMT_criteria.csv'))

  return(criteria)

}
