#' Census database cleanup
#'
#' @param df data.frame object; recommendation is to use the default 'Censo 2017 Chile' database
#' @param year integer, self-explanatory. Supported value is 2017 (alpha version), with 2012, 2002 and 1992 coming in later revisions
#' @param tiphog string: tipo de hogar field. Default is 'p01'
#' @param ocupac string: tipo de ocupacion field. Default is 'p02'
#' @param ndorms string: n de dormitorios field. Default is 'p04'
#' @param parent string: parentesco field. Default is 'p07'
#' @param muro string: condicion del muro field. Default is 'p03a'
#' @param techo string: condicion del techo field. Default is 'p03b'
#' @param suelo string: condicion del suelo field. Default is 'p03c'
#' @import dplyr
#' @import magrittr
#' @import stringr
#' @import glue
#'
#' @return data.frame object
#' @export cleanup
#'
#' @examples 'void for now'

cleanup <- function(df, year = 2017, tiphog = 'p01', ocupac = 'p02', ndorms = 'p04', parent = 'p07', muro = 'p03a', techo = 'p03b', suelo = 'p03c') {

  names(df)[names(df) == glue('{tiphog}')] <- 'p01'
  names(df)[names(df) == glue('{ocupac}')] <- 'p02'
  names(df)[names(df) == glue('{ndorms}')] <- 'p04'
  names(df)[names(df) == glue('{parent}')] <- 'p07'
  names(df)[names(df) == glue('{muro}')] <- 'p03a'
  names(df)[names(df) == glue('{techo}')] <- 'p03b'
  names(df)[names(df) == glue('{suelo}')] <- 'p03c'

  if (year == 2017) {

    cleandf <- df %>%
      filter(

        p07 == 1

      ) %>%
      mutate(

        esc_recode = case_when(

          p15 >= 1 & p15 <= 3   ~ 1L,
          p15 == 4              ~ 2L,
          p15 > 4 & p15 <= 6    ~ 3L,
          p15 > 6 & p15<=  10   ~ 4L,
          p15 == 11             ~ 5L,
          p15 == 12             ~ 6L,
          p15 >= 13 & p15 <= 14 ~ 7L,
          TRUE ~ NA_integer_

        ),
        esc_cat1 = if_else(esc_recode == 1, 1L, 0L),
        esc_cat2 = if_else(esc_recode == 2, 1L, 0L),
        esc_cat3 = if_else(esc_recode == 3, 1L, 0L),
        esc_cat4 = if_else(esc_recode == 4, 1L, 0L),
        esc_cat5 = if_else(esc_recode == 5, 1L, 0L),
        esc_cat6 = if_else(esc_recode == 6, 1L, 0L),
        esc_cat7 = if_else(esc_recode == 7, 1L, 0L),
        a_esc_cont = case_when(

          escolaridad == NA ~ NA_integer_,
          escolaridad == 99 ~ NA_integer_,
          escolaridad == 27 ~ NA_integer_,
          TRUE ~ escolaridad

        ),

        cond_muro = case_when(

          p03a >= 1 & p03a <= 3 ~ 3L,
          p03a >3 & p03a   <= 5 ~ 2L,
          p03a >5 & p03a   <= 7 ~ 1L,
          TRUE ~ NA_integer_

        ),
        cond_cubierta = case_when(

          p03b >= 1 & p03b <= 3  ~ 3L,
          p03b >3 & p03b <= 5    ~ 2L,
          p03b >5 & p03b <= 7    ~ 1L,
          TRUE ~ NA_integer_

        ),
        cond_suelo = case_when(

          p03c == 1             ~ 3L,
          p03c >1 & p03c <= 4   ~ 2L,
          p03c == 5             ~ 1L,
          TRUE ~ NA_integer_

        ),
        mat_aceptable   = if_else(cond_muro == 3 & cond_cubierta == 3 & cond_suelo == 3, 1L, 0L),
        mat_irrecup     = if_else(cond_muro == 1 | cond_cubierta == 1 | cond_suelo == 1, 1L, 0L),
        mat_recuperable = if_else(mat_aceptable == 0 & mat_irrecup == 0, 1L, 0L),
        ind_mater = cond_muro + cond_cubierta + cond_suelo,

        ind_hacinam = case_when(

          p04 >= 1 ~ cant_per / p04,
          p04 == 0 ~ cant_per * 2

        ),
        sin_hacin = if_else(ind_hacinam <= 2.4, 1L, 0L),
        hacin_medio = if_else(ind_hacinam > 2.4 & ind_hacinam <= 4.9, 1L, 0L),
        hacin_critico = if_else(ind_hacinam > 4.9, 1L, 0L),
        n = 1

      ) %>%
      filter(

        !is.na(hacin_critico)

      ) %>%
      mutate(

        n_hog_alleg = cant_hog - 1

      ) %>%
      select(

        'geocode', 'esc_recode', 'esc_cat1', 'esc_cat2', 'esc_cat3', 'esc_cat4', 'esc_cat5', 'esc_cat6', 'esc_cat7', 'cond_muro', 'cond_cubierta', 'cond_suelo', 'mat_aceptable', 'mat_irrecup', 'mat_recuperable', 'sin_hacin', 'hacin_medio', 'hacin_critico', 'a_esc_cont', 'ind_mater', 'ind_hacinam', 'n_hog_alleg', 'escolaridad', 'n'

      )

    return(cleandf)

  } else {

    message('not supported for alpha version')

  }

}

