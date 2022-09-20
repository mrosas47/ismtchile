#' Descargar data censal -- Downloading census data
#'
#' @description Descarga la base de datos original del Censo 2017 de Chile a \code{path} y la carga a RStudio, quedando lista para su uso. \cr \cr Downloads the original 2017 Chilean Census database to \code{path} and loads it to RStudio, making it immediately available for use.
#'
#' @param r integer. Número de la región de trabajo. Acepta valores entre 1 y 16. Si \code{r = 99}, descarga la data censal completa. \code{r = 99} y \code{r = 13} aumentan considerablemente el tiempo de ejecución debido a la gran cantidad de datos. \cr \cr integer. Number of the working region. Accepts values between 1 and 16. If \code{r = 99}, will download the entire database. \code{r = 99} and \code{r = 13} considerably increase execution time due to the volume of data.
#' @param year integer. Define el año de los datos a descargar. Para la versión \code{1.x.x}, solo se acepta {2017}. \cr \cr integer. Defines the year of the data to download. As for version \code{1.x.x}, only \code{2017} is accepted.
#' @param path string. Ubicación de la carpeta donde se deberían guardar los archivos. En caso de no proveer una ubicación, se creará un carpeta \code{C:/ISMT_Files/data}, que se usará como \code{path}. \cr \cr string. Location of the directory where files should be saved. If empty, will create a \code{C:/ISMT_Files/data} folder, which will be used as \code{path}.
#'
#' @import glue
#' @import tidyverse
#' @import magrittr
#' @import Randomuseragent
#' @import iptools
#'
#' @return data.frame object
#' @export load_data
#'
#' @examples 'void for now'

load_data <- function (r, year = 2017, path = '') {

  reg <- str_pad(as.character(r), width = 2, pad = '0', side = 'left')

  userpool <- filter_useragent(min_obs = 5000, software_name = 'Chrome', software_type = 'browser', operating_system_name = 'Windows', layout_engine_name = 'Blink')

  dir.create('C:/temp')

  download.file(url = 'https://drive.google.com/uc?export=download&id=1rhznVVFLn4OasXZOXMbqiUTHvLur2EVA', destfile = 'C:/temp/urls.csv')

  links <- read.csv2('C:/temp/urls.csv')

  if (path == '') {

    dir.create('C:/ISMT_Files')
    dir.create('C:/ISMT_Files/data')

    path = 'C:/ISMT_Files/data'

    message(glue('"path" argument is void; files will be saved to C:/ISMT_Files/data '))

  } else {

    message(glue('Files will be saved to {path}'))

  }

  if (r %in% c(1 : 12, 14 : 16)) {

    x <- links %>% filter(R == glue('R{reg}'))

    link <- x$link[1]

    user <- sample(userpool, size = 1)

    ip_proxy <- ip_random(1)

    withr::with_options(list(HTTPUserAgent = user, proxy = ip_proxy), download.file(url = link, destfile = glue('{path}/R{reg}.rds'), mode = 'wb', headers = c('Connection' = 'keep-alive')))

    c17 <- readRDS(glue('{path}/R{reg}.rds'))

  } else if (r == 13) {

    dir.create(glue('{path}/R13tempdir'))

    c17 <- data.frame()

    temp13 <- links %>% filter(str_sub(R, 1, 3) == 'R13')

    r13list <- temp13$link

    n = 0

    for (l in r13list) {

      user <- sample(userpool, size = 1)

      ip_proxy <- ip_random(1)

      withr::with_options(list(HTTPUserAgent = user, proxy = ip_proxy), download.file(url = l, destfile = glue('{path}/R13tempdir/R13s{n}.rds'), mode = 'wb', headers = c('Connection' = 'keep-alive')))

      n = n + 1

    }

    templist <- list.files(path = glue('{path}/R13tempdir'), full.names = T)

    for (t in templist) {

      tempdf <- readRDS(glue('{t}'))

      c17 <- rbind(c17, tempdf)

      rm(tempdf)

      unlink(t)

    }

    c17 %>% saveRDS(glue('{path}/R13.rds'))

    unlink(glue('{path}/R13tempdir'), recursive = T, force = T)

  } else if (r == 99) {

    allurl <- links$link

    dir.create(glue('{path}/R99tempdir'))

    c17 <- data.frame()

    n <- 0

    for (i in allurl) {

      user <- sample(userpool, size = 1)

      ip_proxy <- ip_random(1)

      withr::with_options(list(HTTPUserAgent = user, proxy = ip_proxy), download.file(url = i, destfile = glue('{path}/R99tempdir/R99s{n}.rds'), mode = 'wb', headers = c('Connection' = 'keep-alive')))

      n <- n + 1

    }

    templist <- list.files(path = glue('{path}/R99tempdir'), full.names = T)

    for (t in templist) {

      tempdf <- readRDS(glue('{t}'))

      c17 <- rbind(c17, tempdf)

      rm(tempdf)

      unlink(t)

    }

    c17 %>% saveRDS(glue('{path}/R99.rds'))

    unlink(glue('{path}/R99tempdir'), recursive = T, force = T)

  }

  unlink('C:/temp/urls.csv')
  unlink('C:/temp', recursive = T, force = T)

  return(c17)

}
