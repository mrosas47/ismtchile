#' @title Cálculo de ISMT completo a partir del Censo 2017 -- Full ISMT calculation from 2017 Census.
#'
#' @description Ejecuta el cálculo completo del ISMT. Agrupa las funciones `literalize()`, `cleanup()`, `precalc()`, `get_pca()`, `ismt_scores()`, `namify()`. La tabla obtenida debería ser idéntica al resultado de concatenar estas funciones una a una.
#'
#' @param df objeto \code{data.frame}. Default es \code{2017}. || || \code{data.frame} object. Default is \code{2017}.
#' @param r integer. Se aceptan valores entre 1 y 16 para Chile 2017. Si \code{r == 99}, no se define una región en particular y se trabaja con valores a nivel nacional. || || integer. Values between 1 and 16 are acceptable for Chile 2017. If \code{r == 99}, no region will be defined and work will continue with national level values.
#' @param ur integer. Valores aceptables son \code{1} y \code{2}. Define si se requiere zona urbana \code{ur = 1} o rural \code{ur = 2}. || || integer. Accepted values are \code{1} and \code{2}. Defines whether urban \code{ur = 1} or rural \code{ur = 2} data is requested.
#' @param rfield string. Nombre del campo que corresponde al número de la región. Default es \code{region}. || || string. Name of the field corresponding to the region number. Default is \code{region}.
#' @param urfield string. Nombre del campo que define el tipo de área (urbana o rural). Default es \code{tipo_area}. || || string Name of the field corresponding to the desired area (urban or rural). Default is \code{tipo_area}.
#' @param year integer. Default es \code{2017}. || || integer. Default is \code{2017}.
#' @param tipo_vivienda string. Nombre del campo de tipo de vivienda. Default es \code{tipoviv}. || || string. Name of the dwelling type field. Default is \code{tipoviv}.
#' @param ocupacion string. Nombre del campo de ocupación de la vivienda. Default es \code{ocup_viv}. || || string. Name of the home occupation field. Default is \code{ocup_viv}.
#' @param ndorms string. Nombre del campo con el número de dormitorios del hogar. Default es \code{ndorms}. || || string. Name of the number of bedrooms field. Default is \code{ndorms}.
#' @param parentesco string. Nombre del campo de parentesco. Default es \code{parentesco}. || || string. Name of the familial relationship field. Default is \code{parentesco}.
#' @param muro string. Nombre del campo de condición del muro. Default es \code{mat_muro}. || || string. Name of the wall condition field. Default is \code{mat_muro}.
#' @param techo string. Nombre del campo de condición del techo. Default es \code{mat_techo}. || || string. Name of the ceiling condition field. Default is \code{mat_techo}.
#' @param piso string. Nombre del campo de condición del suelo. Default es \code{mat_piso}. || || string. Name of the floor condition field. Default is \code{mat_piso}.
#' @param grouping string. Nombre del campo con la variable de la unidad espacial agrupadora. Default es \code{id_zona}. || || string. Name of the field with the spacial grouping unit variable. Default is \code{id_zona}.
#' @param level \code{string}. Nivel de agrupación de los datos finales. Acepta valores \code{zc} (zona censal) y \code{mzn} (manzana). El nivel de manzana no está disponible para el 2017 debido al secreto estadístico de la base de datos de origen. Default es \code{zc}. || || \code{string}. Grouping level for the final data. Values \code{zc} (census zone) and \code{mzn} (block). Block level is not available for 2017 due to statistical secret of original database. Default is \code{zc}.
#' @param names \code{boolean}. Si incluir la ejecución de \code{namify()} en el proceso. Para censos anteriores se recomienda cambiar a FALSE. Default es TRUE. || || \code{boolean}. Whether to include execution of \code{namify()} in the process. For older census it is recommended to set to FALSE. Default is TRUE.
#'
#' @import dplyr
#' @import stringr
#'
#' @return objeto data.frame conteniendo el cálculo completo del ISMT.
#' @export full_ismt
#'
#' @examples
#'  \donttest{
#'    data(c17_example)
#'    ismt <- full_ismt(c17_example, 10, 1)
#'  }

full_ismt <- function (df, r, ur, rfield = 'id_region', urfield = 'tipo_area', year = 2017, tipo_vivienda = 'tipoviv', ocupacion = 'ocup_viv', ndorms = 'ndorms', parentesco = 'parentesco', muro = 'mat_muro', techo = 'mat_techo', piso = 'mat_piso', grouping = 'id_zona', level = 'zc', names = T) {

  id_region <- NULL
  tipo_area <- NULL

  key <- dplyr::if_else(ur == 1, 'URBANO', 'RURAL')
  stringy <- stringr::str_pad(r, width = 2, side = 'left', pad = '0')

  if (r %in% c(1:16)) {

    if (names) {

      df0 <- df |>
        ismtchile::literalize(year = year) |>
        dplyr::filter(id_region == stringy, tipo_area == key) |>
        ismtchile::cleanup(year = year, tipo_viv = tipo_vivienda, ocupacion = ocupacion, dormitorios = ndorms, parentesco = parentesco, muro = muro, techo = techo, piso = piso, level = level) |>
        ismtchile::precalc() |>
        ismtchile::get_pca() |>
        ismtchile::ismt_scores(r = r, grouping = grouping) |>
        ismtchile::namify(common_var = 'zona', level = level)

    } else {

      df0 <- df |>
        ismtchile::literalize(year = year) |>
        dplyr::filter(id_region == stringy, tipo_area == key) |>
        ismtchile::cleanup(year = year, tipo_viv = tipo_vivienda, ocupacion = ocupacion, dormitorios = ndorms, parentesco = parentesco, muro = muro, techo = techo, piso = piso, level = level) |>
        ismtchile::precalc() |>
        ismtchile::get_pca() |>
        ismtchile::ismt_scores(r = r, grouping = grouping)

    }

  } else if (r == 99) {

    if (names) {

      df0 <- df |>
        ismtchile::literalize(year = year) |>
        dplyr::filter(tipo_area == key) |>
        ismtchile::cleanup(year = year, tipo_viv = tipo_vivienda, ocupacion = ocupacion, dormitorios = ndorms, parentesco = parentesco, muro = muro, techo = techo, piso = piso, level = level) |>
        ismtchile::precalc() |>
        ismtchile::get_pca() |>
        ismtchile::ismt_scores(r = r, grouping = grouping) |>
        ismtchile::namify(common_var = 'zona', level = level)

    } else {

      df0 <- df |>
        ismtchile::literalize(year = year) |>
        dplyr::filter(tipo_area == key) |>
        ismtchile::cleanup(year = year, tipo_viv = tipo_vivienda, ocupacion = ocupacion, dormitorios = ndorms, parentesco = parentesco, muro = muro, techo = techo, piso = piso, level = level) |>
        ismtchile::precalc() |>
        ismtchile::get_pca() |>
        ismtchile::ismt_scores(r = r, grouping = grouping)

    }

  }

  return(df0)

}
