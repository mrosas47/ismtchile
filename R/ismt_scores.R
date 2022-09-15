#' ISMT Scores: final calculations
#'
#' @param df data.frame object. Assumes database has been through the previous cleanup and calculation steps (cleanup, precalc, get_pca)
#' @param criteria data.frame object. Criteria for statistical cuts. As for alpha version, only 2017 AIM cuts are accepted.
#' @param r integer. Defines working region in order to filter criteria. Accepted values are between 1:16, and 99 (for country-wide values)
#' @param ismt_score string. Defines the ISMT scores field as obtained from get_pca(). Default is 'ismt_pn'
#' @param grouping string. Defines grouping variable. Default is 'geocode', as defined in the original Censo 2017 database. As for alpha version this is the only accepted value; future revisions will accept the 'manzent' field for 2012, 2002 and 1992 databases.
#' @param n string. Name of the field, expected to be derived from running cleanup(), that has a value = 1 for every home in the database. Used for counting total number of homes by grouping unit. Default is 'n'
#' @param get_criteria boolean. Default is FALSE. If TRUE, will temporarily download the file with the AIM criteria to C:/temp and will disappear after the execution of the function.
#'
#' @import tidyverse
#' @import glue
#'
#' @return data.frame object
#' @export ismt_scores
#'
#' @examples 'void for now'

ismt_scores <- function(df, criteria, r, ismt_score = 'ismt_pn', grouping = 'geocode', n = 'n', get_criteria = F) {

  names(df)[names(df) == glue('{ismt_score}')] <- 'ismt_pn'
  names(df)[names(df) == glue('{grouping}')] <- 'geocode'
  names(df)[names(df) == glue('{n}')] <- 'n'

  cuts <- criteria %>%
    filter(

      as.numeric(region) == r

    )

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

      zona = geocode

    ) %>%
    group_by(

      zona

    ) %>%
    summarise(

      total_hogs = sum(n),
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

      'zona', 'ismtpn', 'gse_prom', 'gse_dom', 'Q1', 'Q2', 'Q3', 'Q4', 'Q5', 'Alto', 'Medio', 'Bajo', 'AB', 'C1', 'C2', 'C3', 'D', 'E', 'ind_hac', 'hacin_cri', 'hacin_med', 'hacin_no', 'alleg', 'escolar', 'mat_acept', 'mat_recup', 'mat_irrec', 'ind_mat'

    )

  return(ismt)

}
