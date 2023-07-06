#' @title Limpieza de la base de datos censal -- Census database cleanup
#'
#' @description Limpia la base de datos de forma de normalizar los nombres de los campos y reducir la cantidad de variables, facilitando así la ejecución de las funciones que siguen en el flujo de cálculo. || || Cleans the database, normalizing the field names and reducing the number of variables, facilitiating the execution of the following functions down the workflow.
#'
#' @param df objeto \code{data.frame}. Se recomienda usar la base original del Censo 2017, disponible a través de la página oficial del INE. || || \code{data.frame} object; recommendation is to use the original 2017 census database, available through INE's official website.
#' @param year integer. Default es \code{2017}. || || integer. Default is \code{2017}.
#' @param vars.as.factors \code{boolean}. Si las variables están como factores (como en las bases censales originales), cambiar a \code{TRUE}. Default es \code{FALSE}, ya que se asume que la base pasá por la función \code{literalize()}. || || \code{boolean}. If variables are as factors (like in the original census databases), change to \code{TRUE}. Default is \code{FALSE}, as it is assumed the database has been through the \code{literalize()} function.
#' @param level \code{string}. Nivel de agrupación de los datos finales. Acepta valores \code{zc} (zona censal) y \code{mzn} (manzana). El nivel de manzana no está disponible para el 2017 debido al secreto estadístico de la base de datos de origen. Default es \code{zc}. || || \code{string}. Grouping level for the final data. Values \code{zc} (census zone) and \code{mzn} (block). Block level is not available for 2017 due to statistical secret of original database. Default is \code{zc}.
#' @param tipo_viv string. Nombre del campo de tipo de vivienda. Default es \code{tipoviv}. || || string. Name of the dwelling type field. Default is \code{tipoviv}.
#' @param ocupacion string. Nombre del campo de ocupación de la vivienda. Default es \code{ocup_viv}. || || string. Name of the home occupation field. Default is \code{ocup_viv}.
#' @param dormitorios string. Nombre del campo con el número de dormitorios del hogar. Default es \code{ndorms}. || || string. Name of the number of bedrooms field. Default is \code{ndorms}.
#' @param parentesco string. Nombre del campo de parentesco. Default es \code{parentesco}. || || string. Name of the familial relationship field. Default is \code{parentesco}.
#' @param muro string. Nombre del campo de condición del muro. Default es \code{mat_muro}. || || string. Name of the wall condition field. Default is \code{mat_muro}.
#' @param techo string. Nombre del campo de condición del techo. Default es \code{mat_techo}. || || string. Name of the ceiling condition field. Default is \code{mat_techo}.
#' @param piso string. Nombre del campo de condición del suelo. Default es \code{mat_piso}. || || string. Name of the floor condition field. Default is \code{mat_piso}.
#' @import dplyr
#' @import stringr
#'
#' @return objeto \code{data.frame} conteniendo solo las variables necesarias para los cálculos siguientes. || || \code{data.frame} object containing only the variables that are necessary for the following calculations.
#' @export cleanup
#'
#' @examples
#'  data(c17_example)
#'  clean <- c17_example |> literalize(2017) |> cleanup()

cleanup <- function(df, year = 2017, vars.as.factors = FALSE, level = 'zc', tipo_viv = 'tipoviv', ocupacion = 'ocup_viv', parentesco = 'parentesco', dormitorios = 'ndorms', muro = 'mat_muro', techo = 'mat_techo', piso = 'mat_piso') {

  cond_muro <- NULL
  cond_techo <- NULL
  cond_piso <- NULL
  mat_aceptable <- NULL
  mat_irrecup <- NULL
  ind_hacinam <- NULL
  hacin_critico <- NULL
  cant_hog <- NULL
  geocode <- NULL
  mat_recuperable <- NULL
  sin_hacin <- NULL
  hacin_medio <- NULL
  a_esc_cont <- NULL
  ind_mater <- NULL
  n_hog_alleg <- NULL
  escolaridad <- NULL

  pass <- function() {}
  `%notin%` <- Negate(`%in%`)

  if (vars.as.factors == FALSE) {

    clone <- df

    names(clone)[names(clone) == str_glue('{tipo_viv}')] <- 'tipoviv'
    names(clone)[names(clone) == str_glue('{ocupacion}')] <- 'ocup_viv'
    names(clone)[names(clone) == str_glue('{parentesco}')] <- 'parentesco'
    names(clone)[names(clone) == str_glue('{dormitorios}')] <- 'ndorms'
    names(clone)[names(clone) == str_glue('{muro}')] <- 'mat_muro'
    names(clone)[names(clone) == str_glue('{techo}')] <- 'mat_techo'
    names(clone)[names(clone) == str_glue('{piso}')] <- 'mat_piso'

#     if (
#
#       is.character(clone$tipoviv) == TRUE |
#       is.character(clone$ocup_viv) == TRUE |
#       is.character(clone$parentesco) == TRUE |
#       is.character(clone$mat_muro) == TRUE |
#       is.character(clone$mat_techo) == TRUE |
#       is.character(clone$mat_techo) == TRUE
#
#     ) {
#
#       message('
# Every specified column, except for ndorms, should be of class character. Consider running ismtchile::literalize() on your data.
#             ')
#
#       stop('Invalid field class', call. = F)
#
#     } else {
#
#       pass()
#
#     }

    if (level == 'zc') {

      clone$geocode = clone$id_zona

    } else if (level == 'mzn' & year != 2017) {

      clone$geocode = clone$id_manzan

    } else if (level == 'mzn' & year == 2017) {

      message('
mzn level not supported for 2017
            ')

      stop()

    } else if (level == 'com') {

      clone$geocode = clone$id_comuna

    } else if (level == 'reg') {

      clone$geocode = clone$id_region

    }

    muro_aceptable <- c('HORMIGON', 'ALBANILERIA', 'TABIQUE_FORRADO')
    muro_recuperable <- c('TABIQUE', 'ARTESANAL')
    muro_irrecuperable <- c('PRECARIOS', 'OTROS')

    techo_aceptable <- c('TEJAS', 'LOSA_HORMIGON', 'PLANCHAS')
    techo_recuperable <- c('FONOLOLITA', 'PAJA')
    techo_irrecuperable <- c('PRECARIOS', 'SIN_TECHO', 'OTROS')

    piso_aceptable <- c('PARQUET', 'RADIER')
    piso_recuperable <- c('BALDOSA_CEMENTO', 'CEMENTO_TIERRA')
    piso_irrecuperable <- c('TIERRA', 'OTROS')

    invalid <- c('COLECTIVA', 'TRANSITO', 'CALLE')

    cleanclone <- clone |>
      dplyr::filter(

        parentesco == 'JEFE_HOGAR',
        tipo_viv %notin% invalid

      ) |>
      dplyr::mutate(

        cond_muro = dplyr::case_when(

          mat_muro %in% muro_aceptable ~ as.integer(3),
          mat_muro %in% muro_recuperable ~ as.integer(2),
          mat_muro %in% muro_irrecuperable ~ as.integer(1),
          TRUE ~ NA_integer_

        ),
        cond_techo = dplyr::case_when(

          mat_techo %in% techo_aceptable ~ as.integer(3),
          mat_techo %in% techo_recuperable ~ as.integer(2),
          mat_techo %in% techo_irrecuperable ~ as.integer(1),
          TRUE ~ NA_integer_

        ),
        cond_piso = dplyr::case_when(

          mat_piso %in% piso_aceptable ~ as.integer(3),
          mat_piso %in% piso_recuperable ~ as.integer(2),
          mat_piso %in% piso_irrecuperable ~ as.integer(1),
          TRUE ~ NA_integer_

        ),
        mat_aceptable = dplyr::if_else(

          cond_muro == 3 & cond_techo == 3 & cond_piso == 3,
          1,
          0

        ),
        mat_irrecup = dplyr::if_else(

          cond_muro == 1 | cond_techo == 1 | cond_piso == 1,
          1,
          0

        ),
        mat_recuperable = dplyr::if_else(

          mat_aceptable == 0 & mat_irrecup == 0,
          1,
          0

        ),
        ind_mater = cond_muro + cond_techo + cond_piso,
        ind_hacinam = dplyr::case_when(

          ndorms >= 1 ~ cant_per / ndorms,
          ndorms == 0 ~ cant_per * 2,
          TRUE ~ NA_real_

        ),
        sin_hacin = dplyr::if_else(

          ind_hacinam <= 2.4,
          1,
          0

        ),
        hacin_medio = dplyr::if_else(

          ind_hacinam > 2.4 & ind_hacinam <= 4.9,
          1,
          0

        ),
        hacin_critico = dplyr::if_else(

          ind_hacinam > 4.9,
          1,
          0

        ),
        a_esc_cont = dplyr::case_when(

          escolaridad == NA ~ NA_integer_,
          escolaridad == 99 ~ NA_integer_,
          escolaridad == 27 ~ NA_integer_,
          TRUE ~ escolaridad

        )

      ) |>
      dplyr::filter(

        !is.na(hacin_critico)

      ) |>
      dplyr::mutate(

        n_hog_alleg = cant_hog - 1

      ) |>
      dplyr::select(

        year, geocode, cond_muro, cond_techo, cond_piso, mat_aceptable, mat_irrecup, mat_recuperable, sin_hacin, hacin_medio, hacin_critico, a_esc_cont, ind_mater, ind_hacinam, n_hog_alleg, escolaridad

      )

    return(cleanclone)

  } else if (vars.as.factors == TRUE) {

    message('
vars.as.factors parameter is not yet available.
            ')

    stop('Feature is still under development')

  }

}
