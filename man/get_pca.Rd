% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_pca.R
\name{get_pca}
\alias{get_pca}
\title{Calcular análisis de componentes principales -- Calculate Principal Components Analysis}
\usage{
get_pca(
  df,
  esc = "ptje_esc",
  hacin = "ptje_hacin",
  mat = "ptje_mater",
  alleg = "ptje_alleg"
)
}
\arguments{
\item{df}{objeto \code{data.frame} con la informaión de puntajes normalizados. \cr \cr \code{data.frame} object with the normalized scores.}

\item{esc}{string. Nombre de la variable con el puntaje de escolaridad del jefe de hogar. Default is \code{ptje_esc} \cr \cr string. Name of the field with the scholarship score for the home head. Default is \code{ptje_esc}.}

\item{hacin}{string. Nombre del campo con el puntaje de hacinamiento. Default es \code{ptje_hacin}. \cr \cr string. Name of the field with the overcrowding score. Default is \code{ptje_hacin}.}

\item{mat}{string. Nombre del campo con el puntaje de materialidad de la vivienda. Default es \code{ptje_mater}. \cr \cr string. Name of the field with the dwelling material score. Default is \code{ptje_mater.}}

\item{alleg}{string. Nombre del campo con el puntaje de allegamiento. Default is \code{ptje_alleg}. \cr \cr string. Name of the field with the relative crowding score. Default is \code{ptje_alleg}.}
}
\value{
objeto \code{data.frame} con el cálculo de componentes principales. \cr \cr \code{data.frame} object with the principal components analysis calculation.
}
\description{
Cálculo de análisis de componentes principales en base a las 4 vatriables principales del ISMT. La función asume que la base de datos ha pasado por \code{precalc()}, ya que requiere los puntajes normalizados por variable. \cr \cr Calculation of principal components analysis based on the 4 main variables of ISMT. Assumes the database has been through \code{precalc()}, as it rqeuires the normalized scores by variable.
}
\examples{
c17 <- load_data(13, path = loc_dir) \%>\% region_filter(13, 1) \%>\% cleanup() \%>\% precalc() \%>\% get_pca()
}
