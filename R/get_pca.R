#' Get Principal Compnents Analysis values
#'
#' @param df data.frame object. Assumes 'precalc()' function has already been run for the database, as it requires the scaled score values.
#' @param esc string. Escolaridad score field as obtained from precalc(). Default is 'ptje_esc'
#' @param hacin string. Hacinamiento score field as obtained from precalc(). Default is 'ptje_hacin'
#' @param mat string. Materialidad score field as obtained from precalc(). Default is 'ptje_mater'
#' @param alleg string. Allegamiento score field as obtained from precalc(). Default is 'ptje_alleg'
#'
#' @import tidyverse
#' @import glue
#'
#' @return data.frame object
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
