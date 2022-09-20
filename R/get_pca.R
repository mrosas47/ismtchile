#' Calcular análisis de componentes principales -- Calculate Principal Components Analysis
#'
#' @description Cálculo de análisis de componentes principales en base a las 4 vatriables principales del ISMT. La función asume que la base de datos ha pasado por \code{precalc()}, ya que requiere los puntajes normalizados por variable. \cr \cr Calculation of principal components analysis based on the 4 main variables of ISMT. Assumes the database has been through \code{precalc()}, as it rqeuires the normalized scores by variable.
#'
#' @param df objeto \code{data.frame} con la informaión de puntajes normalizados. \cr \cr \code{data.frame} object with the normalized scores.
#' @param esc string. Nombre de la variable con el puntaje de escolaridad del jefe de hogar. Default is \code{ptje_esc} \cr \cr string. Name of the field with the scholarship score for the home head. Default is \code{ptje_esc}.
#' @param hacin string. Nombre del campo con el puntaje de hacinamiento. Default es \code{ptje_hacin}. \cr \cr string. Name of the field with the overcrowding score. Default is \code{ptje_hacin}.
#' @param mat string. Nombre del campo con el puntaje de materialidad de la vivienda. Default es \code{ptje_mater}. \cr \cr string. Name of the field with the dwelling material score. Default is \code{ptje_mater.}
#' @param alleg string. Nombre del campo con el puntaje de allegamiento. Default is \code{ptje_alleg}. \cr \cr string. Name of the field with the relative crowding score. Default is \code{ptje_alleg}.
#'
#' @import tidyverse
#' @import glue
#'
#' @return objeto \code{data.frame} con el cálculo de componentes principales. \cr \cr \code{data.frame} object with the principal components analysis calculation.
#' @export get_pca
#'
#' @examples 'void for now'

get_pca <- function(df, esc = 'ptje_esc', hacin = 'ptje_hacin', mat = 'ptje_mater', alleg = 'ptje_alleg') {

  names(df)[names(df) == glue('{hacin}')] <- 'ptje_hacin'
  names(df)[names(df) == glue('{esc}')] <- 'ptje_esc'
  names(df)[names(df) == glue('{mat}')] <- 'ptje_mater'
  names(df)[names(df) == glue('{alleg}')] <- 'ptje_alleg'

  tempdf <- na.omit(df) %>%
    select(

      ptje_hacin, ptje_esc, ptje_mater, ptje_alleg

    )

  pca <- prcomp(tempdf)

  loadings <- as.data.frame(pca$rotation) %>%
    select(

      PC1

    )

  pc1score <- as.data.frame(t(loadings))

  pc1score <- pc1score %>%
    mutate(

      ptje_esc = abs(ptje_esc),
      ptje_hacin = abs(ptje_hacin),
      ptje_alleg = abs(ptje_alleg),
      ptje_mater = abs(ptje_mater)

    )

  victor <- pca$sdev ^ 2 / sum(pca$sdev ^ 2)

  propvar <- victor[1]

  pesc <- pc1score$ptje_esc * propvar
  phac <- pc1score$ptje_hacin * propvar
  pviv <- pc1score$ptje_mater * propvar
  pall <- pc1score$ptje_alleg * propvar

  calculations <- df %>%
    mutate(

      ismt_p = (ptje_esc * pesc) + (ptje_hacin * phac) + (ptje_mater * pviv) + (ptje_alleg * pall)

    ) %>%
    filter(

      !is.na(ismt_p)

    ) %>%
    mutate(

      ismt_pn = ismtchile::normvar(ismt_p)

    )

  return(calculations)

}
