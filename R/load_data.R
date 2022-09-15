#' Downloading Census data
#'
#' @param r integer. Defines the desired region. Accepted values range from 1 to 16, and 99. If r == 99, the program will download each region separately and bind them together, so it could take a minute.
#' @param year integer. Defines the year of the desired data. Default is 2017, which is the only valid one as for revision 0.x.x
#' @param path string. Defines the path of the directory where files will be stored. Default is '' (empty), which will create a new directory 'C:/ISMT_Files' and store data there.
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
