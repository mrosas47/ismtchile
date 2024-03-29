#' Datos de ejemplo, censo 2017 || || Example data, 2017 census (Chile)
#'
#' @description Data de ejemplo proveniente del censo 2017. Corresponde a la comuna de San Pablo, X Región de Los Lagos. Se eligió por su pequeño tamaño, adecuado para límites de tamaño de archivo de CRAN y GitHub. Obtenido de la página oficial del INE y filtrado por comuna. || || Example data from 2017 Chilean census. It is the data from San Pablo commune. It was chosen because of its small size, appropriate for CRAN and GitHub file size limitations. Obtained from INE's official website and filtered by commune.
#'
#' @format ## `c17_example`
#' A data frame with 7512 rows and 60 columns:
#'  \describe{
#'    \item{region}{ID de la región || Region ID}
#'    \item{provincia}{ID de la provincia || Province ID}
#'    \item{comuna}{ID de la comuna || Commune ID}
#'    \item{dc}{ID del distrito || District ID}
#'    \item{area}{ID del área || Area ID}
#'    \item{zc_loc}{Zona local || Local zone}
#'    \item{id_zc_loc}{ID de zona local || Local zone ID}
#'    \item{nviv}{Número de la vivienda || Dwelling number}
#'    \item{p01 - p16a}{Preguntas del censo || Census questions}
#'  }
#'
"c17_example"
