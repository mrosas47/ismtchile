<div class="buttons" id="top">
  <button>
    <a href="#hook" class="btn">To English</a>
  </button>
</div>

# <span id="spanish">Índice Socio Material Territorial</span>

#### ESP

### General

El paquete `ismtchile` fue creado con el fin de facilitar el cálculo y distribución del Índice Socio Material Territorial, indicador creado por el Observatorio de Ciudades UC. </br> La elaboración del ISMT se realizó tomando en cuenta 4 índices socio-materiales con especificidad territorial, rescatados del censo 2017 mediante RStudio. Estos son los índices de escolaridad del jefe de hogar, la materialidad de la vivienda, el hacinamiento y el allegamiento.

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
  <li><code>cleanup()</code> normaliza los nombres de los campos y elimina variables redundantes</li>
  <li><code>precalc()</code> precálculos necesarios para el proceso</li>
  <li><code>get_pca()</code> análisis de componentes principales</li>
  <li><code>ismt_scores()</code> cálculo del índice</li>
</ol>

### Instalación y uso

```
# install.packages('remotes')

# remotes::install_github('mrosas47/ismtchile')

library(ismtchile)

ismt2017 <- readRDS('censo2017.rds')
  cleanup() |> 
  precalc() |> 
  get_pca() |> 
  ismt_scores(13)

ismt2017 <- full_ismt(13, 1)
```

### Autoría y crédito

<div id="authorsdiv">
    <p id="authors">
        <h4>Creación, desarrollo y mantención del paquete</h4><br>
        <div class="people">
                    <b>Martín Rosas Araya</b> | Estudiante de Planificación Urbana UC, Certificado profesional en Front-End Web Development (W3C). Ayudante de investigación, Observatorio de Ciudades UC | <a href="mailto:mrosas1690@gmail.com">mrosas1690@gmail.com</a> | <a href="mailto:mirosas@uc.cl">mirosas@uc.cl</a>
        </div> <br>
        <h4>Creación y desarrollo del índice</h4><br>
        <div class="people">
            <b>Ricardo Truffello Robledo</b> | Geógrafo UC; Doctor en Ingeniería en Sistemas Complejos (Universidad Adolfo Ibáñez - UAI); Magíster en Geografía y Geomática UC. Director, Observatorio de Ciudades UC <br><br>
            <b>Mónica Flores Castillo</b> | Arquitecta UC y Master of Urban Planning NYU<br><br>
            <b>Gabriela Ulloa Contador</b> | Geógrafa y Msc. en geografía, mención Justicia Ambiental; Estudiante de Doctorado en Territorio, Espacio y Sociedad de la Universidad de Chile<br><br>
            <b>Isidro Puig Vásquez</b> | Geógrafo y Analista GIS, Universitat de València (España); Diplomado Programación GIS, Web Mapping y Tecnologías de la Información Geográfica, Asociación Geoinnova, Valencia (España); Diplomado de Especialización en Sostenibilidad, Ética Ecológica y Educación Ambiental, Universitat Politècnica de València (España)<br><br>
            <b>Natalia Ramírez González</b> | Asesora Ministerial de Género en el Ministerio de Transportes y Telecomunicaciones de Chile; Geógrafa y MA. en Geografía, mención organización urbano-territorial.<br><br>
            <b>Francisca Balbontin Puig</b> | Diseñadora integral UC; Diseño de plataformas de visualización de datos<br><br>
            <b>Martín Rosas Araya</b> | Estudiante de Planificación Urbana UC, Certificado profesional en Front-End Web Development (W3C). Ayudante de investigación, Observatorio de Ciudades UC <br><br>
        </div>
    </p>
</div>
<br><br>
<div class="logos">
  <a href="home.html"><img src="https://drive.google.com/uc?export=view&id=14Z67_ZlIVG8KcCJXSzW271EYbILOAX6s" alt="logos" id="Logo OCUC, logo DIMES y logo paquete ismtchile::"></a>
</div>

<br>
<div id="hook"></div>
<hr>
<br>

<div class="buttons">
  <button>
    <a class="btn" href="#top">A Español</a>
  </button>
</div>

# <span id="english">Socio-Material Territorial Indicator</span>

#### ENG

### General

The R package `ismtchile` was created to fecilitate the calculation and distribution of the Socio Material Territorial Indicator (ISMT), an indicator created by Observatorio de Ciudades UC. </br> The ISMT was created based on 4 socio-material indices with territorial specificity. These indices are the scholarity of the head of household, the materials of the dwelling, overcrowding and number of households within the same dwelling.

#### Scholarity of the head of household

This indicator was calculated with 7 levels in mind:

<ul>
  <li>No education: playgroup, pre-school.</li>
  <li>Primary: basic edication, primary or elementary (old system).</li>
  <li>Secondary: scientific humanities, professional technical, humanities (old system), commercial technical (old system), industrial / normalist (old system).</li>
  <li>Technical professional: superior (0 a 3 years)</li>
  <li>Bachelors degree: professional (4 or more years)</li>
  <li>Masters</li>
  <li>Doctorate</li>
</ul>

These scholarity levels have been calculated with census information referencing to completion of the specified scholarity level (variables `p14` and `p15`).

The weighted scores for the 7 levels were calculated considering the percentage of each level within the zone, with respect to the total amount of observations.This variable representation percentage was multiplied by a score between 1 (low scholarity level) and 1000 (high scholarity level) for each zone.

The weighted score for primary scholarity is added to the other levels in order to generate a weighted sum of for the scholarity of the head of household within the zone. This score goes from 1 to 1000.

#### Dwelling quality indicator

The dwelling quality indicator was calculated based on parameters as defined by the Ministry of Social Development (MDS). According to the indicator, 3 dimensions were taken into consideration in order to evaluate the occupied dwellings: exterior walls, roofing and floors. These conditions are then evaluated and  result in an indicator for dwelling quality based on the following categories:

<ul>
    <li>Exterior walls</li>
    <ul>
        <li>Acceptable: reinforced concrete, masonry, stone partitions lined on both sides.</li>
        <li>Retreivable: stone partitions (not lined).</li>
        <li>Irretrievable: precarious materials, waste.</li>
    </ul>
    <li>Roofing</li>
    <ul>
        <li>Acceptable: tiles, shingles, fibre cement.</li>
        <li>Retreivable: phonoloite, straw, cat-tail, coiron, cane.</li>
        <li>Irretrievable: precarious materials, no cover.</li>
    </ul>
    <li>Floors</li>
    <ul>
        <li>Acceptable: parquet, wood, floating floor, flexit, carpet, ceramics.</li>
        <li>Retreivable: tiled cement, concrete flooring, cement veneer.</li>
        <li>Irretrievable: dirt.</li>
    </ul>
</ul>

After this, the dwellings were classified according to the indicator, considering the Acceptable, Retrievable and Irretrievable categories, determined by the following conditons:

<ul>
    <li>Acceptable: exterior walls, roofing and floors are all acceptable.</li>
    <li>Retrievable: exterior walls, floors and roofing are all at least retrievable, and there is no irretrievable variable.</li>
    <li>Irretrievable: at least one of the variables (exterior wallas, roofing and floors) is irretrievable.</li>
</ul>

#### Overcrowding indicator

The overcrowding indicator was made in consideration of the methodology as defined by the Ministry of Social Development (MDS), which stipulates overcrowding as the rate of persons residing in a dwelling and the number of bedrooms in it. This calculation takes into consideration rooms with exclusive/multi-purpose use as a bedroom, and determines the Critical overcrowding, Medium overcrwoding and No overcrowding categories.

<ul>
    <li>No overcrowding: less than or equal to 2.4</li>
    <li>Medium overcrowding: between 2.5 and 4.9</li>
    <li>Critical overcrowding:equal to or bigger than 5</li>
</ul>

#### Number of households within the same dwelling indicator

### Calculation of the Territorial materiality indicator (IMT)

The composite IMT is calculated relative to the number of observations, either persons or dwellings within the zone. It includes:

<ul>
    <li>Weighted scores for the scholarity of the head of household.</li>
    <li>Weighted scores for the quality of the dwelling.</li>
    <li>Weighted scores for overcrowding.</li>
    <li>Weighted scores for number of households within the same dwelling.</li>
</ul>

#### Calculation of the scholarity of the head of household

The weighted scores for the 7 levels of scholarity were calculated takeing into consideration the percentage of each level within the zone (relative to the total number of observations). This percentage was multiplied by a score between 1 (low scholarity) and 1000 (high scholarity) for each zone.

#### Calculation of quality of the dwelling

The weighted scores for the dwelling quality categories were calculated considering the percentage  that each category represents within each zone. The percentage of representation for each categorywere multiplied by a score between 1 (irretrievable dwellings) and 1000 (acceptable dwellings). The result of these weighted scores were added to form the quality of dwelling indicator for each zone. This score spans values between 1 and 1000.

#### Calculation of overcrowding

Just like in the previous cases, the 3 categories for overcrowding were calculated considering the percentage that each one represents within its zone. The scores are also weighted with scores between 1 (critical overcrowding) and 1000 (no overcrowding). 

#### Calculation of number of dwellings within the same dwelling

Just like in the previous cases,the categories for this indicator were calculated by weighing scores between 1 (dwellings with 2 households) and 1000 (for the maximum possible value) for each zone.

#### Calculation of final scores

In order to relate these variables and understand the significance of each of them on their own, a principal components analysis calculation was applied, looking for each of the variable's weight. Each region has its own PCA, and the separation of urban and rural areas within the region is established, per INE classification.

### ISMT classification

Once the continuous score is obtained, the ISMT is classified through its percentiles. This is done by considering 2 methods:

<ol>
    <li>Quintiles: 5 categories with equal percentage of households through the distribution of continuous ISMT scores.</li>
    <li>NSE: classification according to <a href="https://www.criteria.cl/nuevo-gse-aim/" target="_blank">percentiles and cuts as defined by AIM and Criteria for 2021</a>,taking into consideration the regional differences established by the study.</li>
</ol>
<br>
<table>
    <tr>
        <th>Region</th>
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

### Adaptation and homologation

### Workflow

The workflow has been though out show as many steps in the calculation as possible, in the following order:

<ol>
  <li><code>cleanup()</code> normalizes field names and eliminates redundant variables.</li>
  <li><code>precalc()</code> nnecessary precalculations.</li>
  <li><code>get_pca()</code> Principal Components Analyisis</li>
  <li><code>ismt_scores()</code> index calculation</li>
</ol>

### Installation and usage

```
# install.packages('remotes')

# remotes::install_github('mrosas47/ismtchile')

library(ismtchile)

ismt2017 <- readRDS('censo2017.rds')
  cleanup() |> 
  precalc() |> 
  get_pca() |> 
  ismt_scores(13)

ismt2017 <- full_ismt(13, 1)
```

### Authorship and credit

<div id="authorsdiv">
    <h4>Package creation, development and maintenance</h4><br>
    <div class="people">
      <b>Martín Rosas Araya</b> | City Planning Student, UC; Front-End Web Development Professional Certificate (W3C). Research Assistant, Observatorio de Ciudades UC | <a href="mailto:mrosas1690@gmail.com">mrosas1690@gmail.com</a> | <a href="mailto:mirosas@uc.cl">mirosas@uc.cl</a>
    </div> <br>
    <h4>Index creation and development</h4><br>
    <div class="people">
      <b>Ricardo Truffello Robledo</b> | Geógrafo UC; Doctor en Ingeniería en Sistemas Complejos (Universidad Adolfo Ibáñez - UAI); Magíster en Geografía y Geomática UC. Director, Observatorio de Ciudades UC <br><br>
      <b>Mónica Flores Castillo</b> | Arquitecta UC y Master of Urban Planning NYU<br><br>
      <b>Gabriela Ulloa Contador</b> | Geógrafa y Msc. en geografía, mención Justicia Ambiental; Estudiante de Doctorado en Territorio, Espacio y Sociedad de la Universidad de Chile<br><br>
      <b>Isidro Puig Vásquez</b> | Geógrafo y Analista GIS, Universitat de València (España); Diplomado Programación GIS, Web Mapping y Tecnologías de la Información Geográfica, Asociación Geoinnova, Valencia (España); Diplomado de Especialización en Sostenibilidad, Ética Ecológica y Educación Ambiental, Universitat Politècnica de València (España)<br><br>
      <b>Natalia Ramírez González</b> | Asesora Ministerial de Género en el Ministerio de Transportes y Telecomunicaciones de Chile; Geógrafa y MA. en Geografía, mención organización urbano-territorial.<br><br>
      <b>Francisca Balbontin Puig</b> | Diseñadora integral UC; Diseño de plataformas de visualización de datos<br><br>
      <b>Martín Rosas Araya</b> | Estudiante de Planificación Urbana UC, Certificado profesional en Front-End Web Development (W3C). Ayudante de investigación, Observatorio de Ciudades UC <br><br>
    </div>
</div>
<a href="mailto:hola@observatoriodeciudades.com">hola@observatoriodeciudades.com</a>
<br><br>
<div class="logos">
  <a href="home.html"><img src="https://drive.google.com/uc?export=view&id=14Z67_ZlIVG8KcCJXSzW271EYbILOAX6s" alt="logos" id="Logo OCUC, logo DIMES y logo paquete ismtchile::"></a>
</div>

<button onclick="topFunction()" id="backToTop" title="Go to top">Top</button>

<style>
  html {text-align: justify;}
  h1, h3 {text-align: center;}
  /*body {
    background-color: #000033;
    color: #FAFAFF
  }*/
  table {
    text-align: center;
    margin-left: auto;
    margin-right: auto;
  }
  td, th {
    padding: 5px 15px;
    border-width: 1px;
    border-color: #fafaff;
    border-style: solid;
  }
  hr {
    background-color: black;
    height: 3px;
    width: 100%;
    
  }
  .buttons {
    display: block;
    text-align: right;
  }

  .btn {
    padding: 3px;
    color: black;
    text-decoration: none;
  }

  .btn:hover {
    text-decoration: none;
    color: black;
  }

  button {
    margin-right: 25px;
    background-color: darkgrey;
    border-style: none;
    padding: 10px;
    border-radius: 5px;
  }

  button:hover {
    background-color: #737373;
  }
  #backToTop {
    display: none;
    position: fixed;
    bottom: 20px;
    right: 20px;
    z-index: 99;
    border: none;
    outline: none;
    background-color: darkgrey;
    color: black;
    cursor: pointer;
    padding: 5px 10px;
    border-radius: 5px;
    font-size: 2em;
  }
  #backToTop:hover {
    background-color: #737373;
  }
  .logos {
    margin-left: auto;
    margin-right: auto;
    display: block;
    max-width: 50%;
    /*max-height: 50%;*/
    margin-top: 50px;
  }

  .logos img {
    max-width: 100%;
    max-height: 90%;
    margin-top: auto;
    margin-bottom: auto;
  }
</style>

<script>
  // Get the button
  let mybutton = document.getElementById("backToTop");

  // When the user scrolls down 20px from the top of the document, show the button
  window.onscroll = function() {scrollFunction()};

  function scrollFunction() {
  if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20)   {
      mybutton.style.display = "block";
    } else {
      mybutton.style.display = "none";
    }
  }

  // When the user clicks on the button, scroll to the top of the document
  function topFunction() {
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;
  }
</script>
