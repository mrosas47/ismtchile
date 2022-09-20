#' Limpieza de la base de datos censal -- Census database cleanup
#'
#' @description Limpia la base de datos de forma de normalizar los nombres de los campos y reducir la cantidad de variables, facilitando así la ejecución de las funciones que siguen en el flujo de cálculo. \cr \cr Cleans the database, normalizing the field names and reducing the number of variables, facilitiating the execution of the following functions down the workflow.
#'
#' @param df objeto \code{data.frame}. Se recomienda usar la base original del Censo 2017, disponible a través de \code{load_data()}. \cr \cr \code{data.frame} object; recommendation is to use the original 2017 census database, available through \code{load_data()}.
#' @param year integer. Default es \code{2017}, que es la única disponible para la versión \code{1.x.x}. \cr \cr integer. Default is \code{2017}, which is the only supported for version \code{1.x.x}.
#' @param tiphog string. Nombre del campo de tipo de hogar. Default es \code{p01}. \cr \cr string. Name of the home type field. Default is \code{p01}.
#' @param ocupac string. Nombre del campo de ocupación de la vivienda. Default es \code{p02}. \cr \cr string. Name of the home occupation field. Default is \code{p02}.
#' @param ndorms string. Nombre del campo con el número de dormitorios del hogar. Default es \code{p04}. \cr \cr string. Name of the number of bedrooms field. Default is \code{p04}.
#' @param parent string. Nombre del campo de parentesco. Default es \code{p07}. \cr \cr string. Name of the familial relationship field. Default is \code{p07}.
#' @param muro string. Nombre del campo de condición del muro. Default es \code{p03a}. \cr \cr string. Name of the wall condition field. Default is \code{p03a}.
#' @param techo string. Nombre del campo de condición del techo. Default es \code{p03b}. \cr \cr string. Name of the ceiling condition field. Default is \code{p03b}.
#' @param suelo string. Nombre del campo de condición del suelo. Default es \code{p03c}. \cr \cr string. Name of the floor condition field. Default is \code{p03c}.
#' @import dplyr
#' @import magrittr
#' @import stringr
#' @import glue
#'
#' @return objeto \code{data.frame} conteniendo solo las variables necesarias para los cálculos siguientes. \cr \cr \code{data.frame} object containing only the variables that are necessary for the following calculations.
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

    message('not supported for version 1.x.x')

  }

}

