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
#' @examples c17 <- load_data(13, path = loc_dir) %>% region_filter(13, 1) %>%  cleanup()

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

        cond_muro = case_when(

          p03a >= 1 & p03a <= 3 ~ 3,
          p03a > 3 & p03a <= 5 ~ 2,
          p03a > 5 & p03a <= 7 ~ 1,
          TRUE ~ NA_integer_

        ),
        cond_techo = case_when(

          p03b >= 1 & p03b <= 3 ~ 3,
          p03b > 3 & p03b <= 5 ~ 2,
          p03b > 5 & p03b <= 7 ~ 1,
          TRUE ~ NA_integer_

        ),
        cond_suelo = case_when(

          p03c == 1 ~ 3,
          p03c > 1 & p03c <= 4 ~ 2,
          p03c == 5 ~ 1,
          TRUE ~ NA_integer_

        ),
        mat_aceptable   = if_else(cond_muro == 3 & cond_techo == 3 & cond_suelo == 3, 1, 0),
        mat_irrecup     = if_else(cond_muro == 1 | cond_techo == 1 | cond_suelo == 1, 1, 0),
        mat_recuperable = if_else(mat_aceptable == 0 & mat_irrecup == 0, 1, 0),
        ind_mater = cond_muro + cond_techo + cond_suelo,

        ind_hacinam = case_when(

          p04 >= 1 ~ cant_per / p04,
          p04 == 0 ~ cant_per * 2

        ),
        sin_hacin = if_else(ind_hacinam <= 2.4, 1, 0),
        hacin_medio = if_else(ind_hacinam > 2.4 & ind_hacinam <= 4.9, 1, 0),
        hacin_critico = if_else(ind_hacinam > 4.9, 1, 0),

        a_esc_cont = case_when(

          escolaridad == NA ~ NA_integer_,
          escolaridad == 99 ~ NA_integer_,
          escolaridad == 27 ~ NA_integer_,
          T ~ escolaridad

        )

      ) %>%
      filter(

        !is.na(hacin_critico)

      ) %>%
      mutate(

        n_hog_alleg = cant_hog - 1

      ) %>%
      select(

        geocode, cond_muro, cond_techo, cond_suelo, mat_aceptable, mat_irrecup, mat_recuperable, sin_hacin, hacin_medio, hacin_critico, a_esc_cont, ind_mater, ind_hacinam, n_hog_alleg, escolaridad

      )

    return(cleandf)

  } else if (year == 2012) {

    nhogares2012 <- df %>%

      filter(dpar == 1) %>%
      group_by(folio, nviv) %>%
      summarise(
        cant_hog = as.integer(n())
      ) %>%
      ungroup()

    c12clean <- df %>%
      left_join(nhogares2012, by = c("folio", "nviv")) %>%
      mutate(

        escolaridad = case_when(
          p28 == 1 ~ 0L,
          p28 == 2 ~ 0L,
          p28 == 3 ~ 0L,
          p28 == 4 ~ 0L,
          p28 == 5 ~ p30,
          p28 == 6 ~ p30 + 8L,
          p28 == 7 ~ p30 + 8L,
          p28 == 8 ~ p30 + 12L,
          p28 == 9 ~ p30 + 12L,
          p28 == 10 ~ p30 + 12L,
          p28 == 11 ~ p30 + 17L,
          p28 == 12 & p30 <= 2 ~ p30 + 19L,
          p28 == 12 & p30 > 2 ~ 21L,
          TRUE ~ NA_integer_
        ),
        cant_per = if_else(v09m < 98 & v09m != 0, v09m, NA_integer_),
        cant_hog = if_else(cant_hog < 98 , cant_hog, NA_integer_)

      )

    cleandf <- c12clean %>%
      filter(

        p07 == 1

      ) %>%
      mutate(

        cond_muro = case_when(

          p03a %in% c(1 : 3) ~ 3,
          p03a %in% c(4, 5) ~ 2,
          p03a == 6 ~ 1,
          TRUE ~ NA_integer_

        ),
        cond_techo = case_when(

          p03b %in% c(1 : 3) ~ 3,
          p03b %in% c(4, 5) ~ 2,
          p03b %in% c(6, 7) ~ 1,
          TRUE ~ NA_integer_

        ),
        cond_suelo = case_when(

          p03c %in% c(1 : 3) ~ 3,
          p03c %in% c(4 : 6) ~ 2,
          p03c == 7 ~ 1,
          TRUE ~ NA_integer_

        ),
        mat_aceptable   = if_else(cond_muro == 3 & cond_techo == 3 & cond_suelo == 3, 1, 0),
        mat_irrecup     = if_else(cond_muro == 1 | cond_techo == 1 | cond_suelo == 1, 1, 0),
        mat_recuperable = if_else(mat_aceptable == 0 & mat_irrecup == 0, 1, 0),
        ind_mater = cond_muro + cond_techo + cond_suelo,

        ind_hacinam = case_when(

          p04 >= 1 ~ cant_per / p04,
          p04 == 0 ~ cant_per * 2

        ),
        sin_hacin = if_else(ind_hacinam <= 2.4, 1, 0),
        hacin_medio = if_else(ind_hacinam > 2.4 & ind_hacinam <= 4.9, 1, 0),
        hacin_critico = if_else(ind_hacinam > 4.9, 1, 0),

        a_esc_cont = case_when(

          escolaridad == NA ~ NA_integer_,
          escolaridad == 99 ~ NA_integer_,
          escolaridad == 27 ~ NA_integer_,
          T ~ escolaridad

        )

      ) %>%
      filter(

        !is.na(hacin_critico)

      ) %>%
      mutate(

        n_hog_alleg = cant_hog - 1

      ) %>%
      select(

        geocode, cond_muro, cond_techo, cond_suelo, mat_aceptable, mat_irrecup, mat_recuperable, sin_hacin, hacin_medio, hacin_critico, a_esc_cont, ind_mater, ind_hacinam, n_hog_alleg, escolaridad

      )

    return(cleandf)

  } else {

    message('not supported for version 1.x.x')

  }

}

