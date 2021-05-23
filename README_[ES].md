# Base de datos de los Juegos Olímpicos
Se trata de una base de datos, con datos de juegos olímpicos de 1896 a 2016, estructurada para postgresql con todos los archivos relacionados con la construcción y gestión de la base de datos.

**Nota:** A pesar de que esta descripción está en español al igual que los comentarios en el código, hay varios archivos de este proyecto que se encuentran en inglés al igual que parte de la estructura de la base de datos, si quieres ver esta descripción en inglés, ve [aquí](https://github.com/Feligx/Olympics-Database/blob/main/README.md).

### | Construcción del DDL de la base de datos

Primero, realizamos el diagrama E-R con el fin de obtener un primer boceto de cómo hacer la base de datos y los posibles análisis de la misma.

![Diagrama E-R](https://github.com/Feligx/Olympics-Database/blob/main/Diagrams/Modelo_Base_de_Datos_Olimpicos_3.png)
> Diagrama Entidad-Relación de la base de datos
 
 Luego, con eso, fue posible comenzar a pensar en cómo funcionarían las tablas de la base de datos, con todas las restricciones que la rodean y buscar la Tercera Forma Normal (3FN) para obtener una buena estructura de base de datos, evitando problemas con ella en el futuro. Así, hicimos el diagrama relacional en [pgModeler](https://pgmodeler.io), y esto es lo que obtuvimos:
 
 ![Diagrama relacional](https://github.com/Feligx/Olympics-Database/blob/main/Diagrams/OlympicsR.png)
 > Diagrama relacional de la base de datos en 3FN
 
 Con eso teníamos una guía DDL completa para la base de datos, así que el siguiente paso fue escribir (con la ayuda de [pgModeler](https://pgmodeler.io)) el código SQL para construir el DDL de nuestra base de datos, y [así](https://github.com/Feligx/Olympics-Database/blob/main/relational_olympics.sql) es como quedó.
 
 Consta de 7 tablas principales:
 * `Evento:` Tiene toda la información sobre los eventos olímpicos entre 1986 y 2016.
 * `Ciudad:` Las ciudades donde se han celebrado los eventos olímpicos.
 * `Deporte:` Tiene todo sobre los deportes que se juegan en un evento.
 * `Categoría:` Todas las categorías de un deporte.
 * `Atleta:` La información sobre todos los atletas que han participado en un Evento Olímpico.
 * `Región:` Las regiones que participan en eventos Olímpicos.
 * `Medalla:` Los 3 tipos básicos de medallas que se pueden ganar.

Se pueden ver algunos ejemplos [aquí](https://github.com/Feligx/Olympics-Database/blob/main/tab_examples.md)

Y también hay otras tablas secundarias y relacionales.

### | Cargando todos los datos y construyendo módulos de Python para consultarlos

Ahora, con todo el DDL hecho, comenzamos a cargar todos los [datos](https://github.com/Feligx/Olympics-Database/tree/main/Data) en la base de datos y a hacer el [código SQL](https://github.com/Feligx/Olympics-Database/blob/main/remaining_inserts.sql) para hacerlo usando COPY para todos los datos en los archivos csv. La carga de información a la base de datos fue completamente transparente, no se realizaron cambios sobre los archivos originales y no se presentaron problemas durante ninguna de las fases. 

Y luego, teniendo la base de datos con los datos resectivos, hicimos el módulo de Python para hacer la conexión a la base de datos y obtener los datos de ella para analizarla, puedes ver el módulo [aquí](https://github.com/Feligx/Olympics-Database/blob/main/conexion_olympics.py).

Finalmente, necesitamos hacer un análisis usando los datos en la base de datos, usando los paquetes de Python `Pandas` y` Dash`.

### | Construyendo la aplicación web en Python

Con la conexión DataBase-Python lista para funcionar, podemos comenzar a construir la aplicación web donde vamos a incluir los gráficos y su respectivo análisis.

De esta manera, creamos la carpeta [Python-webapp] (https://github.com/Feligx/Olympics-Database/tree/main/Python-webapp) que contendrá todos los archivos sobre la aplicación, y comenzamos por creando la [Connection] (https://github.com/Feligx/Olympics-Database/blob/main/Python-webapp/Connection.py) un [SQLquerys] (https://github.com/Feligx/Olympics-Database /blob/main/Python-webapp/SQLquerys.py) donde configuraremos la conexión a la base de datos y crearemos las consultas que queremos llamarlas más adelante, respectivamente. Usando eso, creamos el archivo [Graphs] (https://github.com/Feligx/Olympics-Database/blob/main/Python-webapp/graphs.py) donde hacemos todos los gráficos usando guiones alrededor de los datos obtenidos de las consultas para importarlas más tarde en la aplicación web.

> ** Nota: ** aquí tienes que instalar dash-bootstrap-components adicionales a los componentes principales de `Dash`, usa:
```
pip instalar dash-bootstrap-components
```
Finalmente, hicimos el archivo "[main] (https://github.com/Feligx/Olympics-Database/blob/main/Python-webapp/main.py)" donde descansa toda la estructura de la aplicación web, aquí usó los componentes `Dash` como` dash-core-components`, `dash-html-components`,` dash-bootstrap-components` y también `Plotly` y` Pandas` para hacerlo posible. Aquí importamos los gráficos creados por el archivo mencionado anteriormente para ponerlos en tarjetas con pestañas para analizarlos. El archivo tiene una pequeña descripción de algunas cosas que necesitan explicación.

Quizás preguntes, ¿qué es el archivo `style.css` que está en la carpeta [assets] ()? Bueno, es el archivo que contiene las clases y estilos para la aparición de la aplicación web ... ¿Qué? ¿Por qué no se importa en el archivo principal? podrías preguntar. Esto se debe a que es una propiedad de Dash, carga todos los archivos css y js en la carpeta de activos (si existe) de la aplicación web, por lo que no necesitamos importar el archivo en nuestro `main.py`.

En la aplicación web hay una versión resumida de este archivo que describe el proyecto, y otra cosa a tener en cuenta es que usamos la biblioteca `base64` para codificar imágenes locales y usarlas en la aplicación web porque` Dash` no lo hace. permitir esto, pero aún dejamos esa parte en manos del usuario, también es posible usarlos dejando en el atributo "src" de la etiqueta `<img>` como una URL a las imágenes en este repositorio (¡como hicimos! dejando la otra parte oculta como comentarios).


¡Espero que encuentren útil esta "pequeña" descripción de nuestro proyecto de base de datos y cómo funciona!

### | ** Lista de errores y bugs que encontramos durante el proceso y aún existen en los archivos: **
* Ninguno :)
