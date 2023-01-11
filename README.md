# Índice Socio Material Territorial

#### ESP

### General

El paquete `ismtchile` fue creado con el fin de facilitar el cálculo y distribución del Índice Socio Material Territorial, indicador creado por el <a href='https://www.observatoriodeciudades.com'> Observatorio de Ciudades UC</a>. La metodología completa está disponible en <a href='https://ideocuc-ocuc.hub.arcgis.com/datasets/6ed956450cfc4293b7d90df3ce3474e4/about' target=_blank>este link</a>. </br> La elaboración del ISMT se realizó tomando en cuenta 4 índices socio-materiales con especificidad territorial, rescatados del censo 2017 mediante RStudio. Estos son los índices de escolaridad del jefe de hogar, la materialidad de la vivienda, y el hacinamiento.

#### Escolaridad del jefe de hogar

El índice de escolaridad se calculó tomando en cuenta 7 niveles de escolaridad alcanzado por el jefe de hogar: 

<ul>
  <li>Sin instrucción: sala cuna o jardín infantil, pre-kinder, kinder.</li>
  <li>Primario: educación básica, primaria o preparatoria (sistema antiguo).</li>
  <li>Secundario: científico humanista, técnica profesional, humanidades (sistema antiguo), técnica comercial (sistema antiguo), industrial / normalista (sistema antiguo).</li>
  <li>Profesional técnico: técnico superior (0 a 3 años)</li>
  <li>profesional pregrado: profesional (4 o más años)</li>
  <li>Magíster</li>
  <li>Doctorado</li>
</ul>

Estos niveles de escolaridad fueron complementados con información del censo que hace referencia a si se completó o no el nivel educacional previamente declarado (variables `p14` y `p15`).

Los puntajes ponderados de los 7 niveles de escolaridad se calcularon considerando el porcentaje de cada nivel dentro de cada zona censal (con respecto al total de casos). Este porcentaje de representación de la variable fue multiplicado por un puntaje de entre 1 (nivel de escolaridad bajo) y 1000 (nivel de escolaridad alto) para cada una de las zonas 
 
El puntaje ponderado de la escolaridad básica se suma a los puntajes ponderados de los demás niveles educacionales para generar una suma ponderada de la escolaridad del jefe de hogar en la zona censal. Este puntaje va de 1 a 1000.

#### Índice de calidad de la vivienda

El índice de calidad de la vivienda se calculó tomando en consideración los parámetros definidos por el Ministerio de Desarrollo Social (MDS). De acuerdo con este índice, se consideraron 3 dimensiones a evaluar en las viviendas ocupadas: paredes exteriores, techo y piso. Estas condiciones se evalúan y resultan en un índice de la vivienda basado en aquellas que son: 

<ul>
    <li>Paredes exteriores</li>
    <ul>
        <li>Aceptable: hormigón armado, albañilería, tabique forrado por ambas caras.</li>
        <li>Recuperable: tabique sin forro interior.</li>
        <li>Irrecuperable: materiales precarios o de desechos.</li>
    </ul>
    <li>Techo</li>
    <ul>
        <li>Aceptable: tejas o tejuela, fibrocemento.</li>
        <li>Recuperable: fonolita, paja, coirón, totora o caña.</li>
        <li>Irrecuperable: materiales precarios o de desecho, sin cubierta en el techo.</li>
    </ul>
    <li>Piso</li>
    <ul>
        <li>Aceptable: parquet, madera, piso flotante o similar, cerámico, flexit, alfombra, cubre piso.</li>
        <li>Recuperable: baldosa de cemento, radier, enchapado de cemento.</li>
        <li>Irrecuperable: piso de tierra.</li>
    </ul>
</ul>
  
A continuación, se clasificó a las viviendas de acuerdo a un índice, tomando en consideración las categorías de Aceptable, Recuperable e Irrecuperable, determinadas de acuerdo a las siguientes condiciones: 

<ul>
    <li>Aceptable: materialidad de muros, techo y piso aceptables.</li>
    <li>Recuperable: muro recuperable y un ídice aceptable sea piso o techo, además de un indicador recuperable y ningún indicador irrecuperable.</li>
    <li>Irrecuperable: al menos un indicador irrecuperable.</li>
</ul>

#### Índice de hacinamiento

El índice de hacinamiento se realizó considerando la metodología del Ministerio de Desarrollo Social (MDS), el cual estipula el hacinamiento como la razón entre el número de personas residentes en la vivienda y el número de dormitorios de la misma. Este cálculo considera aquellos dormitorios de uso exclusivo o múltiple, y determina las categorías sin hacinamiento, hacinamiento medio y hacinamiento crítico, considerando los siguientes puntajes como referencia:

<ul>
    <li>Sin hacinamiento: igual o menor a 2.4</li>
    <li>Hacinamiento medio: entre 2.5 y 4.9</li>
    <li>Hacinamiento crítico: igual o mayor a 5</li>
</ul>

#### Índice de allegamiento

El cálculo del allegamiento se establece de manera simple y directa considerando la cantidad de hogares por vivienda.

### Cáluclo del Índice de materialidad territorial (IMT)

El índice compuesto de materialidad territorial se calcula con respecto al número de casos, ya sean de personas o viviendas por zona censal, e incluye:

<ul>
    <li>Puntajes ponderados por nivel de escolaridad del jefe de hogar.</li>
    <li>Puntajes ponderados por categoría de calidad de la vivienda.</li>
    <li>Puntajes ponderados por categoría de hacinamiento.</li>
    <li>Puntajes ponderados por categoría de allegamiento.</li>
</ul>

#### Cálculo de escolaridad

Los puntajes ponderados de los 7 niveles de escolaridad se calcularon considerando el porcentaje de cada nivel dentro de cada zona censal (con respecto al total de casos). Este porcentaje de representación de la variable fue multiplicado por un puntaje de entre 1 (nivel de escolaridad bajo) y 1000 (nivel de escolaridad alto) para cada una de las zonas.
 
El puntaje ponderado de la escolaridad básica se suma a los puntajes ponderados de los demás niveles educacionales para generar una suma ponderada de la escolaridad del jefe de hogar en la zona censal. Este puntaje va de 1 a 1000.

#### Cálculo de calidad de la vivienda

Los puntajes ponderados de las categorías de calidad de la vivienda fueron calculados considerando el porcentaje que cada categoría representaba en cada zona censal. Los porcentajes de representación de estas categorías fueron multiplicados por un puntaje dado de entre 1 y 1000 (1: viviendas irrecuperables y 1000: viviendas aceptables). El resultado de estos puntajes ponderados fue sumado para determinar el índice de calidad de la vivienda para la zona censal estudiada. Este puntaje va de 1 a 1000.

#### Cálculo de hacinamiento

Así como en ambos casos anteriores, las tres categorías de hacinamiento fueron calculadas por zona censal, ponderándose puntajes de entre 1 para aquellas viviendas con hacinamiento crítico, y 1000 para aquellas sin hacinamiento. Luego de realizadas las ponderaciones, el puntaje final de hacinamiento va desde 1 a 1000.

#### Cálculo de allegamiento

Así como en ambos casos anteriores, las categorías de allegamiento fueron calculadas por zona censal, ponderándose puntajes de entre 1 para aquellas viviendas con dos núcleos y 1000 para el valor máximo de allegamiento posible por la unidad territorial (ciudad o región) en donde se calcule. 

#### Cálculo de puntajes finales

Para relacionar estas variables y entender la significancia de cada una en sí misma, se realizó cálculo de componentes principales el cual busca el peso de cada una de las variables en función de la región (cada región tiene su propio PCA) y dentro de cada región se establece la separación entre territorios rurales y urbanos (tomando en consideración la clasificación del INE).

Luego de finalizada esta prueba mediante el análisis PCA, los puntajes finales fueron ponderados por la discriminación arrojada para generar una nueva suma ponderada de las cuatro variables con sus nuevos pesos.

Los resultados por zona luego fueron normalizados entre 0 y 1 para representar el nuevo índice de materialidad territorial por zona censal.

### Clasificación del ISMT

Una vez obtenido el puntaje continuo, se procede a clasificar el ISMT a través de la percentilización del mismo. Este se realiza considerando tres clasificaciones:

<ol>
    <li>Quintiles: se clasifica en 5 categorías con igual porcentaje de hogares para cada uno en función de la distribución del puntaje continuo del ISMT.</li>
    <li>NSE: se clasifica tomando los <a href="https://www.criteria.cl/nuevo-gse-aim/" target="_blank">percentiles y cortes definidos por AIM y Criteria para el año 2021</a>, tomando las diferencias regionales establecidas por el estudio.</li>
</ol>
<br>
<table>
    <tr>
        <th>Región</th>
        <th>AB</th>
        <th>C1a</th>
        <th>C1b</th>
        <th>C2</th>
        <th>C3</th>
        <th>D</th>
        <th>E</th>
    </tr>
    <tr>
        <td>1</td>
        <td>1.3</td>
        <td>6.6</td>
        <td>6.9</td>
        <td>13.7</td>
        <td>30</td>
        <td>33.2</td>
        <td>8.3</td>
    </tr>
    <tr>
        <td>2</td>
        <td>1.7</td>
        <td>6.8</td>
        <td>7.8</td>
        <td>19.5</td>
        <td>33.8</td>
        <td>25.4</td>
        <td>5</td>
    </tr>
    <tr>
        <td>3</td>
        <td>0.9</td>
        <td>5.3</td>
        <td>5.6</td>
        <td>12.7</td>
        <td>33.1</td>
        <td>34.7</td>
        <td>7.6</td>
    </tr>
    <tr>
        <td>4</td>
        <td>0.3</td>
        <td>3.2</td>
        <td>4.6</td>
        <td>9.8</td>
        <td>24.9</td>
        <td>42.4</td>
        <td>14.7</td>
    </tr>
    <tr>
        <td>5</td>
        <td>0.9</td>
        <td>5.6</td>
        <td>6.5</td>
        <td>12.1</td>
        <td>26.8</td>
        <td>37.1</td>
        <td>11.1</td>
    </tr>
    <tr>
        <td>6</td>
        <td>0.4</td>
        <td>3.3</td>
        <td>4.5</td>
        <td>9.9</td>
        <td>23.7</td>
        <td>41.7</td>
        <td>16.5</td>
    </tr>
    <tr>
        <td>7</td>
        <td>0.4</td>
        <td>2.4</td>
        <td>3.9</td>
        <td>7.4</td>
        <td>19.8</td>
        <td>44.5</td>
        <td>21.5</td>
    </tr>
    <tr>
        <td>8</td>
        <td>0.7</td>
        <td>3.8</td>
        <td>5.3</td>
        <td>9.4</td>
        <td>21.9</td>
        <td>42.2</td>
        <td>16.7</td>
    </tr>
    <tr>
        <td>9</td>
        <td>0.5</td>
        <td>3.5</td>
        <td>4.2</td>
        <td>7.8</td>
        <td>18.8</td>
        <td>42.6</td>
        <td>22.5</td>
    </tr>
    <tr>
        <td>10</td>
        <td>0.6</td>
        <td>4</td>
        <td>4.8</td>
        <td>8.9</td>
        <td>21.5</td>
        <td>44.6</td>
        <td>15.6</td>
    </tr>
    <tr>
        <td>11</td>
        <td>1.2</td>
        <td>7.6</td>
        <td>7.3</td>
        <td>12.8</td>
        <td>27.8</td>
        <td>36</td>
        <td>7.1</td>
    </tr>
    <tr>
        <td>12</td>
        <td>1.6</td>
        <td>7.1</td>
        <td>8.4</td>
        <td>17.2</td>
        <td>34.8</td>
        <td>27</td>
        <td>3.9</td>
    </tr>
    <tr>
        <td>13</td>
        <td>3.6</td>
        <td>9</td>
        <td>8.1</td>
        <td>13.7</td>
        <td>27.2</td>
        <td>30.6</td>
        <td>7.8</td>
    </tr>
    <tr>
        <td>14</td>
        <td>0.8</td>
        <td>4.5</td>
        <td>5</td>
        <td>8.6</td>
        <td>21.4</td>
        <td>41.7</td>
        <td>17.9</td>
    </tr>
    <tr>
        <td>15</td>
        <td>0.5</td>
        <td>4.6</td>
        <td>6</td>
        <td>11.7</td>
        <td>29.2</td>
        <td>38.3</td>
        <td>9.7</td>
    </tr>
    <tr>
        <td>16</td>
        <td>0.3</td>
        <td>2.9</td>
        <td>4.2</td>
        <td>7.4</td>
        <td>19</td>
        <td>42.5</td>
        <td>23.7</td>
    </tr>
    <tr>
        <td>Chile</td>
        <td>1.8</td>
        <td>6</td>
        <td>6.3</td>
        <td>11.2</td>
        <td>24.7</td>
        <td>36</td>
        <td>14</td>
    </tr>
</table>

### Adaptación y homologación

Las variables descritas anteriormente corresponden a las variables del censo 2017. Para las versiones `2.x.x` y superiores, se realizó una homologación de las variables censales de 1982, 1992, 2002, 2012 y 2017 a través de la literalización de los factores. Si bien ralentiza ligeramente el proceso de cálculo, provee la posibilidad de trabajar de forma transversal con los distintos años. La descarga de la data del 2017 está disponible en la página del ISMT, así como la metadata de la literalización.

### Flujo de trabajo

El flujo de trabajo del paquete está pensado de forma de evidenciar los mayores pasos a seguir en el cálculo del indicador, en el siguiente orden: </br>

<ol>

<li>`load_data()`descargar la data censal a la carpeta especificada y cargar a RStudio</li>

<li>`region_filter()` filtrar la data por región y tipo de área</li>

<li>`cleanup()` normaliza los nombres de los campos y elimina variables redundantes</li>

<li>`precalc()` precálculos necesarios para el proceso</li>

<li>`get_pca()` análisis de componentes principales</li>

<li>`ismt_scores()` cálculo del índice</li>

</ol>

</br> Adicionalmente, existe la posibilidad de espacializar la información a través de `load_shp()` (descarga la data espacial y la carga a RStudio) y `geomerge()` (une los resultados del ISMT con el shapefile), y de exportarla a través de `data_export()` (`.csv`, `.rds`) y `geoexport()` (`.shp`).

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

Autor del paquete: </br>

<ul>

<li>Martín Rosas Araya, Observatorio de Ciudades UC -- <a href="mailto:mrosas1690@gmail.com" target="_blank">mrosas1690@gmail.com</a></li>

</ul>

Autores del Indicador: </br>

<ul>

<li>Ricardo Truffello</li>

<li>Mónica Flores</li>

<li>Gabriela Ulloa</li>

<li>Isidro Puig</li>

<li>Natalia Ramírez</li>

<li>Francisca Balbontin</li>

<li>Martín Rosas</li>

</ul>

<a href="mailto:hola@observatoriodeciudades.com">hola@observatoriodeciudades.com</a>

# Socio-Material Territorial Index

#### ENG

### General

The `ismtchile` package was created to facilitate the calculation and distribution of the Socio-Material Territorial Index, made by <a href='https://www.observatoriodeciudades.com'> Observatorio de Ciudades UC</a>. The complete methodology is available at <a href='https://ideocuc-ocuc.hub.arcgis.com/datasets/6ed956450cfc4293b7d90df3ce3474e4/about'>this link</a>. </br> 

<style>
  html {text-align: justify;}
  h1, h3 {text-align: center;}
  body {
    background-color: #000033;
    color: #FAFAFF
  }
</style>
