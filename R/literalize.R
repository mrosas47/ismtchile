#' @title Literalizar bases censales -- Literalize census databases
#'
#' @param df objeto \code{data.frame} correspondiente a la base de datos original de los censos 2017, 2012, 2002, 1992 o 1982. -- \code{data.frame} object corresponding to the original database for the 2017, 2012, 2002, 1992 or 1982 census.
#' @param year integer. Default es \code{2017}, que es la única disponible para la versión \code{1.x.x}. \cr \cr integer. Default is \code{2017}, which is the only supported for version \code{1.x.x}.
#'
#' @import magrittr
#' @import dplyr
#' @import stringr
#'
#' @return objeto \code{data.frame}
#' @export literalize
#'
#' @examples 'no example for now'

literalize <- function (df, year) {

  if (year == 2017) {

    df0 <- df %>%
      mutate(

        id_region = str_pad(

          region,
          width = 2,
          side = 'left',
          pad = '0'

        ),
        id_provin = str_pad(

          provincia,
          width = 3,
          side = 'left',
          pad = '0'

        ),
        id_comuna = str_pad(

          comuna,
          width = 5,
          side = 'left',
          pad = '0'

        ),
        id_distri = paste(

          id_comuna,
          str_pad(

            dc,
            width = 2,
            side = 'left',
            pad = '0'

          ),
          sep = ''

        ),
        id_area = paste(

          id_distri,
          as.character(area),
          sep = ''

        ),
        id_zona = paste(

          id_area,
          str_pad(

            zc_loc,
            width = 3,
            side = 'left',
            pad = '0'

          ),
          sep = ''

        ),
        id_manzan = NA_character_,
        nviv = as.integer(nviv),
        nhogar = as.integer(nhogar),
        npers = as.integer(personan),
        cant_hog = case_when(

          cant_hog %in% c(0 : 35) ~ as.integer(cant_hog),
          T ~ NA_integer_

        ),
        cant_per = as.integer(cant_per),
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
          p02 == 3 ~ 'DESOCUPADA',
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
          p07 == 9 ~ 'CUNADO_A',
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
        res_5a = case_when(

          p11 == 1 ~ 'NO_NACIDO',
          p11 == 2 ~ 'ESTA_COMUNA',
          p11 == 3 ~ 'OTRA_COMUNA',
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

          p12 == 1 ~ 'ESTA_COMUNA',
          p12 == 2 ~ 'OTRA_COMUNA',
          p12 == 3 ~ 'PERU',
          p12 == 4 ~ 'ARGENTINA',
          p12 == 5 ~ 'BOLIVIA',
          p12 == 6 ~ 'ECUADOR',
          p12 == 7 ~ 'COLOMBIA',
          p12 == 8 ~ 'OTRO',
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
          p17 == 8 ~ 'OTRO',
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

        ),
        year = '2017',
        tipo_area = case_when(

          area == 1 ~ 'URBANO',
          area == 2 ~ 'RURAL',
          T ~ NA_character_

        )

      ) %>%
      select(

        year, id_region, id_provin, id_comuna, id_distri, id_area, id_zona, id_manzan, tipo_area, nviv, nhogar, npers, cant_hog, cant_per, tipoviv, ocup_viv, mat_muro, mat_techo, mat_piso, ndorms, agua_orig, tipo_hog, operativo, parentesco, sexo, edad, res_5a, nacimiento, asiste_educ, curso_alto, nivel_educ, pueblo_pert, pueblo_orig, trabajo, rama, hijos_nacido, hijos_vivos, escolaridad

      )

    return(df0)

  } else if (year == 2012) {

    nhogares2012 <- df %>%
      filter(dpar == 1) %>%
      group_by(folio, nviv) %>%
      summarise(
        cant_hog = as.integer(n())
      ) %>%
      ungroup()

    df0 <- df %>%
      left_join(

        nhogares2012,
        by = c('folio', 'nviv')

      ) %>%
      mutate(

        year = '2012',
        id_region = str_pad(

          region,
          width = 2,
          side = 'left',
          pad = '0'

        ),
        id_provin = str_pad(

          prov,
          width = 3,
          side = 'left',
          pad = '0'

        ),
        id_comuna = str_pad(

          comuna,
          width = 5,
          side = 'left',
          pad = '0'

        ),
        id_distri = paste(

          id_comuna,
          str_pad(

            dc,
            width = 2,
            side = 'left',
            pad = '0'

          ),
          sep = ''

        ),
        id_area = paste(

          id_distri,
          area,
          sep = ''

        ),
        id_zona = paste(

          id_area,
          str_pad(

            zona,
            width = 3,
            side = 'left',
            pad = '0'

          ),
          sep = ''

        ),
        id_manzan = paste(

          id_zona,
          str_pad(

            manzana,
            width = 3,
            side = 'left',
            pad = '0'

          ),
          sep = ''

        ),
        nviv = as.integer(nviv),
        nhogar = as.integer(nhog),
        npers = as.integer(nper),
        cant_hog = as.integer(cant_hog),
        cant_per = case_when(

          v09m < 98 ~ as.integer(v09m),
          T ~ NA_integer_

        ),
        tipoviv = case_when(

          v02 %in% c(1, 2) ~ 'CASA',
          v02 %in% c(3, 4) ~ 'DPTO',
          v02 == 5 ~ 'INDIGENA',
          v02 == 6 ~ 'PIEZA',
          v02 %in% c(7, 8, 9) ~ 'MEDIAGUA',
          v02 == 10 ~ 'MOVIL',
          v02 == 11 ~ 'OTRO',
          v02 == 12 ~ 'COLECTIVA',
          T ~ NA_character_

        ),
        ocup_viv = case_when(

          v01 %in% c(1, 2) ~ 'PRESENTES',
          v01 == 3 ~ 'AUSENTES',
          v01 == 4 ~ 'TEMPORADA',
          v01 %in% c(5 : 7) ~ 'DESOCUPADA',
          T ~ NA_character_

        ),
        mat_muro = case_when(

          v03a == 1 ~ 'HORMIGON',
          v03a == 2 ~ 'ALBANILERIA',
          v03a == 3 ~ 'TABIQUE_FORRADO',
          v03a == 4 ~ 'TABIQUE',
          v03a == 5 ~ 'ARTESANAL',
          v03a == 6 ~ 'PRECARIOS',
          T ~ NA_character_

        ),
        mat_techo = case_when(

          v03b == 1 ~ 'TEJAS',
          v03b == 2 ~ 'LOSA_HORMIGON',
          v03b == 3 ~ 'PLANCHAS',
          v03b == 4 ~ 'FONOLITA',
          v03b == 5 ~ 'PAJA',
          v03b == 6 ~ 'PRECARIOS',
          v03b == 7 ~ 'SIN_TECHO',
          T ~  NA_character_

        ),
        mat_piso = case_when(

          v03c %in% c(1 : 3) ~ 'PARQUET',
          v03c == 4 ~ 'BALDOSA_CEMENTO',
          v03c == 5 ~ 'RADIER',
          v03c == 6 ~ 'CEMENTO_TIERRA',
          v03c == 7 ~ 'TIERRA',
          T ~ NA_character_

        ),
        ndorms = case_when(

          v04 < 98 ~ as.integer(v04),
          T ~ NA_integer_

        ),
        agua_orig = case_when(

          v05 == 1 ~ 'RED_PUBLICA',
          v05 == 2 ~ 'POZO',
          v05 == 3 ~ 'CAMION',
          v05 == 4 ~ 'RIO',
          T ~ NA_character_

        ),
        parentesco = case_when(

          dpar == 1 ~ 'JEFE_HOGAR',
          dpar == 2 ~ 'CONYUGUE',
          dpar == 3 ~ 'UNION_CIVIL',
          dpar == 4 ~ 'PAREJA',
          dpar == 5 ~ 'HIJO_A',
          dpar == 6 ~ 'HIJO_A_CONYUGUE',
          dpar == 7 ~ 'HERMANO_A',
          dpar == 8 ~ 'PADRE_MADRE',
          dpar == 9 ~ 'CUÑADO_A',
          dpar == 10 ~ 'SUEGRO_A',
          dpar == 11 ~ 'YERNO_NUERA',
          dpar == 12 ~ 'NIETO_A',
          dpar == 13 ~ 'ABUELO_A',
          dpar == 14 ~ 'OTRO_PARIENTE',
          dpar == 15 ~ 'NO_PARIENTE',
          dpar == 16 ~ 'SERVICIO',
          dpar == 17 ~ 'VIV_COLECTIVA',
          T ~ NA_character_

        ),
        sexo = case_when(

          p19 == 1 ~ 'HOMBRE',
          p19 == 2 ~ 'MUJER',
          T ~ NA_character_

        ),
        edad = as.integer(p20c),
        res_5a = case_when(

          p22a == 1 ~ 'NO_NACIDO',
          p22a == 2 ~ 'ESTA_COMUNA',
          p22a == 3 ~ 'OTRA_COMUNA',
          p22a == 4 & p22b == 'PERU' ~ p22b,
          p22a == 4 & p22b == 'ARGENTINA' ~ p22b,
          p22a == 4 & p22b == 'BOLIVIA' ~ p22b,
          p22a == 4 & p22b == 'ECUADOR' ~ p22b,
          p22a == 4 & p22b == 'COLOMBIA' ~ p22b,
          p22a == 4 & !p22b %in% c('PERU', 'ARGENTINA', 'BOLIVIA', 'ECUADOR', 'COLOMBIA') ~ 'OTRO',
          p22a %in% c(98, 99) ~ 'NO_APLICA',
          T ~ NA_character_

        ),
        nacimiento = case_when(

          p23a == 1 ~ 'ESTA_COMUNA',
          p23a == 2 ~ 'OTRA_COMUNA',
          p23a == 3 & p23b == 'PERU' ~ p23b,
          p23a == 3 & p23b == 'ARGENTINA' ~ p23b,
          p23a == 3 & p23b == 'BOLIVIA' ~ p23b,
          p23a == 3 & p23b == 'ECUADOR' ~ p23b,
          p23a == 3 & p23b == 'COLOMBIA' ~ p23b,
          p23a == 3 & !p23b %in% c('PERU', 'ARGENTINA', 'BOLIVIA', 'ECUADOR', 'COLOMBIA') ~ 'OTRO',
          p23a %in% c(98, 99) ~ 'NO_APLICA',
          T ~ NA_character_

        ),
        asiste_educ = case_when(

          p31 == 1 ~ 'SI',
          p31 == 2 & p28 != 0 ~ 'NO_ACTUAL',
          p31 == 2 & p28 == 0 ~ 'NUNCA',
          T ~ NA_character_

        ),
        curso_alto = case_when(

          p30 %in% c(0 : 8) ~ as.integer(p30),
          T ~ NA_integer_

        ),
        nivel_educ = case_when(

          p28 == 2 ~ 'JARDIN',
          p28 %in% c(3, 4) ~ 'KINDER',
          p28 == 4 ~ 'DIFERENCIAL',
          p28 == 5 ~ 'BASICA',
          p28 == 6 ~ 'CIENTIFICO-HUMANISTA',
          p28 == 7 ~ 'TECNICA_PROF',
          p28 == 8 ~ 'TEC_SUPERIOR',
          p28 == 9 ~ 'PROFESIONAL',
          p28 == 10 ~ 'POSTITULO',
          p28 == 11 ~ 'MAGISTER',
          p28 == 12 ~ 'DOCTORADO',
          T ~ NA_character_

        ),
        pueblo_pert = case_when(

          p24 == 1 ~ 'SI',
          p24 == 2  ~ 'NO',
          T ~ NA_character_

        ),
        pueblo_orig = case_when(

          p25a == 1 ~ 'MAPUCHE',
          p25a == 2 ~ 'AYMARA',
          p25a == 3 ~ 'RAPA_NUI',
          p25a == 4 ~ 'LICAN_ANTAI',
          p25a == 5 ~ 'QUECHUA',
          p25a == 6 ~ 'COLLA',
          p25a == 7 ~ 'DIAGUITA',
          p25a == 8 ~ 'KAWESQAR',
          p25a == 9 ~ 'YAGAN',
          p25a == 10 ~ 'OTROS',
          T ~ NA_character_

        ),
        trabajo = case_when(

          p36 == 1 ~ 'PAGADO',
          p36 == 3 ~ 'SIN_PAGO_FAM',
          p36 == 2 ~ 'VACACIONES',
          p36 == 5 ~ 'BUSCANDO',
          p36 == 4 ~ 'ESTUDIANDO',
          p36 == 6 ~ 'QUEHACERES',
          p36 == 7 ~ 'JUBILADO',
          p36 == 8 ~ 'OTRO',
          T ~ NA_character_

        ),
        hijos_nacido = as.integer(p40),
        hijos_vivos = as.integer(p41),
        escolaridad = case_when(

          p28 == 1 ~ as.integer(0),
          p28 == 2 ~ as.integer(0),
          p28 == 3 ~ as.integer(0),
          p28 == 4 ~ as.integer(0),
          p28 == 5 ~ as.integer(p30),
          p28 == 6 ~ as.integer(p30 + 8),
          p28 == 7 ~ as.integer(p30 + 8),
          p28 == 8 ~ as.integer(p30 + 12),
          p28 == 9 ~ as.integer(p30 + 12),
          p28 == 10 ~ as.integer(p30 + 12),
          p28 == 11 ~ as.integer(p30 + 17),
          p28 == 12 & p30 <= 2 ~ as.integer(p30 + 19),
          p28 == 12 & p30 > 2 ~ as.integer(21),
          TRUE ~ NA_integer_

        ),
        tipo_area = case_when(

          area == 1 ~ 'URBANO',
          area == 2 ~ 'RURAL',
          T ~ NA_character_

        )

      ) %>%
      select(

        year, id_region, id_provin, id_comuna, id_distri, id_area, id_zona, id_manzan, tipo_area, nviv, nhogar, npers, cant_hog, cant_per, tipoviv, ocup_viv, mat_muro, mat_techo, mat_piso, ndorms, agua_orig, parentesco, sexo, edad, res_5a, nacimiento, asiste_educ, curso_alto, nivel_educ, pueblo_pert, pueblo_orig, trabajo, hijos_nacido, hijos_vivos, escolaridad

      )

    return(df0)

  } else if (year == 2002) {

    nhogares2002 <- df %>%
      filter(p17 == 1) %>%
      group_by(portafolio, vn) %>%
      summarise(
        cant_hog = n(),
        cant_per = sum(tp, na.rm = TRUE)
      ) %>%
      ungroup()

    hijos2002 <- df %>%
      group_by(portafolio, vn, hn) %>%
      summarise(
        hijos_nacido = max(p34, na.rm = T),
        hijos_vivos = max(p35, na.rm = T)
      ) %>%
      ungroup()

    df0 <- df %>%
      left_join(nhogares2002, by = c("portafolio", "vn")) %>%
      left_join(hijos2002, by = c('portafolio', 'vn', 'hn')) %>%
      mutate(

        year = '2002',
        id_region = str_sub(

          comuna,
          start = 1,
          end = 2

        ),
        id_provin = str_sub(

          comuna,
          start = 1,
          end = 3

        ),
        id_comuna = comuna,
        id_distri = paste(

          id_comuna,
          str_pad(

            distrito,
            width = 2,
            side = 'left',
            pad = '0'

          ),
          sep = ''

        ),
        id_area = paste(

          id_distri,
          area,
          sep = ''

        ),
        id_zona = paste(

          id_area,
          str_pad(

            zona,
            width = 3,
            side = 'left',
            pad = '0'

          ),
          sep = ''

        ),
        id_manzan = paste(

          id_zona,
          str_pad(

            manzana,
            width = 3,
            side = 'left',
            pad = '0'

          ),
          sep = ''

        ),
        nviv = as.integer(vn),
        nhogar = as.integer(hn),
        npers = as.integer(pn),
        tipoviv = case_when(

          v1 == 1 ~ 'CASA',
          v1 == 2 ~ 'DPTO',
          v1 == 3 ~ 'PIEZA',
          v1 %in% c(4, 5) ~ 'MEDIAGUA',
          v1 == 6 ~ 'INDIGENA',
          v1 == 7 ~ 'MOVIL',
          v1 == 8 ~ 'OTRO',
          v1 == 9 ~ 'COLECTIVA',
          T ~ NA_character_

        ),
        ocup_viv = case_when(

          v2 == 1 ~ 'PRESENTES',
          v2 == 2 ~ 'AUSENTES',
          v2 == 3 ~ 'DESOCUPADA',
          T ~ NA_character_

        ),
        mat_muro = case_when(

          v4a == 1 ~ 'HORMIGON',
          v4a %in% c(2, 3) ~ 'ALBANILERIA',
          v4a == 4 ~ 'TABIQUE_FORRADO',
          v4a == 5 ~ 'TABIQUE',
          v4a == 6 ~ 'ARTESANAL',
          v4a == 7 ~ 'PRECARIOS',
          T ~ NA_character_

        ),
        mat_techo = case_when(

          v4b %in% c(1, 2) ~ 'TEJAS',
          v4b == 3 ~ 'LOSA_HORMIGON',
          v4b %in% c(4, 5) ~ 'PLANCHAS',
          v4b %in% c(6, 7) ~ 'FONOLITA',
          v4b == 8 ~ 'PAJA',
          v4b == 9 ~ 'PRECARIOS',
          T ~ NA_character_

        ),
        mat_piso = case_when(

          v4c %in% c(1 : 4, 6, 7) ~ 'PARQUET',
          v4c == 8 ~ 'RADIER',
          v4c == 5 ~ 'BALDOSA_CEMENTO',
          v4c == 9 ~ 'TIERRA',
          T ~ NA_character_

        ),
        ndorms = as.integer(h13),
        agua_orig = case_when(

          v6 == 1 ~ 'RED_PUBLICA',
          v6 == 2 ~ 'POZO',
          v6 == 3 ~ 'RIO',
          T ~ NA_character_

        ),
        parentesco = case_when(

          p17 == 1 ~ 'JEFE_HOGAR',
          p17 == 2 ~ 'CONYUGUE',
          p17 == 3 ~ 'PAREJA',
          p17 == 4 ~ 'HIJO_A',
          p17 == 5 ~ 'HIJO_A_CONYUGUE',
          p17 == 6 ~ 'YERNO_NUERA',
          p17 == 7 ~ 'NIETO_A',
          p17 == 8 ~ 'HERMANO_A',
          p17 == 9 ~ 'CUNADO_A',
          p17 == 10 ~ 'PADRE_MADRE',
          p17 == 11 ~ 'SUEGRO_A',
          p17 == 12 ~ 'OTRO_PARIENTE',
          p17 == 13 ~ 'NO_PARIENTE',
          p17 == 14 ~ 'SERVICIO',
          p17 == 15 ~ 'VIV_COLECTIVA',
          T ~ NA_character_

        ),
        sexo = case_when(

          p18 == 1 ~ 'HOMBRE',
          p18 == 2 ~ 'MUJER',
          T ~ NA_character_

        ),
        edad = as.integer(p19),
        res_5a = case_when(

          p24a == 1 ~ 'ESTA_COMUNA',
          p24a == 2 ~ 'OTRA_COMUNA',
          T ~ NA_character_

        ),
        nacimiento = case_when(

          p22a == 1 ~ 'ESTA_COMUNA',
          p22a == 2 ~ 'OTRA_COMUNA',
          T ~ NA_character_

        ),
        asiste_educ = case_when(

          p26a == 1 ~ 'NUNCA',
          p29 == 7 ~ 'SI',
          p26a != 1 & p29 != 7 ~ 'NO_ACTUAL',
          T ~ NA_character_

        ),
        curso_alto = as.integer(p26b),
        nivel_educ = case_when(

          p26a == 2 ~ 'PREBASICA',
          p26a == 3 ~ 'DIFERENCIAL',
          p26a == 4 ~ 'BASICA',
          p26a == 5 ~ 'CIENTIFICO-HUMANISTA',
          p26a == 6 ~ 'HUMANIDADES',
          p26a %in% c(7 : 10, 12) ~ 'TECNICA_PROF',
          p26a == 11 ~ 'TEC_COMERCIAL',
          p26a %in% c(13, 14) ~ 'TEC_SUPERIOR',
          p26a == 15 ~ 'PROFESIONAL',
          T ~ NA_character_

        ),
        pueblo_pert = case_when(

          p21 != 0 ~ 'SI',
          p21 == 0 ~ 'NO',
          T ~ NA_character_

        ),
        pueblo_orig = case_when(

          p21 == 5 ~ 'MAPUCHE',
          p21 == 3 ~ 'AYMARA',
          p21 == 7 ~ 'RAPA_NUI',
          p21 == 2 ~ 'LICAN_ANTAI',
          p21 == 6 ~ 'QUECHUA',
          p21 == 4 ~ 'COLLA',
          p21 == 1 ~ 'KAWESQAR',
          T ~ NA_character_

        ),
        trabajo = case_when(

          p29 == 1 ~ 'PAGADO',
          p29 == 4 ~ 'SIN_PAGO_FAM',
          p29 == 2 ~ 'VACACIONES',
          p29 %in% c(3, 5) ~ 'BUSCANDO',
          p29 == 7 ~ 'QUEHACERES',
          p29 == 8 ~ 'JUBILADO',
          p29 == 9 ~ 'OTRO',
          T ~ NA_character_

        ),
        hijos_nacido = as.integer(hijos_nacido),
        hijos_vivos = as.integer(hijos_vivos),
        escolaridad = case_when(

          p26a == 1 ~ as.integer(0),
          p26a == 2 ~ as.integer(0),
          p26a == 3 ~ as.integer(0),
          p26a == 4 ~ as.integer(p26b),
          p26a == 5 ~ as.integer(p26b + 8),
          p26a == 6 ~ as.integer(p26b + 8),
          p26a == 7 ~ as.integer(p26b + 8),
          p26a == 8 ~ as.integer(p26b + 8),
          p26a == 9 ~ as.integer(p26b + 8),
          p26a == 10 ~ as.integer(p26b + 8),
          p26a == 11 ~ as.integer(p26b + 8),
          p26a == 12 ~ as.integer(p26b + 8),
          p26a == 13 ~ as.integer(p26b + 12),
          p26a == 14 ~ as.integer(p26b + 12),
          p26a == 15 ~ as.integer(p26b + 12),
          TRUE ~ NA_integer_

        ),
        tipo_area = case_when(

          area == 1 ~ 'URBANO',
          area == 2 ~ 'RURAL',
          T ~ NA_character_

        )

      ) %>%
      select(

        year, id_region, id_provin, id_comuna, id_distri, id_area, id_zona, id_manzan, tipo_area, nviv, nhogar, npers, cant_hog, cant_per, tipoviv, ocup_viv, mat_muro, mat_techo, mat_piso, ndorms, agua_orig, parentesco, sexo, edad, res_5a, nacimiento, asiste_educ, curso_alto, nivel_educ, pueblo_pert, pueblo_orig, trabajo, hijos_nacido, hijos_vivos, escolaridad

      )

    return(df0)

  } else if (year == 1992) {

    npers1992 <- df %>%
      filter(parentesco == 1) %>%
      group_by(portafolio, vivienda) %>%
      summarise(
        cant_hog = max(hogar),
        cant_per = sum(tp),
        ndorms = sum(pieza_dormir)
      ) %>%
      ungroup()

    df0 <- df %>%
      left_join(npers1992, by = c("portafolio", "vivienda")) %>%
      mutate(

        tipo_area = case_when(

          area == 1 ~ 'URBANO',
          area == 2 ~ 'RURAL',
          T ~ NA_character_

        ),
        tipoviv = case_when(

          tipo_vivienda == 1 ~ 'CASA',
          tipo_vivienda == 2 ~ 'DPTO',
          tipo_vivienda == 3 ~ 'PIEZA',
          tipo_vivienda %in% c(4, 5) ~ 'MEDIAGUA',
          tipo_vivienda == 6 ~ 'MOVIL',
          tipo_vivienda == 7 ~ 'OTRO',
          tipo_vivienda %in% c(8 : 11) ~ 'COLECTIVA',
          tipo_vivienda == 99 ~ 'TRANSITO',
          T ~ NA_character_

        ),
        mat_muro = case_when(

          paredes == 1 ~ 'HORMIGON',
          paredes == 2 ~ 'TABIQUE_FORRADO',
          paredes %in% c(3, 4) ~ 'ARTESANAL',
          paredes == 5 ~ 'PRECARIOS',
          paredes == 6 ~ 'OTROS',
          T ~ NA_character_

        ),
        mat_techo = case_when(

          techo %in% c(4, 5) ~ 'TEJAS',
          techo == 2 ~ 'LOSA_HORMIGON',
          techo %in% c(1, 3) ~ 'PLANCHAS',
          techo == 6 ~ 'FONOLITA',
          techo == 7 ~ 'PAJA',
          techo == 9 ~ 'OTROS',
          T ~ NA_character_

        ),
        mat_piso = case_when(

          piso == 5 ~ 'BALDOSA_CEMENTO',
          piso == 7 ~ 'TIERRA',
          piso %in% c(1 : 4, 6) ~ 'PARQUET',
          piso == 8 ~ 'OTROS',
          T ~ NA_character_

        ),
        ndorms = as.integer(pieza_dormir),
        agua_orig = case_when(

          origen_agua == 1 ~ 'RED_PUBLICA',
          origen_agua == 2 ~ 'POZO',
          origen_agua == 3 ~ 'RIO',
          origen_agua == 4 ~ 'OTRO',
          T ~ NA_character_

        ),
        ocup_viv = case_when(

          cond_ocupacion == 1 ~ 'PRESENTES',
          cond_ocupacion == 2 ~ 'AUSENTES',
          cond_ocupacion == 3 ~ 'DESOCUPADA'

        ),
        nviv = as.integer(vivienda),
        nhogar = as.integer(hogar),
        npers = as.integer(persona),
        parentesco = case_when(

          parentesco == 1 ~ 'JEFE_HOGAR',
          parentesco == 2 ~ 'CONYUGUE',
          parentesco == 3 ~ 'PAREJA',
          parentesco == 4 ~ 'HIJO_A',
          parentesco == 5 ~ 'YERNO_NUERA',
          parentesco == 6 ~ 'NIETO_A',
          parentesco == 7 ~ 'HERMANO_A',
          parentesco == 8 ~ 'PADRE_MADRE',
          parentesco == 9 ~ 'OTRO_PARIENTE',
          parentesco == 10 ~ 'NO_PARIENTE',
          parentesco == 11 ~ 'SERVICIO',
          parentesco == 12 ~ 'VIV_COLECTIVA',
          parentesco == 99 ~ 'OP_TRANSITO',
          T ~ NA_character_

        ),
        sexo = case_when(

          sexo == 1 ~ 'HOMBRE',
          sexo == 2 ~ 'MUJER',
          T ~ NA_character_

        ),
        edad = as.integer(edad),
        curso_alto = as.integer(curso),
        trabajo = case_when(

          situacion_empleo == 1 ~ 'PAGADO',
          situacion_empleo == 2 ~ 'VACACIONES',
          situacion_empleo == 3 ~ 'SIN_PAGO_FAM',
          situacion_empleo %in% c(4, 5) ~ 'BUSCANDO',
          situacion_empleo == 6 ~ 'QUEHACERES',
          situacion_empleo == 7 ~ 'ESTUDIANDO',
          situacion_empleo == 8 ~ 'JUBILADO',
          situacion_empleo %in% c(9, 10) ~ 'OTRO',
          T ~ NA_character_

        ),
        com = case_when(

          str_sub(comuna, 1, 1) == 0 ~ as.integer(str_sub(comuna, 2)),
          T ~ as.integer(comuna)

        ),
        res_5a = case_when(


          comuna_1987_origen3 == com ~ 'ESTA_COMUNA',
          comuna_1987_origen3 %in% c(700 : 999) ~ 'OTRO',
          comuna_habitual_origen3 != com & comuna_habitual_origen3 %in% c(1000 : 13700) ~ 'OTRA_COMUNA',
          T ~ NA_character_

        ),
        nacimiento = case_when(


          comuna_habitual_origen3 == com ~ 'ESTA_COMUNA',
          comuna_habitual_origen3 %in% c(700 : 999) ~ 'OTRO',
          comuna_habitual_origen3 != com & comuna_habitual_origen3 %in% c(1000 : 13700) ~ 'OTRA_COMUNA',
          T ~ NA_character_

        ),
        asiste_educ = case_when(

          tipo_educacion == 0 ~ 'NUNCA',
          T ~ NA_character_

        ),
        nivel_educ = case_when(

          tipo_educacion == 1 ~ 'KINDER',
          tipo_educacion == 2 ~ 'BASICA',
          tipo_educacion == 3 ~ 'CIENTIFICO_HUMANISTA',
          tipo_educacion == 4 ~ 'HUMANIDADES',
          tipo_educacion %in% c(5 : 11) ~ 'TEC_COMERCIAL',
          tipo_educacion %in% c(12, 13) ~ 'TEC_SUPERIOR',
          tipo_educacion == 14 ~ 'PROFESIONAL',
          T ~ NA_character_

        ),
        pueblo_pert = case_when(

          cultura %in% c(1 : 3) ~ 'SI',
          cultura == 4 ~ 'NO',
          T ~ NA_character_

        ),
        pueblo_orig = case_when(

          cultura == 1 ~ 'MAPUCHE',
          cultura == 2 ~ 'AYMARA',
          cultura == 3 ~ 'RAPA_NUI',
          T ~ NA_character_

        ),
        hijos_nacido = as.integer(hijos_nacidos_vivos),
        hijos_vivos = as.integer(hijos_vivos),
        escolaridad = case_when(

          nivel_educ == 0 ~ as.integer(0),
          nivel_educ == 1 ~ as.integer(0),
          nivel_educ == 2 ~ as.integer(curso),
          nivel_educ == 3 ~ as.integer(curso + 8),
          nivel_educ == 4 ~ as.integer(curso + 8),
          nivel_educ == 5 ~ as.integer(curso + 8),
          nivel_educ == 6 ~ as.integer(curso + 8),
          nivel_educ == 7 ~ as.integer(curso + 8),
          nivel_educ == 8 ~ as.integer(curso + 8),
          nivel_educ == 9 ~ as.integer(curso + 8),
          nivel_educ == 10 ~ as.integer(curso + 8),
          nivel_educ == 11 ~ as.integer(curso + 8),
          nivel_educ == 12 ~ as.integer(curso + 12),
          nivel_educ == 13 ~ as.integer(curso + 12),
          nivel_educ == 14 ~ as.integer(curso + 12),
          TRUE ~ NA_integer_

        ),
        dc = str_pad(

          dc,
          width = 2,
          side = 'left',
          pad = '0'

        ),
        area = as.character(area),
        zona = str_pad(

          zona,
          width = 3,
          side = 'left',
          pad = '0'

        ),
        geocode = paste(

          comuna, dc, area, zona,
          sep = ''

        ),
        year = '1992',
        id_region = region92,
        id_provin = provincia92,
        id_comuna = str_pad(

          comuna92,
          width = 5,
          side = 'left',
          pad = '0'

        ),
        id_distri = paste(

          id_comuna,
          str_pad(

            dc,
            width = 2,
            side = 'left',
            pad = '0'

          ),
          sep = ''

        ),
        id_area = paste(

          id_distri,
          area,
          sep = ''

        ),
        id_zona = paste(

          id_area,
          str_pad(

            zc_loc,
            width = 3,
            side = 'left',
            pad = '0'

          ),
          sep = ''

        ),
        id_manzan = paste(

          id_zona,
          str_pad(

            manzana,
            width = 3,
            side = 'left',
            pad = '0'

          ),
          sep = ''

        ),
        manzent92 = manzent92,
        geocode92 = geocode92

      ) %>%
      select(

        year, id_region, id_provin, id_comuna, id_distri, id_area, id_zona, id_manzan, portafolio, tipo_area, nviv, nhogar, npers, cant_hog, cant_per, tipoviv, ocup_viv, mat_muro, mat_techo, mat_piso, ndorms, agua_orig, parentesco, sexo, edad, res_5a, nacimiento, asiste_educ, curso_alto, nivel_educ, pueblo_pert, pueblo_orig, trabajo, hijos_nacido, hijos_vivos, escolaridad

      )

    return(df0)

  } else if (year == 1982) {

    df <- df %>%
      mutate(

        c = as.character(comuna),
        d = as.character(distrito),
        z = as.character(zona),
        s = str_pad(

          sector,
          width = 2,
          side = 'left',
          pad = '0'

        ),
        v = str_pad(

          vivienda,
          width = 3,
          side = 'left',
          pad = '0'

        ),
        h = str_pad(

          hogar,
          width = 3,
          side = 'left',
          pad = '0'

        ),
        id_hog = paste(

          c, d, z, s, v, h,
          sep = ''

        ),
        idviv = paste(

          c, d, z, s, v,
          sep = ''

        )

      )

    nhogs82 <- df %>%
      filter(parentesco == 1) %>%
      group_by(

        id_hog

      ) %>%
      summarise(

        cant_hog = n(),
        cant_per = max(persona)

      ) %>%
      ungroup()

    hijos <- df %>%
      filter(parentesco %in% c(1 : 3)) %>%
      group_by(

        id_hog

      ) %>%
      summarise(

        hijos_nacido = max(hijos_nacidosvivos),
        hijos_vivo = max(hijos_sobrevivientes)

      ) %>%
      ungroup()

    df0 <- df %>%
      left_join(nhogs82, by = 'id_hog') %>%
      mutate(

        npers = as.integer(persona),
        tipo_area = if_else(area == 1, 'URBANO', 'RURAL'),
        tipoviv = case_when(

          tipo_vivienda == 1 ~ 'CASA',
          tipo_vivienda == 2 ~ 'DPTO',
          tipo_vivienda %in% c(3, 5) ~ 'MEDIAGUA',
          tipo_vivienda == 4 ~ 'PIEZA',
          tipo_vivienda == 6 ~ 'INDIGENA',
          tipo_vivienda == 7 ~ 'MOVIL',
          tipo_vivienda == 8 ~ 'OTRO',
          tipo_vivienda %in% c(9 : 12) ~ 'COLECTIVA',
          T ~ NA_character_

        ),
        ocup_viv = case_when(

          cond_ocupacion == 1 ~ 'PRESENTES',
          cond_ocupacion == 2 ~ 'AUSENTES',
          cond_ocupacion %in% c(3, 4, 6, 7) ~ 'DESOCUPADA',
          cond_ocupacion == 5 ~ 'TEMPORADA',
          T ~ NA_character_

        ),
        mat_muro = case_when(

          pared == 1 ~ 'HORMIGON',
          pared == 2 ~ 'TABIQUE_FORRADO',
          pared %in% c(3, 4) ~ 'ARTESANAL',
          pared == 5 ~ 'PRECARIOS',
          pared == 6 ~ 'OTROS',
          T ~ NA_character_

        ),
        mat_techo = case_when(

          techo %in% c(3, 4) ~ 'TEJAS',
          techo %in% c(1, 2) ~ 'PLANCHAS',
          techo == 5 ~ 'FONOLITA',
          techo == 6 ~ 'PAJA',
          techo == 7 ~ 'OTROS',
          T ~ NA_character_

        ),
        mat_piso = case_when(

          piso %in% c(1 : 4) ~ 'PARQUET',
          piso == 5 ~ 'BALDOSA_CEMENTO',
          piso == 6 ~ 'RADIER',
          piso == 7 ~ 'TIERRA',
          T ~ NA_character_

        ),
        ndorms = as.integer(dormitorio),
        agua_orig = case_when(

          origen_agua == 1 ~ 'RED_PUBLICA',
          origen_agua == 2 ~ 'POZO',
          origen_agua == 3 ~ 'RIO',
          T ~ NA_character_

        ),
        parentesco = case_when(

          parentesco == 1 ~ 'JEFE_HOGAR',
          parentesco == 2 ~ 'CONYUGUE',
          parentesco == 3 ~ 'PAREJA',
          parentesco == 4 ~ 'HIJO_A',
          parentesco == 5 ~ 'YERNO_NUERA',
          parentesco == 6 ~ 'NIETO_A',
          parentesco == 7 ~ 'PADRES',
          parentesco == 8 ~ 'OTRO_PARIENTE',
          parentesco == 9 ~ 'NO_PARIENTE',
          parentesco == 10 ~ 'VIV_COLECTIVA',
          T ~ NA_character_

        ),
        sexo = case_when(

          sexo == 1 ~ 'HOMBRE',
          sexo == 2 ~ 'MUJER',
          T ~ NA_character_

        ),
        edad = as.integer(edad),
        # res_5a = case_when(
        #
        #
        #
        # ),
        # nacimiento = case_when(
        #
        #
        #
        # ),
        asiste_educ = case_when(

          asiste == 1 ~ 'SI',
          asiste == 2 ~ 'NO_ACTUAL',
          asiste == 3 ~ 'NUNCA'

        ),
        nivel_educ = case_when(

          tipo_educacion == 1 ~ 'BASICA',
          tipo_educacion == 2 ~ 'CIENTIFICO_HUMANISTA',
          tipo_educacion == 3 ~ 'HUMANIDADES',
          tipo_educacion %in% c(4 : 8) ~ 'TECNICA_PROF',
          tipo_educacion == 9 ~ 'TEC_SUPERIOR',
          tipo_educacion == 10 ~ 'PROFESIONAL',
          T ~ NA_character_

        ),
        curso_alto = as.integer(curso),
        trabajo = case_when(

          as.integer(situacion_empleo) == 1 ~ 'PAGADO',
          as.integer(situacion_empleo) == 2 ~ 'SIN_PAGO_FAM',
          as.integer(situacion_empleo) == 3 ~ 'VACACIONES',
          as.integer(situacion_empleo) %in% c(4, 5) ~ 'BUSCANDO',
          as.integer(situacion_empleo) == 6 ~ 'QUEHACERES',
          as.integer(situacion_empleo) == 7 ~ 'ESTUDIANDO',
          as.integer(situacion_empleo) == 8 ~ 'JUBILADO',
          as.integer(situacion_empleo) %in% c(9, 10) ~ 'OTRO',
          T ~ NA_character_

        ),
        hijos_nacido = as.integer(hijos_nacidosvivos),
        hijos_vivos = as.integer(hijos_sobrevivientes),
        nviv = as.integer(vivienda),
        nhogar = as.integer(hogar),
        year = '1982'

      ) %>%
      select(

        year, tipo_area, nviv, nhogar, npers, cant_hog, cant_per, tipoviv, ocup_viv, mat_muro, mat_techo, mat_piso, ndorms, agua_orig, parentesco, sexo, edad, asiste_educ, curso_alto, nivel_educ, trabajo, hijos_nacido, hijos_vivos

      )

    return(df0)

  } else {

    pass()

  }

}



