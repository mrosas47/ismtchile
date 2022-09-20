<style>
  html {text-align: justify;}  
</style>

# Índice Socio Material Territorial

#### ESP

### General

El paquete ```ismtchile ``` fue creado con el fin de facilitar el cálculo y distribución del Índice Socio Material Territorial, indicador creado por el <a href='https://www.observatoriodeciudades.com'> Observatorio de Ciudades UC</a>. La metodología completa está disponible en <a href='https://ideocuc-ocuc.hub.arcgis.com/datasets/6ed956450cfc4293b7d90df3ce3474e4/about'>este link</a>. </br> La construcción social del territorio y su materialidad resultan de una dialéctica socio-espacial donde se reconoce que el componente social estructura los territorios, al mismo tiempo que los territorios dan forma a la sociedad. En el presente estudio, esta dialéctica es fundamental para comprender la dimensión de materialidad territorial, la cual es observada a través de variables sociales y la calidad de la vivienda en la ciudad de Santiago. </br> </br> El Índice está basado en 4 variables derivadas del Censo de Población: <ul><li>Escolaridad del jefe de hogar</li><li>Materialidad de la vivienda</li><li>Hacinamiento</li><li>Allegamiento</li></ul>

### Variables 

##### <b>Escolaridad</b>

Se calculó tomando en cuenta 7 niveles de escolaridad alcanzado por el jefe de hogar: <ul><li>Sin instrucción: Sala cuna o jardín infantil, pre-kínder, kínder.</li><li>Primario: Educación básica, primaria o preparatoria (sistema antiguo).</li><li>Secundario: Científico-humanista, técnica profesional, humanidades (sistema antiguo), técnica comercial, industrial/normalista (sistema antiguo).</li><li>Profesional técnico: Técnico superior (0 a 3 años).</li><li>Profesional pregrado: Profesional (4 o más años).</li><li>Magister</li><li>Doctorado</li></ul> Estos niveles de escolaridad fueron complementados con información del censo que hace referencia a si se completó o no el nivel educacional previamente declarado. (Variables p14 y p15).

##### <b>Calidad de la vivienda</b>

Se calculó tomando en consideración los parámetros definidos por el Ministerio de Desarrollo Social (MDS). De acuerdo con este índice, se consideraron 3 dimensiones a evaluar en las viviendas ocupadas: Las paredes exteriores, el techo y el piso. Estas condiciones se evalúan y resultan en un índice de la vivienda basado en aquellas que son ACEPTABLES, RECUPERABLES e IRRECUPERABLES. </br> <u>Muro</u> <ul><li>ACEPTABLES: Hormigón, armado; albañilería, tabique forrado por ambas caras.</li><li>RECUPERABLES: Tabique sin forro interior.</li><li>IRRECUPERABLES: Materiales precarios o de desechos.</li></ul> </br> <u>Techo</u> <ul><li>ACEPTABLE: Tejas o tejuela, fibrocemento.</li><li>RECUPERABLE: Fonolita; paja, coirón, totora o caña.</li><li>IRRECUPERABLE: Materiales precarios o de desecho; sin cubierta en el techo.</li></ul> </br> <u>Piso</u> <ul><li>ACEPTABLE: Parquet, madera, piso flotante o similar; cerámico, flexit; alfombra o cubre piso.</li><li>RECUPERABLE: Baldosa de cemento, radier, enchapado de cemento.</li><li>IRRECUPERABLE: Piso de tierra.</li></ul> </br> A continuación, se clasificó a las viviendas de acuerdo a un índice, tomando en consideración las categorías de “Aceptable“,“ Recuperable “e “Irrecuperable“, determinadas de acuerdo a las siguientes condiciones: Categoría aceptable: Materialidad en muros, piso y techo aceptable; Categoría recuperable: Muro recuperable, y un índice aceptable, sea de piso o techo, además de un indicador recuperable y ningún indicador irrecuperable; Categoría irrecuperable: Al menos un indicador irrecuperable.

##### <b>Hacinamiento</b>

se realizó considerando la metodología del Ministerio de Desarrollo Social (MDS), el cual estipula el hacinamiento como la razón entre el número de personas residentes en la vivienda y el número de dormitorios de la misma. Este cálculo considera aquellos dormitorios de uso exclusivo o múltiple, y determina las categorías sin hacinamiento, hacinamiento medio y hacinamiento crítico, considerando los siguientes puntajes como referencia: </br> <ul><li>2.4 o menos - sin hacinamiento</li><li>2.5 a 4.9 - hacinamiento medio</li><li>6 o más - hacinamiento crítico</li></ul>

##### <b>Allegamiento</b>

El cálculo del allegamiento se establece de manera simple y directa considerando la cantidad de hogares por vivienda.

### Flujo de trabajo

El flujo de trabajo del paquete está pensado de forma de evidenciar los mayores pasos a seguir en el cálculo del indicador, en el siguiente orden:  </br> <ol><li>```load_data()```descargar la data censal a la carpeta especificada y cargar a RStudio</li><li>```region_filter()``` filtrar la data por región y tipo de área</li><li>```cleanup()``` normaliza los nombres de los campos y elimina variables redundantes</li><li>```precalc()``` precálculos necesarios para el proceso</li><li>```get_pca()``` análisis de componentes principales</li><li>```ismt_scores()``` cálculo del índice</li></ol> </br> Adicionalmente, existe la posibilidad de espacializar la información a través de ```load_shp()``` (descarga la data espacial y la carga a RStudio) y ```geomerge()``` (une los resultados del ISMT con el shapefile), y de exportarla a través de ```data_export()``` (```.csv```, ```.rds```) y ```geoexport()``` (```.shp```).

### Instalación y uso

```
# install.packages('remotes')

# remotes::install_github('mrosas47/ismtchile')

library(ismtchile)
library(tidyverse)
library(here)

loc_dir <- here()

crit_AIM <- get_criteria(13, path = loc_dir)

c17 <- load_data(13, path = loc_dir) %>% 
  region_filter(13, 1) %>% 
  cleanup() %>% 
  precalc() %>% 
  get_pca() %>% 
  ismt_scores(crit_AIM, 13)
  
c17 %>% data_export(13, loc_dir)

c17geo <- load_shp(13, 1, loc_dir)

c17geomerge <- geomerge(c17, c17geo)

c17geomerge %>% geoexport(13, loc_dir)
```

### Autoría y crédito

Autor del paquete: </br> <ul><li>Martín Rosas Araya, Observatorio de Ciudades UC -- mrosas1690@gmail.com</li></ul>
Autores del Indicador: </br> <ul><li>Dr. Ricardo Truffello, Observatorio de ciudades UC -- rtruffel@uc.cl</li><li>Mónica Flores</li></ul>
