## Clasificación espacial de los paraderos del SITP en Bogotá

![enter image description here](https://lh3.googleusercontent.com/pw/ACtC-3ez6alpHRetbYoqMYJRoDbzms_yawByw1A-vTTrZ_BxLc76wwMR_vf_LF6ql0i4YIC2vfw-R0z1oOAnnf-2f28ouH43Mso--GLVXnja0Am_LuAsTOWNHOVl3IIncii45A-iiZq1QS-1rM4SGhuhVe8nWA=w594-h622-no?authuser=0)

## Descripción y motivación

La movilidad es un punto neurálgico en los planes de desarrollo y en la visión de la ciudad a futuro. En esta línea, el Sistema Integrado de Transporte Público (SITP) ha sido uno de los principales esfuerzos por modernizar el transporte público en Bogotá mediante el pago unificado, planificación de las rutas y el uso de flota con tecnología del siglo XXI. 
Una de las principales características de este sistema es la designación y exclusividad de ciertas zonas para abordar los buses, en contraste con la desordenada forma de hacerlo previamente, donde toda la ciudad estaba habilitada para hacerlo. 

Según el portal institucional del SITP: “Los paraderos se ubican estratégicamente en diferentes puntos de la ciudad y son los únicos puntos autorizados donde un bus del SITP puede detenerse y el usuario puede tomar un servicio. Estos constan de una señal y una línea amarilla.”  Cada paradero se identifica con un número único que uso interno (cenefa) y el número de rutas que paran allí. Además se clasifican según el número de rutas que paren en cada uno.

El portal web de TransMilenio cuenta con los datos respectivos al trayecto de todas las rutas del componente urbano, alimentador, especial y complementario. Asimismo, puede visualizarse cuales rutas paran sobre cada uno de los 8194 listados en la página web. Para este proyecto, se realizó la extracción de la información de los paraderos del SITP mediante webscrapping, fueron procesados y limpiados en _Pandas_ y las estadísticas descriptivas fueron realizadas en _R Studio_.  Para observar la distribución espacial, fueron construidos y combinados mapas en _QGIS_. Los resultados fueron presentados en _Tableau_.

Este trabajo tiene la finalidad de explorar y explotar estos nuevos datos proporcionados por la puesta en marcha del SITP y responder las siguientes preguntas:

- ¿Cuantas rutas paran en cada paradero de la ciudad?
- ¿Como están distribuidos los tipos de paraderos?
- Informes presentados por la Contraloría de Bogotá la implementación del SITP va en 58%, por lo cual, es necesario continuar con el uso de las rutas tradicionales de transporte público de manera **provisional**. ¿Cómo se refleja en la ciudad la interacción entre la oferta de transporte público zonal y provisional?
 - La población de Bogotá se reparte desigualmente en Bogotá, ¿Las zonas más pobladas tienen mayor o menor oferta de rutas? ¿A qué responden estos patrones?
 - ¿Cuáles son las zonas con mayor y menor oferta de transporte dados los tipos de paraderos?
- El análisis de indicadores demográficos en Bogotá suele realizarse tomando a las localidades como referencia. No obstante, estas son heterogéneas y tomar el valor promedio de un indicador podría no dar cuenta de la realidad. Por lo tanto, ¿cómo se distribuyen estos resultados tomando unidades más pequeñas (Unidades de Planeamiento Zonal) como unidad de referencia?

Información sobre los paraderos del SITP: [https://www.sitp.gov.co/publicaciones/40572/paraderos_del_sitp/](https://www.sitp.gov.co/publicaciones/40572/paraderos_del_sitp/).

Para revisar la presentación de este proyecto en pdf: [enter link description here](https://github.com/maanievesbu/paraderossitp/tree/master/Presentaci%C3%B3n)

## Methods used

### Scraping

- La información de cada paradero de Bogotá está contenida en la siguiente página: [https://www.transmilenio.gov.co/buscador_de_rutas](https://www.transmilenio.gov.co/buscador_de_rutas)

- Este sitio está renderizado en JavaScript. Extraje la información de cada paradero mediante la librería _Selenium_ y _Webdriver_ en Google Chrome.

- Empleé el lenguaje XPath para construir expresiones que recorrieran y procesaran el documento XML de la página de TransMilenio.

- El procedimiento de extracción consistió en dos etapas:

- - Recorrer las 410 páginas de la lista de paraderos y almacenar la cenefa y el enlace de cada paradero. Dos listas de la misma extensión fueron obtenidas.

- - Definir una función que retornara una tupla que almacenara la cenefa y el número de rutas que paran en un enlace dado. Aplicar esta función a los 8120 enlaces resultantes de la primera etapa y almacenar en una lista todas las tuplas obtenidas. Para cada enlace almacenado en la etapa anterior, construir un XPath que permitiera obtener cuantas rutas paran en cada paradero junto a su cenefa.

- El código de Python está disponible [aquí](https://github.com/maanievesbu/MCPP_mario.nieves/blob/master/Proyecto%20final/Notebook/Proyecto%20final%20MCPP.ipynb).

### Limpiar, procesar y almacenar los datos.

 - Utilicé _Pandas_ para crear un _data frame_ para las dos tandas de objetos.

 - Consolidé los dos _data frame_ en uno solo teniendo la variable cenefa como identificador común y limpié la base de datos utilizando métodos de _Pandas_ y _Strings._

 - La base final tiene las siguientes variables: cenefa, nombre del barrio, número de rutas que paran en cada paradero (frecuencia) y enlace.

 - El código de Python está disponible [aquí](https://github.com/maanievesbu/MCPP_mario.nieves/blob/master/Proyecto%20final/Notebook/Proyecto%20final%20MCPP.ipynb).

 - -  Clasificar cada paradero según su tipo:

 - Dada la frecuencia asignada a cada paradero, se generó la siguiente clasificación para todos los paraderos del SITP de la siguiente forma:

       Tipo 0: 0 rutas.
       Tipo 1: 1-2 rutas
       Tipo 2: 3-5 rutas
       Tipo 3: 6-8 rutas
       Tipo 4: 9-11 rutas
       Tipo 5: 12-20 rutas.

 - Este paso fue realizado en _R Studio_. [https://github.com/maanievesbu/MCPP_mario.nieves/tree/master/Proyecto%20final/R/Scripts]

 ### Generar mapas en QGIS.

 Descargar mapas relevantes para este trabajo (en formatos _Shapefile_ y _WMS_):

 - El portal **Datos Abiertos** de la Alcaldía de Bogotá ([https://datosabiertos.bogota.gov.co/](https://datosabiertos.bogota.gov.co/)) cuenta con gran riqueza de datos económicos y sociales de la ciudad. Para este trabajo descargué los siguientes mapas:

 - Localidades de Bogotá:

[https://datosabiertos.bogota.gov.co/dataset/localidad-bogota-d-c](https://datosabiertos.bogota.gov.co/dataset/localidad-bogota-d-c).

- Zonas del SITP:

[https://datosabiertos.bogota.gov.co/dataset/zonas-sitp-bogota-d-c](https://datosabiertos.bogota.gov.co/dataset/zonas-sitp-bogota-d-c).

- De la página de **Laboratorio Urbano – Bogotá** obtuve la información poblacional y referentes geográficos de las Unidades de Planeamiento Zonal (UPZ):

[https://bogota-laburbano.opendatasoft.com/explore/dataset/poblacion-upz-bogota/table/?flg=es&sort=-cod_loc&location=13,4.71553,-74.07712&basemap=jawg.streets](https://bogota-laburbano.opendatasoft.com/explore/dataset/poblacion-upz-bogota/table/?flg=es&sort=-cod_loc&location=13,4.71553,-74.07712&basemap=jawg.streets).

- Del portal de la **Secretaría Distrital de Movilidad** descargué la base de datos de todos los paraderos del SITP en Bogotá: [https://datos-abiertos-sdm-movilidadbogota.hub.arcgis.com/datasets/paraderos-sitp-bogot%C3%A1-d-c?geometry=-74.122%2C4.727%2C-74.066%2C4.742](https://datos-abiertos-sdm-movilidadbogota.hub.arcgis.com/datasets/paraderos-sitp-bogot%C3%A1-d-c?geometry=-74.122%2C4.727%2C-74.066%2C4.742). Esta base contiene identificadores geográficos.

**Complementar los mapas con datos visualmente relevantes**:

- Calles, avenidas y calzadas de la ciudad:

[https://datosabiertos.bogota.gov.co/dataset/calzada-bogota-d-c](https://datosabiertos.bogota.gov.co/dataset/calzada-bogota-d-c).

- Rutas del SITP zonal:

[https://datosabiertos.bogota.gov.co/dataset/ruta-urbana](https://datosabiertos.bogota.gov.co/dataset/ruta-urbana).

- Rutas del SITP provisional (para analizar la interacción entre el componente provisional y zonal):

[https://datosabiertos.bogota.gov.co/dataset/ruta-sitp-provisional](https://datosabiertos.bogota.gov.co/dataset/ruta-sitp-provisional).

**Combinación de mapas y bases de datos**:

- El insumo principal de este trabajo es la base de datos construida en Python. Esta base fue combinada al mapa de paraderos del SITP en Bogotá para ponderar el número de rutas en cada paradero de la ciudad, y de esta manera, diferenciar espacialmente los tipos de paraderos.

- Contar el número de puntos en cada polígono para cada nivel de agregación geográfica (Localidades, UPZ y Zonas SITP). Los puntos son los paraderos y los polígonos las agregaciones geográficas. En este punto se discrimina según tipo de paradero.

El archivo .qgz se encuentra [aquí](https://github.com/maanievesbu/MCPP_mario.nieves/blob/master/Proyecto%20final/QGIS/Proyecto%20final.qgz).

## Generar gráficas en _Tableau_:

- Con los datos de la etapa anterior, procedí a generar gráficas según el tipo de paradero y nivel de agregación geográfica.

- La herramienta _pivotar_ me permitió relacionar todos los tipos de paradero a fin de mostrar la proporción en cada una de las zonas.

- El dashboard de Tableau está almacenado en esta página: [https://public.tableau.com/profile/alejandro.n7172#!/vizhome/EvaluacinespacialdelosparaderosdelSITPenBogot/Dashboard1](https://public.tableau.com/profile/alejandro.n7172#!/vizhome/EvaluacinespacialdelosparaderosdelSITPenBogot/Dashboard1).

## Resultados

-   7417 paraderos del SITP en Bogotá obtenidos en el ejercicio de Webscraping a la página de TransMilenio (descontando 763 paraderos repetidos para un total de 8180 iniciales):

- - 6772 (91,3%) paraderos en común entre las bases cruzadas.
- - 645 (8,69%) cenefas no se encuentran actualizadas en la página de TransMilenio.

Según tipo de paradero:
  
- Tipo 0 (0 rutas): 629 paraderos. (9,29%).

- Tipo 1 (1-2 rutas): 2197 paraderos (32,4%).

- Tipo 2 (3-5 rutas): 1774 paraderos (26,2%).

- Tipo 3 (6-8 rutas): 1170 paraderos (17,2%).

- Tipo 4 (9-11 rutas): 633 paraderos (9,35%).

- Tipo 5 (12 o más rutas): 366 rutas (5,4%).

### Por desagregación geográfica

![Localidades](https://lh3.googleusercontent.com/pw/ACtC-3ewyHNeKm0UcN01NC3Eivb0Tgt1AQ6ybTexJhuP_CB0p0UOoj-o47TVeSsFwg0BzsX9PDCE5PbL9O7795ZcuBi5Rmnj2W4lI-84Hd5hTnBdART_MuLSgwN0YSJ5xTnR7qf4GKcbNDpVp0PVCHhp0fNBmQ=w954-h471-no?authuser=0)

![enter image description here](https://lh3.googleusercontent.com/pw/ACtC-3cZCy7FqRw40Y7x-u-GJ6m4vxmb_1rMlxqzLS4kOqdC6QiohvkX5vpLEKQ-AJSzFZe52pqtNEZATuHkmn63ZEwlKGDoO0i3d4QhRpgcu91mNeYxVMmCQ9QYnxSP8cB3bIkK_G98Uq4XcdsGTui7aSqp_g=w979-h511-no?authuser=0)

![enter image description here](https://lh3.googleusercontent.com/pw/ACtC-3dId3ihr0LfaIenWlc33HOqMzfmm7sFt19ainJVXtuX5fvZqW_KNStv9zbNLhLGFNMXp6V4uMLvvXq7PQru2aaMPdWR3InA8r6GxZdoIaDHZH7pN2jyltdVfAFQtJjQN_1VDrKsR7fBvHRVCfACpkxyDw=w979-h475-no?authuser=0)

![enter image description here](https://lh3.googleusercontent.com/pw/ACtC-3dOV9qdWyg5xgHka3I8cUdMmrqHr4cuyR0pp_dyDKkk-J39U3r-0HK32c3n3-isYdNKSM9GfUEM4wkdcGeCjYKVFvFVHj5QMmC9sFHl5wAndGcGkybKcV73RGZt1p3NypUAs3AGaVDW736XKU4tz274CQ=w953-h470-no?authuser=0)

![enter image description here](https://lh3.googleusercontent.com/pw/ACtC-3d47a8zCMuS3AwHJa9ikYv5K9PyEUkTUdcSacKvVLObmRiKGhLhNIcJQBqXAvijJf71AmVrWCEvz-kmXtGY9YsfR7lVuOYem29RouotLwJPk9-ZoCLXaFnu2xJytsa7IgGiUHHCI1NWior1lASrGY8VzQ=w955-h462-no?authuser=0)

![enter image description here](https://lh3.googleusercontent.com/pw/ACtC-3dbkn3DkZU_i8oV-PQdOapXqsyBNWliKTqEZ5R3R7OhiQZUmYIiH-Q0Fr14DQYYqJ9GnVdxcgf7VOOvcbT7hpxTNrq6TPYYR6tVI-RoNSVebBcpqlR8E1BLtJo6DTkgZZ5vL1mFPcjPscMpCTwQYMzHFQ=w955-h462-no?authuser=0)

![enter image description here](https://lh3.googleusercontent.com/pw/ACtC-3f6aL0VjXjMO-eHJT9ISCvL61lofh22YRjd2-655WAjxTm1I80951gbW-83XdEFbRtpiZ1m6dSmN2pWGySvq0CoIPgQVUeKRpC5pTbh2DBf8HIGq8wchEZvzOrKnIIJviOtbUyPfNhzJCbUJWhVMGTVfA=w953-h461-no?authuser=0)

![enter image description here](https://lh3.googleusercontent.com/pw/ACtC-3eNNsvD5c9C7ks-KGN2ugiF5o8Jlf9Y9ZqNngdfrfvL8tdWAHGXg3b3CrcifHsr2z7SWrDIGFUWGW_4sPGpzog1zQxnExqvI8Au70aXqf_jTRrSZYJ3ltF-inITN3TXwYxlslLYzWyqoS9Li32bsJVH6A=w977-h489-no?authuser=0)

### Mapas

![enter image description here](https://lh3.googleusercontent.com/pw/ACtC-3cPTWzyIy-TafJbS4C41-Y7YbsPyhYEXIkyST_f4pDwZUffGOC2OJNx4FUC_MV2bz5TbSK6hxjPzQYGAAE4nsjM8SbU3qt4UItIkzZU47euH_8Ri8PomzFqAjGkZ2Y-9DFgDlcw8D9QwuvB4-NPPtG4tg=w647-h477-no?authuser=0)

Todos los mapas se encuentran [aquí](https://github.com/maanievesbu/MCPP_mario.nieves/tree/master/Proyecto%20final/QGIS/Mapas%20output/Mapas%20finales).

#### Tablas
Las estadísticas para cada nivel se muestran en los siguientes enlaces:
- [Localidades](https://github.com/maanievesbu/MCPP_mario.nieves/blob/master/Proyecto%20final/R/Output/Localidades%20-%20Descriptives.csv).
- [UPZ](https://github.com/maanievesbu/MCPP_mario.nieves/blob/master/Proyecto%20final/R/Output/UPZ%20-%20Descriptives.csv).
- [Zonas SITP](https://github.com/maanievesbu/MCPP_mario.nieves/blob/master/Proyecto%20final/R/Output/Zonas%20-%20Descriptives.csv).
