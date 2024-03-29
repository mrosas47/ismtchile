% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/literalize.R
\name{literalize}
\alias{literalize}
\title{Literalizar bases censales -- Literalize census databases}
\usage{
literalize(df, year)
}
\arguments{
\item{df}{objeto \code{data.frame} correspondiente a la base de datos original de los censos 2017, 2012, 2002, 1992 o 1982. -- \code{data.frame} object corresponding to the original database for the 2017, 2012, 2002, 1992 or 1982 census.}

\item{year}{integer. No provee Default para forzar la explicitación del año de la base. || || integer. Default is not provided, so as to force explicitation of the database's year.}
}
\value{
objeto \code{data.frame} con las variables como texto en lugar de factores (nombres y categorías homologados para todos los censos)
}
\description{
Literalizar bases censales -- Literalize census databases
}
\examples{
 data(c17_example)
 clean <- c17_example |> literalize(2017)
}
