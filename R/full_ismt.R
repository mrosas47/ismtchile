full_ismt <- function (df, r, ur, rfield = 'region', urfield = 'area', year = 2017, tiphog = 'p01', ocupac = 'p02', ndorms = 'p04', parent = 'p07', muro = 'p03a', techo = p03b, suelo = 'p03c', criteria, grouping = 'geocode') {

  df0 <- df %>%
    ismtchile::region_filter(r = r, ur = ur) %>%
    ismtchile::cleanup() %>%
    ismtchile::precalc() %>%
    ismtchile::get_pca() %>%
    ismtchile::ismt_scores(criteria = criteria, r = r)

  return(df0)

}
