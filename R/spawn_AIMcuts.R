#' @title Criterio AIM para cortes estadísticos -- AIM criteria for statistical cuts
#'
#' @description Función que no recibe parámetros, solo define un \code{data.frame} de referencia que contiene los cortes estadísticos AIM, actualizados al 2021. -- Function that does not receive any parameters, it only defines a reference \code{data.frame} containing the AIM statistical cuts, updated for 2021.
#'
#' @return \code{data.frame} object
#' @export spawn_AIMcuts
#'
#' @examples ref <- spawn_AIMcuts()

spawn_AIMcuts <- function() {

  region <- c(1 : 16, 99)

  ab <- c(1.3, 1.7, .9, .3, .9, .4, .4, .7, .5, .6, 1.2, 1.6, 3.6, .8, .5, .3, 1.8)

  c1a <- c(6.6, 6.8, 5.3, 3.2, 5.6, 3.3, 2.4, 3.8, 3.5, 4, 7.6, 7.1, 9, 4.5, 4.6, 2.9, 6)

  c1b <- c(6.9, 7.8, 5.6, 4.6, 6.5, 4.5, 3.9, 5.3, 4.2, 4.8, 7.3, 8.4, 8.1, 5, 6, 4.2, 6.3)

  c2 <- c(13.7, 19.5, 12.7, 9.8, 12.1, 9.9, 7.4, 9.4, 7.8, 8.9, 12.8, 17.2, 13.7, 8.6, 11.7, 7.4, 11.2)

  c3 <- c(30, 33.8, 33.1, 24.9, 26.8, 23.7, 19.8, 21.9, 18.8, 21.5, 27.8, 34.8, 27.2, 21.4, 29.2, 19, 24.7)

  d <- c(33.2, 25.4, 34.7, 42.4, 37.1, 41.7, 44.5, 42.2, 42.6, 44.6, 36, 27, 30.6, 41.7, 38.3, 42.5, 36)

  e <- c(8.3, 5, 7.6, 14.7, 11.1, 16.5, 21.5, 16.7, 22.5, 15.6, 7.1, 3.9, 7.8, 17.9, 9.7, 23.7, 14)

  df <- data.frame(region, ab, c1a, c1b, c2, c3, d, e)

  return(df)

}




