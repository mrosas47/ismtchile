#' Cálculos finales de ISMT -- ISMT final calculations
#'
#' @description Ejecuta los cálculos finales de ISMT. Define los grupos socioeconómicos por unidad territorial y los cuantifica en varias categorías. \cr \cr Executes the final ISMT calculations. Defines the socio-economic groups and quantifies them in several categories.
#'
#' @param df objeto \code{data.frame}. Asume que la base de datos ha pasado por \code{cleanup()}, \code{precalc()}, y \code{get_pca()}. \cr \cr \code{data.frame} object. Assumes the database has been through \code{cleanup()}, \code{precalc()}, and \code{get_pca()}.
#' @param r integer. Número de la región de trabajo. Acepta valores entre 1 y 16; si \code{r = 99}, se utilizan valores a nivel nacional. \cr \cr integer. Number of the working region. Accepts values between 1 and 16; if \code{r = 99}, national-level values will be used.
#' @param ismt_score string. Nombre del campo del puntaje ISMT, calculado desde \code{get_pca()}. Default es \code{ismt_pn}. \cr \cr string. Name of the ISMT sscore field, as calculated from \code{get_pca()]}. Default is \code{ismt_pn}.
#' @param grouping string. Nombre del campo con la variable de la unidad espacial agrupadora. Default es \code{geocode}. \cr \cr string. Name of the field with the spacial grouping unit variable. Default is \code{geocode}.
#'
#' @import dplyr
#' @import stringr
#' @importFrom stats quantile
#'
#' @return objeto \code{data.frame} agrupado por la unidad espacial especificada con información de ISMT. \cr \cr \code{data.frame} object grouped by the specified spatial unit with ISMT information.
#' @export ismt_scores
#'
#' @examples # ismt <- c17 |>
#' #literalize(2017) |>
#' #dplyr::filter(id_region == 13, tipo_area == 2) |>
#' #cleanup() |>
#' #precalc() |>
#' #get_pca() |>
#' #ismt_scores(13, 2017)

ismt_scores <- function(df, r, ismt_score = 'ismt_pn', grouping = 'geocode') {

  region <- NULL
  ismt_pn <- NULL
  ind_hacinam <- NULL
  ind_alleg <- NULL
  geocode <- NULL
  zona <- NULL
  Q1 <- NULL
  Q2 <- NULL
  Q3 <- NULL
  Q4 <- NULL
  Q5 <- NULL
  Alto <- NULL
  Medio <- NULL
  Bajo <- NULL
  AB <- NULL
  C1 <- NULL
  C2 <- NULL
  C3 <- NULL
  E <- NULL
  hacin_critico <- NULL
  hacin_medio <- NULL
  sin_hacin <- NULL
  escolaridad <- NULL
  mat_aceptable <- NULL
  mat_recuperable <- NULL
  mat_irrecup <- NULL
  ind_mater <- NULL
  total_hogs <- NULL
  ismtpn <- NULL
  gse_prom <- NULL
  gse_dom <- NULL
  ind_hac <- NULL
  hacin_cri <- NULL
  hacin_med <- NULL
  hacin_no <- NULL
  alleg <- NULL
  escolar <- NULL
  mat_acept <- NULL
  mat_recup <- NULL
  mat_irrec <- NULL
  ind_mat <- NULL

  names(df)[names(df) == stringr::str_glue('{ismt_score}')] <- 'ismt_pn'
  names(df)[names(df) == stringr::str_glue('{grouping}')] <- 'geocode'

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

  cuts <- spawn_AIMcuts() |> dplyr::filter(as.numeric(region) == r)

  q <- as.data.frame(stats::quantile(df$ismt_pn, prob = seq(0, 1, length = 101)))

  abcut = 100 - as.numeric(cuts$ab)
  c1cut = 100 - (as.numeric(cuts$c1a) + as.numeric(cuts$c1b) + as.numeric(cuts$ab))
  c2cut = 100 - (as.numeric(cuts$c2) + as.numeric(cuts$ab) + as.numeric(cuts$c1a) + as.numeric(cuts$c1b))
  c3cut = 100 - (as.numeric(cuts$c3) + as.numeric(cuts$ab) + as.numeric(cuts$c1a) + as.numeric(cuts$c1b) + as.numeric(cuts$c2))
  dcut = 100 - (as.numeric(cuts$d) + as.numeric(cuts$ab) + as.numeric(cuts$c1a) + as.numeric(cuts$c1b) + as.numeric(cuts$c2) + as.numeric(cuts$c3))

  abq = q[abcut + 1,]
  c1q = q[c1cut + 1,]
  c2q = q[c2cut + 1,]
  c3q = q[c3cut + 1,]
  dq = q[dcut + 1,]

  q1cut = q[81,]
  q2cut = q[61,]
  q3cut = q[41,]
  q4cut = q[21,]

  ismt <- df |>
    dplyr::mutate(

      Q1 = dplyr::if_else(ismt_pn > q1cut, 1L, 0L),
      Q2 = dplyr::if_else(ismt_pn <= q1cut & ismt_pn > q2cut, 1L, 0L),
      Q3 = dplyr::if_else(ismt_pn <= q2cut & ismt_pn > q3cut, 1L, 0L),
      Q4 = dplyr::if_else(ismt_pn <= q3cut & ismt_pn > q4cut, 1L, 0L),
      Q5 = dplyr::if_else(ismt_pn <= q4cut, 1L, 0L),

      AB = dplyr::if_else(ismt_pn > abq, 1L, 0L),
      C1 = dplyr::if_else(ismt_pn <= abq & ismt_pn > c1q, 1L, 0L),
      C2 = dplyr::if_else(ismt_pn <= c1q & ismt_pn > c2q, 1L, 0L),
      C3 = dplyr::if_else(ismt_pn <= c2q & ismt_pn > c3q, 1L, 0L),
      D = dplyr::if_else(ismt_pn <= c3q & ismt_pn > dq, 1L, 0L),
      E = dplyr::if_else(ismt_pn <= dq, 1L, 0L),

      Alto = dplyr::if_else(ismt_pn > c1q, 1L, 0L),
      Medio = dplyr::if_else(ismt_pn <= c1q & ismt_pn > c3q, 1L, 0L),
      Bajo = dplyr::if_else(ismt_pn <= c3q, 1L, 0L),

      ind_hacinam = -1 * ind_hacinam,
      ind_alleg = -1 * ind_alleg,

      zona = geocode

    ) |>
    dplyr::group_by(

      zona

    ) |>
    dplyr::summarise(

      total_hogs = n(),
      ismtpn = mean(ismt_pn),
      Q1 = sum(Q1),
      Q2 = sum(Q2),
      Q3 = sum(Q3),
      Q4 = sum(Q4),
      Q5 = sum(Q5),
      Alto = sum(Alto),
      Medio = sum(Medio),
      Bajo =  sum(Bajo),
      AB = sum(AB),
      C1 = sum(C1),
      C2 = sum(C2),
      C3 = sum(C3),
      D = sum(D),
      E = sum(E),
      ind_hac = mean(ind_hacinam),
      hacin_cri = sum(hacin_critico),
      hacin_med = sum(hacin_medio),
      hacin_no = sum(sin_hacin),
      alleg = sum(ind_alleg),
      escolar = mean(escolaridad),
      mat_acept = sum(mat_aceptable),
      mat_recup = sum(mat_recuperable),
      mat_irrec = sum(mat_irrecup),
      ind_mat = mean(ind_mater)

    ) |>
    dplyr::mutate(

      gse_prom = dplyr::case_when(

        ismtpn > abq ~ 'AB',
        ismtpn <= abq & ismtpn > c1q ~ 'C1',
        ismtpn <= c1q & ismtpn > c2q ~ 'C2',
        ismtpn <= c2q & ismtpn > c3q ~ 'C3',
        ismtpn <= c3q & ismtpn > dq ~ 'D',
        ismtpn <= dq ~ 'E'

      ),
      gse_dom = dplyr::case_when(

        AB > C1 & AB > C2 & AB > C3 & AB > D & AB > E ~ 'AB',
        C1 > AB & C1 > C2 & C1 > C3 & C1 > D & C1 > E ~ 'C1',
        C2 > AB & C2 > C1 & C2 > C3 & C2 > D & C2 > E ~ 'C2',
        C3 > AB & C3 > C1 & C3 > C2 & C3 > D & C3 > E ~ 'C3',
        D > AB & D > C1 & D > C2 & D > C3 & D > E ~ 'D',
        E > AB & E > C1 & E > C2 & E > C3 & E > D ~ 'E',
        TRUE ~ 'VALORES IGUALES'

      )

    ) |>
    dplyr::select(

      zona, total_hogs, ismtpn, gse_prom, gse_dom, Q1, Q2, Q3, Q4, Q5, Alto, Medio, Bajo, AB, C1, C2, C3, D, E, ind_hac, hacin_cri, hacin_med, hacin_no, alleg, escolar, mat_acept, mat_recup, mat_irrec, ind_mat

    )

  return(ismt)

}
