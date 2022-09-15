#' Load spatial information
#'
#' @param r integer. Define the desired region. Acceptable values are between 1 : 16, and 99. If r == 99, country-wide data will be used.
#' @param ur integer. Define desired area (urban or rural). Values are 1 or 2, respectively.
#' @param path string. Directory where files should be downloaded. Default is '', which will create a directory to C:/ISMT_Files.
#'
#' @import sf
#' @import tidyverse
#' @import glue
#'
#' @return simple feature object (ESRI shapefile)
#' @export load_shp
#'
#' @examples 'void for now'

load_shp <- function(r, ur, path = '') {

  region = str_pad(r, pad = '0', side = 'left', width = 2)

  if (path == '') {

    if (dir.exists('C:/ISMT_Files') == TRUE) {

      dir.create(path = 'C:/ISMT_Files/shps', showWarnings = FALSE)

      path = 'C:/ISMT_Files/shps'

      message('"path" parameter is void; files will be stored in new directory "C:/ISMT_Files/shps"')

    } else if (dir.exists('C:/ISMT_Files') == FALSE) {

      dir.create(path = 'C:/ISMT_Files', showWarnings = FALSE)

      dir.create(path = 'C:/ISMT_Files/shps', showWarnings = FALSE)

      path = 'C:/ISMT_Files/shps'

      message('"path" parameter is void; files will be stored in new directory "C:/ISMT_Files/shps"')

    }

  } else {

    message(glue('Files will be saved to "{path}"'))

  }

  if (region == '01') {

    download.file(url = 'http://drive.google.com/uc?export=download&id=1lpW0bll6Hw5nlPEzwwjDwKpPysTggNJW', destfile = glue('{path}/R{region}.zip'), mode = 'wb')

  } else if (region == '02') {

    download.file(url = 'https://drive.google.com/uc?export=download&id=1aw9JIAhCAxz3boElbbKhu3R8Qr2_22mO', destfile = glue('{path}/R{region}.zip'), mode = 'wb')

  } else if (region == '03') {

    download.file(url = 'https://drive.google.com/uc?export=download&id=1f599dWo-GRqW-n4pnA117RRmEg5f3DB8', destfile = glue('{path}/R{region}.zip'), mode = 'wb')

  } else if (region == '04') {

    download.file(url = 'https://drive.google.com/uc?export=download&id=1pUM7kwN9xkfPRoj0jk2zb1BERqWYVYHl', destfile = glue('{path}/R{region}.zip'), mode = 'wb')

  } else if (region == '05') {

    download.file(url = 'https://drive.google.com/uc?export=download&id=1zxE9tdwHAxppi3-ml_WAkvcDksFu8hrb', destfile = glue('{path}/R{region}.zip'), mode = 'wb')

  } else if (region == '06') {

    download.file(url = 'https://drive.google.com/uc?export=download&id=1Ll6KkA-I5bJhe9c34sxsnmnkDb14J8Bx', destfile = glue('{path}/R{region}.zip'), mode = 'wb')

  } else if (region == '07') {

    download.file(url = 'https://drive.google.com/uc?export=download&id=1Q_17dpxRwAMbZXxuEZ288jG1J58G22Ii', destfile = glue('{path}/R{region}.zip'), mode = 'wb')

  } else if (region == '08') {

    download.file(url = 'https://drive.google.com/uc?export=download&id=1W5E5a5VOI-Cua5Ra4V2tpgZDZGzUEDv-', destfile = glue('{path}/R{region}.zip'), mode = 'wb')

  } else if (region == '09') {

    download.file(url = 'https://drive.google.com/uc?export=download&id=1EKNdr32qnB3O47XefuiqzvHuD1ivvh_N', destfile = glue('{path}/R{region}.zip'), mode = 'wb')

  } else if (region == '10') {

    download.file(url = 'https://drive.google.com/uc?export=download&id=1wHlUwVaJ9r7NUjVerQc4gzlz2aFkXJjs', destfile = glue('{path}/R{region}.zip'), mode = 'wb')

  } else if (region == '11') {

    download.file(url = 'https://drive.google.com/uc?export=download&id=1NLaIYIWoVdad1ftPSnMCbeAsmSF4xjgH', destfile = glue('{path}/R{region}.zip'), mode = 'wb')

  } else if (region == '12') {

    download.file(url = 'https://drive.google.com/uc?export=download&id=1R0UBaVG2sXW1DVFgK_71cCMYlyNlV0bR', destfile = glue('{path}/R{region}.zip'), mode = 'wb')

  } else if (region == '13') {

    download.file(url = 'https://drive.google.com/uc?export=download&id=12vIJNsh6bo1biK0nt5Vt16yIQ_W1xqtH', destfile = glue('{path}/R{region}.zip'), mode = 'wb')

  } else if (region == '14') {

    download.file(url = 'https://drive.google.com/uc?export=download&id=1NJ9pOJ18X4IZJBY4V4_VzKB47kvf3BtM', destfile = glue('{path}/R{region}.zip'), mode = 'wb')

  } else if (region == '15') {

    download.file(url = 'https://drive.google.com/uc?export=download&id=1xB11Udfsj7WfsAiWjNwj8nJWY_keVpRi', destfile = glue('{path}/R{region}.zip'), mode = 'wb')

  } else if (region == '16') {

    download.file(url = 'https://drive.google.com/uc?export=download&id=1-nCV0Q4mvTNDuxK8GohDJY15CIYH_Kqa', destfile = glue('{path}/R{region}.zip'), mode = 'wb')

  } else if (region == '99') {

    download.file(url = 'https://drive.google.com/uc?export=download&id=1em_vDdGqW0XKGFtpUiGWil8TtKuSL0xj', destfile = glue('{path}/R{region}.zip'), mode = 'wb')

  }

  unzip(glue('{path}/R{r}.zip'), exdir = glue('{path}'))

  unlink(glue('{path}/R{region}.zip'))

  if (ur == 1) {

    shp <- read_sf(glue('{path}/R{region}/r{region}_urbano.shp'))

  } else if (ur == 2) {

    shp <- read_sf(glue('{path}/R{region}/r{region}_rural.shp'))

  }

  return(shp)

}
