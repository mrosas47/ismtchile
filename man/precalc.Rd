% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/precalc.R
\name{precalc}
\alias{precalc}
\title{Precálculos ISMT -- ISMT Precalculations}
\usage{
precalc(
  df,
  hacin = "ind_hacinam",
  alleg = "n_hog_alleg",
  esc = "a_esc_cont",
  mat = "ind_mater"
)
}
\arguments{
\item{df}{objecto \code{data.frame}. Asume que la base de datos ha pasado por \code{cleanup()}. || || \code{data.frame} object. Assumes the database has been through \code{cleanup()}.}

\item{hacin}{string. Nombre del campo del indicador de hacinamiento. Default es \code{ind_hacinam}. || || string. Name of the field with the overcrowding score. Default is \code{ind_hacinam}.}

\item{alleg}{string. Nombre del campo del indicador de allegamiento. Default es \code{n_hog_alleg}. || || string. Name of the field with the relative crowding score. Default is \code{n_hog_alleg}.}

\item{esc}{string. Nombre del campo del indicador de escolaridad del jefe de hogar. Default es \code{a_esc_cont}. || || string. Name of the field with the scholarship of the home head score. Default is \code{a_esc_cont}.}

\item{mat}{string. Nombre del campo del indicador de materialidad de la vivienda. Default es \code{ind_mater}. || || string. Name of the field with the dwelling material score. Default is \code{ind_mater}.}
}
\value{
objeto \code{data.frame} con los precálculos necesarios para calcular el ISMT. || || \code{data.frame} object with the necessary precalculations to calculate ISMT.
}
\description{
Ejecuta precálculos necesarios para el resto del proceso del ISMT. || || Executes precalculations necessary for the rest of the ISMT process.
}
\examples{
 data(c17_example)
 clean <- c17_example |> literalize(2017) |> cleanup() |> precalc()
}
