#' Cálculos finales de ISMT -- ISMT final calculations
#'
#' @description Ejecuta los cálculos finales de ISMT. Define los grupos socioeconómicos por unidad territorial y los cuantifica en varias categorías. \cr \cr Executes the final ISMT calculations. Defines the socio-economic groups and quantifies them in several categories.
#'
#' @param df objeto \code{data.frame}. Asume que la base de datos ha pasado por \code{cleanup()}, \code{precalc()}, y \code{get_pca()}. \cr \cr \code{data.frame} object. Assumes the database has been through \code{cleanup()}, \code{precalc()}, and \code{get_pca()}.
#' @param criteria objeto \code{data.frame} que contenga los criterios estadísticos AIM para el análisis de componentes principales. \cr \cr \code{data.frame} object that contains the AIM statistical criteria for principal components analysis.
#' @param r integer. Número de la región de trabajo. Acepta valores entre 1 y 16; si \code{r = 99}, se utilizan valores a nivel nacional. \cr \cr integer. Number of the working region. Accepts values between 1 and 16; if \code{r = 99}, national-level values will be used.
#' @param ismt_score string. Nombre del campo del puntaje ISMT, calculado desde \code{get_pca()}. Default es \code{ismt_pn}. \cr \cr string. Name of the ISMT sscore field, as calculated from \code{get_pca()]}. Default is \code{ismt_pn}.
#' @param grouping string. Nombre del campo con la variable de la unidad espacial agrupadora. Default es \code{geocode}. \cr \cr string. Name of the field with the spacial grouping unit variable. Default is \code{geocode}.
#' @param n string. Nombre del campo derivado de \code{cleanup()} que tiene valor \code{n = 1} para cada jefe de hogar. Usado para conteo de totales. Default es \code{n}. \cr \cr string. Name of the field, derived from \code{cleanup()}, that  has value \code{n = 1} for each home head. Default es \code{n}.
#'
#' @import tidyverse
#' @import glue
#'
#' @return objeto \code{data.frame} agrupado por la unidad espacial especificada con información de ISMT. \cr \cr \code{data.frame} object grouped by the specified spatial unit with ISMT information.
#' @export ismt_scores
#'
#' @examples c17 <- load_data(13, path = loc_dir) %>% region_filter(13, 1) %>% cleanup() %>% precalc() %>% get_pca() %>% ismt_scores(crit_AIM, 13)

ismt_scores <- function(df, r, ismt_score = 'ismt_pn', grouping = 'geocode') {

  names(df)[names(df) == glue('{ismt_score}')] <- 'ismt_pn'
  names(df)[names(df) == glue('{grouping}')] <- 'geocode'

  cuts <- spawn_AIMcuts() %>% filter(as.numeric(region) == r)

  q <- as.data.frame(quantile(df$ismt_pn, prob = seq(0, 1, length = 101)))

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

  ismt <- df %>%
    mutate(

      Q1 = if_else(ismt_pn > q1cut, 1L, 0L),
      Q2 = if_else(ismt_pn <= q1cut & ismt_pn > q2cut, 1L, 0L),
      Q3 = if_else(ismt_pn <= q2cut & ismt_pn > q3cut, 1L, 0L),
      Q4 = if_else(ismt_pn <= q3cut & ismt_pn > q4cut, 1L, 0L),
      Q5 = if_else(ismt_pn <= q4cut, 1L, 0L),

      AB = if_else(ismt_pn > abq, 1L, 0L),
      C1 = if_else(ismt_pn <= abq & ismt_pn > c1q, 1L, 0L),
      C2 = if_else(ismt_pn <= c1q & ismt_pn > c2q, 1L, 0L),
      C3 = if_else(ismt_pn <= c2q & ismt_pn > c3q, 1L, 0L),
      D = if_else(ismt_pn <= c3q & ismt_pn > dq, 1L, 0L),
      E = if_else(ismt_pn <= dq, 1L, 0L),

      Alto = if_else(ismt_pn > c1q, 1L, 0L),
      Medio = if_else(ismt_pn <= c1q & ismt_pn > c3q, 1L, 0L),
      Bajo = if_else(ismt_pn <= c3q, 1L, 0L),

      ind_hacinam = -1 * ind_hacinam,
      ind_alleg = -1 * ind_alleg,

      zona = geocode

    ) %>%
    group_by(

      zona

    ) %>%
    summarise(

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

    ) %>%
    mutate(

      gse_prom = case_when(

        ismtpn > abq ~ 'AB',
        ismtpn <= abq & ismtpn > c1q ~ 'C1',
        ismtpn <= c1q & ismtpn > c2q ~ 'C2',
        ismtpn <= c2q & ismtpn > c3q ~ 'C3',
        ismtpn <= c3q & ismtpn > dq ~ 'D',
        ismtpn <= dq ~ 'E'

      ),
      gse_dom = case_when(

        AB > C1 & AB > C2 & AB > C3 & AB > D & AB > E ~ 'AB',
        C1 > AB & C1 > C2 & C1 > C3 & C1 > D & C1 > E ~ 'C1',
        C2 > AB & C2 > C1 & C2 > C3 & C2 > D & C2 > E ~ 'C2',
        C3 > AB & C3 > C1 & C3 > C2 & C3 > D & C3 > E ~ 'C3',
        D > AB & D > C1 & D > C2 & D > C3 & D > E ~ 'D',
        E > AB & E > C1 & E > C2 & E > C3 & E > D ~ 'E',
        TRUE ~ 'VALORES IGUALES'

      )

    ) %>%
    select(

      zona, total_hogs, ismtpn, gse_prom, gse_dom, Q1, Q2, Q3, Q4, Q5, Alto, Medio, Bajo, AB, C1, C2, C3, D, E, ind_hac, hacin_cri, hacin_med, hacin_no, alleg, escolar, mat_acept, mat_recup, mat_irrec, ind_mat

    )

  return(ismt)

}
