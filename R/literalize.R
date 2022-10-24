#' @title Literalizar bases censales -- iteralize census databases
#'
#' @param df objeto \code{data.frame} correspondiente a la base de datos original de los censos 20177, 2012, 2002, 1992 o 1982. -- \code{data.frame} objectcorresponding to the original database for the 2017, 2012, 2002, 1992 or 1982 census.
#' @param year
#'
#' @return \code{data.frame}
#' @export literalize
#'
#' @examples 'no example for now'
literalize <- function (df, year) {

  if (year == 2017) {

    df0 <- df %>%
      mutate(

        geocode = str_pad(

          as.character(geocode),
          width = 11,
          side = 'left',
          pad = '0'

        ),
        nviv = as.integer(nviv),
        nhogar = as.integer(nhogar),
        npers = as.integer(personan),
        cant_hog = case_when(

          cant_hog %in% c(0 : 35) ~ as.integer(cant_hog),
          T ~ NA_integer_

        ),
        tipoviv = case_when(

          p01 == 1 ~ 'CASA',
          p01 == 2 ~ 'DPTO',
          p01 == 3 ~ 'INDIGENA',
          p01 == 4 ~ 'PIEZA',
          p01 == 5 ~ 'MEDIAGUA',
          p01 == 6 ~ 'MOVIL',
          p01 == 7 ~ 'OTRO',
          p01 == 8 ~ 'COLECTIVA',
          p01 == 9 ~ 'TRANSITO',
          p01 == 10 ~ 'CALLE',
          T ~ NA_character_

        ),
        ocup_viv = case_when(

          p02 == 1 ~ 'PRESENTES',
          p02 == 2 ~ 'AUSENTES',
          p02 == 3 ~ 'VENTA',
          p02 == 4 ~ 'TEMPORADA',
          T ~ NA_character_

        ),
        mat_muro = case_when(

          p03a == 1 ~ 'HORMIGON',
          p03a == 2 ~ 'ALBANILERIA',
          p03a == 3 ~ 'TABIQUE_FORRADO',
          p03a == 4 ~ 'TABIQUE',
          p03a == 5 ~ 'ARTESANAL',
          p03a == 6 ~ 'PRECARIOS',
          T ~ NA_character_

        ),
        mat_techo = case_when(

          p03b == 1 ~ 'TEJAS',
          p03b == 2 ~ 'LOSA_HORMIGON',
          p03b == 3 ~ 'PLANCHAS',
          p03b == 4 ~ 'FONOLITA',
          p03b == 5 ~ 'PAJA',
          p03b == 6 ~ 'PRECARIOS',
          p03b == 7 ~ 'SIN_TECHO',
          T ~ NA_character_

        ),
        mat_piso = case_when(

          p03c == 1 ~ 'PARQUET',
          p03c == 2 ~ 'RADIER',
          p03c == 3 ~ 'BALDOSA_CEMENTO',
          p03c == 4 ~ 'CEMENTO_TIERRA',
          p03c == 5 ~ 'TIERRA',
          T ~ NA_character_

        ),
        ndorms = case_when(

          p04 %in% c(0 : 6) ~ as.integer(p04),
          T ~ NA_integer_

        ),
        agua_orig = case_when(

          p05 == 1 ~ 'RED_PUBLICA',
          p05 == 2 ~ 'POZO',
          p05 == 3 ~ 'CAMION',
          p05 == 4 ~ 'RIO',
          T ~ NA_character_

        ),
        tipo_hog = case_when(

          tipo_hogar == 1 ~ 'UNIPERSONAL',
          tipo_hogar == 2 ~ 'MONOPARENTAL',
          tipo_hogar == 3 ~ 'BIPARENTAL_NH',
          tipo_hogar == 4 ~ 'BIPARENTAL_CH',
          tipo_hogar == 5 ~ 'COMPUESTO',
          tipo_hogar == 6 ~ 'EXTENSO',
          tipo_hogar == 7 ~ 'SIN_NUCLEO',
          T ~ NA_character_

        ),
        operativo = case_when(

          tipo_operativo == 1 ~ 'VIV_PARTICULAR',
          tipo_operativo == 8 ~ 'VIV_COLECTIVA',
          tipo_operativo == 9 ~ 'TRANSITO',
          tipo_operativo == 10 ~ 'CALLE',
          T ~ NA_character_

        ),
        parentesco = case_when(

          p07 == 1 ~ 'JEFE_HOGAR',
          p07 == 2 ~ 'CONYUGUE',
          p07 == 3 ~ 'UNION_CIVIL',
          p07 == 4 ~ 'PAREJA',
          p07 == 5 ~ 'HIJO_A',
          p07 == 6 ~ 'HIJO_A_CONYUGUE',
          p07 == 7 ~ 'HERMANO_A',
          p07 == 8 ~ 'PADRE_MADRE',
          p07 == 9 ~ 'CUÑADO_A',
          p07 == 10 ~ 'SUEGRO_A',
          p07 == 11 ~ 'YERNO_NUERA',
          p07 == 12 ~ 'NIETO_A',
          p07 == 13 ~ 'ABUELO_A',
          p07 == 14 ~ 'OTRO_PARIENTE',
          p07 == 15 ~ 'NO_PARIENTE',
          p07 == 16 ~ 'SERVICIO',
          p07 == 17 ~ 'VIV_COLECTIVA',
          p07 == 18 ~ 'OP_TRANSITO',
          p07 == 19 ~ 'OP_CALLE',
          T ~ NA_character_

        ),
        sexo = case_when(

          p08 == 1 ~ 'HOMBRE',
          p08 == 2 ~ 'MUJER',
          T ~ NA_character_

        ),
        edad = as.integer(p09),
        resid_5a = case_when(

          p11 == 1 ~ 'NO_NACIDO',
          p11 == 2 ~ 'ESTA_COM',
          p11 == 3 ~ 'OTRA_COM',
          p11 == 4 ~ 'PERU',
          p11 == 5 ~ 'ARGENTINA',
          p11 == 6 ~ 'BOLIVIA',
          p11 == 7 ~ 'ECUADOR',
          p11 == 8 ~ 'COLOMBIA',
          p11 == 9 ~ 'OTRO',
          p11 %in% c(98, 99) ~ 'NO_APLICA',
          T ~ NA_character_

        ),
        nacimiento = case_when(

          p12 == 1 ~ 'NO_NACIDO',
          p12 == 2 ~ 'ESTA_COM',
          p12 == 3 ~ 'OTRA_COM',
          p12 == 4 ~ 'PERU',
          p12 == 5 ~ 'ARGENTINA',
          p12 == 6 ~ 'BOLIVIA',
          p12 == 7 ~ 'ECUADOR',
          p12 == 8 ~ 'COLOMBIA',
          p12 == 9 ~ 'OTRO',
          p12 %in% c(98, 99) ~ 'NO_APLICA',
          T ~ NA_character_

        ),
        asiste_educ = case_when(

          p13 == 1 ~ 'SI',
          p13 == 2 ~ 'NO_ACTUAL',
          p13 == 3 ~ 'NUNCA',
          T ~ NA_character_

        ),
        curso_alto = case_when(

          p14 %in% c(0 : 8) ~ as.integer(p14),
          T ~ NA_integer_

        ),
        nivel_educ = case_when(

          p15 == 1 ~ 'JARDIN',
          p15 == 2 ~ 'PREKINDER',
          p15 == 3 ~ 'KINDER',
          p15 == 4 ~ 'DIFERENCIAL',
          p15 == 5 ~ 'BASICA',
          p15 == 6 ~ 'PRIMARIA',
          p15 == 7 ~ 'CIENTIFICO_HUMANISTA',
          p15 == 8 ~ 'TECNICA_PROF',
          p15 == 9 ~ 'HUMANIDADES',
          p15 == 10 ~ 'TEC_COMERCIAL',
          p15 == 11 ~ 'TEC_SUPERIOR',
          p15 == 12 ~ 'PROFESIONAL',
          p15 == 13 ~ 'MAGISTER',
          p15 == 14 ~ 'DOCTORADO',
          T ~ NA_character_

        ),
        pueblo_pert = case_when(

          p16 == 1 ~ 'SI',
          p16 == 2 ~ 'NO',
          T ~ NA_character_

        ),
        pueblo_orig = case_when(

          p16a == 1 ~ 'MAPUCHE',
          p16a == 2 ~ 'AYMARA',
          p16a == 3 ~ 'RAPA_NUI',
          p16a == 4 ~ 'LICAN_ANTAI',
          p16a == 5 ~ 'QUECHUA',
          p16a == 6 ~ 'COLLA',
          p16a == 7 ~ 'DIAGUITA',
          p16a == 8 ~ 'KAWESQAR',
          p16a == 9 ~ 'YAGAN',
          p16a == 10 & p16a_otro == 3 ~ 'LAFKENCHE',
          p16a == 10 & p16a_otro == 4 ~ 'PEHUENCHE',
          p16a == 10 & p16a_otro == 5 ~ 'HUILLICHE',
          p16a == 10 & p16a_otro == 6 ~ 'PICUNCHE',
          p16a == 10 & p16a_otro == 21 ~ 'CHANGO',
          p16a == 10 & p16a_otro == 22 ~ 'CHONO',
          p16a == 10 & p16a_otro == 23 ~ 'ONA',
          p16a == 10 & p16a_otro == 28 ~ 'TEHUELCHE',
          p16a == 10 & p16a_otro == 33 ~ 'LATAM',
          p16a == 10 & p16a_otro == 34 ~ 'MUNDO',
          p16a == 10 & p16a_otro == 35 ~ 'AFRO',
          p16a == 10 & p16a_otro == 37 ~ 'OTROS',
          p16a == 10 & p16a_otro == 97 ~ 'NO_DECLARA',
          T ~ NA_character_

        ),
        trabajo = case_when(

          p17 == 1 ~ 'PAGADO',
          p17 == 2 ~ 'SIN_PAGO_FAM',
          p17 == 3 ~ 'VACACIONES',
          p17 == 4 ~ 'BUSCANDO',
          p17 == 5 ~ 'ESTUDIANDO',
          p17 == 6 ~ 'QUEHACERES',
          p17 == 7 ~ 'JUBILADO',
          p17 == 5 ~ 'OTRO',
          T ~ NA_character_

        ),
        rama = case_when(

          p18 == 'A' ~ 'AGRO',
          p18 == 'B' ~ 'MINERIA',
          p18 == 'C' ~ 'MANUFACTURA',
          p18 == 'D' ~ 'SUMINISTRO',
          p18 == 'E' ~ 'AGUAS',
          p18 == 'F' ~ 'CONSTRUCCION',
          p18 == 'G' ~ 'COMERCIO',
          p18 == 'H' ~ 'TRANSPORTE',
          p18 == 'I' ~ 'ALOJAMIENTO',
          p18 == 'J' ~ 'INFORMACION',
          p18 == 'K' ~ 'FINANZA',
          p18 == 'L' ~ 'INMOBILIARIA',
          p18 == 'M' ~ 'PROFESIONAL',
          p18 == 'N' ~ 'ADMINISTRACION',
          p18 == 'O' ~ 'ADMIN_PUBLICA',
          p18 == 'P' ~ 'EDUCACION',
          p18 == 'Q' ~ 'SALUD',
          p18 == 'R' ~ 'ENTRETENIMIENTO',
          p18 == 'S' ~ 'OTROS_SERVICIOS',
          p18 == 'T' ~ 'HOGAR',
          p18 == 'U' ~ 'EXTRATERRITORIO',
          p18 == 'Z' ~ 'NO_DECLARA',
          T ~ NA_character_

        ),
        hijos_nacido = case_when(

          p19 %in% c(0 : 23) ~ as.integer(p19),
          T ~ NA_integer_

        ),
        hijos_vivos = case_when(

          p20 %in% c(0 : 23) ~ as.integer(p20)

        ),
        escolaridad = case_when(

          escolaridad %in% c(0 : 21) ~ as.integer(escolaridad),
          T ~ NA_integer_

        )

      ) %>%
      select(

        geocode, nviv, nhogar, npers, cant_hog, tipoviv, ocup_viv, mat_muro, mat_techo, mat_piso, ndorms, agua_orig, tipo_hog, operativo, parentesco, sexo, edad, resid_5a, nacimiento, asiste_educ, curso_alto, nivel_educ, pueblo_pert, pueblo_orig, trabajo, rama, hijos_nacido, hijos_vivos, escolaridad

      )

    return(df0)

  } else {

    message('Invalid parameter')

  }

}

