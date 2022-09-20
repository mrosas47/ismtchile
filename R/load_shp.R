#' Descargar información espacial -- Download spatial information
#'
#' @description Descarga ESRI shapefile de la región especificada a \code{path} y lo carga a RStudio. \cr \cr Downloads ESRI shapefile of the specified region to \code{path} and loads it to RStudio.
#'
#' @param r integer. Número de la región de trabajo. Acepta valores entre 1 y 16; si \code{r = 99}, se utilizan valores a nivel nacional. \cr \cr integer. Number of the working region. Accepts values between 1 and 16; if \code{r = 99}, national-level values will be used.
#' @param ur integer. Valores aceptables son \code{1} y \code{2}. Define si se requiere zona urbana \code{ur = 1} o rural \code{ur = 2}. \cr \cr integer. Accepted values are \code{1} and \code{2}. Defines whether urban \code{ur = 1} or rural \code{ur = 2} data is requested.
#' @param path string. Ubicación de la carpeta donde se deberían guardar los archivos. En caso de no proveer una ubicación, se creará un carpeta \code{C:/ISMT_Files/data}, que se usará como \code{path}. \cr \cr string. Location of the directory where files should be saved. If empty, will create a \code{C:/ISMT_Files/data} folder, which will be used as \code{path}.
#'
#' @import sf
#' @import tidyverse
#' @import glue
#'
#' @return objeto \code{single feature}. ESRI shapefile de la región especificada. \cr \cr \code{single feature} object. ESRI shapefile of the specified region.
#' @export load_shp
#'
#' @examples c17geo <- load_shp(13, 1, loc_dir)

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
