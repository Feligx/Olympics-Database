import dash
import dash_core_components as dcc
import dash_html_components as html
import dash_bootstrap_components as dbc #se importa esta libreria para tener la posibilidad de usar ciertas caracteristicas de bootstrap que normalmente no se tienen con el dash_html_components
#para instalar esta ibreria use: pip install dash-bootstrap-components
from dash.dependencies import Input, Output #se importa para poder hacer los callbacks, ya viene en dash_html_components, solo hay q colocar este import
import plotly.express as px
import pandas as pd
from Connection import Connection

import SQLquerys as sql #este archivo contiene todos los querys que se usan para crear los graficos
import base64 #esta libreria permite codificar imagenes locales para colocarlas en la webapp y es parte de la libreria estandar de python
import graphs as gr #este archivo esta la creacion de todos los gráficos a usar en la webapp

external_stylesheets = ["https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"]

# Inicializacion app dash
app = dash.Dash(__name__, external_stylesheets=external_stylesheets)



#Creacion de las rutas de imagenes a usar, si se plantea usarlas de forma local, descomentar esta seccion
#image_filename = 'img\oly_logo.png'
#encoded_image = base64.b64encode(open(image_filename, 'rb').read())

#image_filename2 = 'img\github.svg'
#encoded_image2 = base64.b64encode(open(image_filename2, 'rb').read())

#image_filename4 = 'img\main_img.png'
#encoded_image4 = base64.b64encode(open(image_filename4, 'rb').read())

image_filename5 = 'img\macc_ur_logo.png'
encoded_image5 = base64.b64encode(open(image_filename5, 'rb').read())

#image_filename6 = 'img\OlympicsR.png'
#encoded_image6 = base64.b64encode(open(image_filename6, 'rb').read())


# Layout

#Card con los gráficos sin análisis
card=dbc.Card([
    dbc.CardHeader(
    dbc.Tabs(
                    [
                        #Se inicializan los tabs de la seccion Analisis, colocandoles un id para luego usarlo y asi colocarles el contenido
                        dbc.Tab(label="Gráfico 1", tab_id="tab-1",className="ctest"),
                        dbc.Tab(label="Gráfico 2", tab_id="tab-2",className="ctest"),
                        dbc.Tab(label="Gráfico 3", tab_id="tab-3",className="ctest"),
                        dbc.Tab(label="Gráfico 4", tab_id="tab-4",className="ctest"),
                        dbc.Tab(label="Gráfico 5", tab_id="tab-5",className="ctest"),
                        dbc.Tab(label="Gráfico 6", tab_id="tab-6",className="ctest"),
                    ],
                    id="card-tabs",
                    card=True,
                    active_tab="tab-1",
                    )
                    ,style={'border': '1px solid rgba(0,0,0,.125)'}),
                    dbc.CardBody(html.P(id="card-content", className="card-text"),style={'border': '1px solid rgba(0,0,0,.125)'}),
],style={'padding':25,'border':'none'})

#Card con los análisis a fondo
tab1_content = dbc.Card(
    dbc.CardBody(
        [
            #se construye el contenido del tab, con el analisis a fondo y la grafica que se esta analizando
            html.H4("Análisis de medallas de oro obtenidas por atleta", className="card-text"),
            dcc.Graph(
                id='Graph 1',
                figure=gr.figBar
                ),
            html.P("Este gráfico de barras nos permite observar la cantidad de medallas que han obtenido los y las mayores 20 medallistas de oro de la historia sin diferenciación de género. Este gráfico es particularmente útil para este tipo de análisis porque muestra de manera gráfica la diferencia que pueden existir en el número de medallas de estos deportistas. Para este caso en particular, al sobreponer el mouse sobre una barra se puede obtener el nombre completo del deportista además del número de medallas de oro que ha ganado. Se evidencia que Michael Phelps tiene más del doble de medallas de oro que el segundo deportista con más medallas, Raymond Clarance, con 23 y 10 medallas respectivamente. A pesar de los beneficios que este gráfico aporta, una de sus principales limitaciones es que no ofrece más información sobre el deportista como: nacionalidad, género, estatura, etc. Para obtener esta información es necesario recurrir a otro tipo de gráficos que reúnan más información."),
            #dbc.Button("Ver consulta", color="success"),
        ]
    ),
    className="mt-3",
)

tab2_content = dbc.Card(
    dbc.CardBody(
        [
            #se construye el contenido del tab, con el analisis a fondo y la grafica que se esta analizando
            html.H4("Análisis de medallas de oro obtenidas por país en la historia de los juegos", className="card-text"),
            dcc.Graph(
                id='Graph 2',
                figure=gr.figMap
                ),
            html.P("En el mapa de calor es posible evidenciar una clara dominancia frente a otras delegaciones por parte de Estados Unidos en lo que respecta a la cantidad de medallas de oro ganadas por un país. Este gráfico resulta ser bastante adecuado y relevante ya que presenta la información de una manera simple, visual y amigable, en la cual a las regiones geográficas les son asignados colores más oscuros cuando a estas les corresponden a mayores valores, mientras que los tonos son más claros a cuando son menores. Por otro lado, en adición a la representación cuantitativa de las medallas de oro que han sido ganadas por delegación mediante el código de colores, al ubicar el cursor sobre cada territorio se revela la cantidad de medallas que le corresponden. No obstante, esta visualización plantea una gran limitación y es que debido a la brecha que existe entre Estados Unidos (que cuenta con más de 2500 medallas) y los demás países, resulta difícil la definición de una escala que permita la correcta visualización de los datos y el hacer comparaciones entre las cantidades correspondientes a cada país. Esto se traduce en una mayor dificultad a la hora de realizar conclusiones si estas se hicieran únicamente a partir del diagrama, puesto que a países como Venezuela, que tan solo cuentan con 2 medallas de oro, les es asignado un color muy similar al de México, país al que le han sido otorgadas 30. "),
            #dbc.Button("Ver consulta", color="success"),
        ]
    ),
    className="mt-3",
)

tab3_content = dbc.Card(
    dbc.CardBody(
        [
            #se construye el contenido del tab, con el analisis a fondo y la grafica que se esta analizando
            html.H4("Análisis de porcentaje de medallas obtenidas por Colombianos agrupadas por género", className="card-text"),
            dcc.Graph(
                id='Graph 3',
                figure=gr.figPie
                ),
            html.P("El gráfico de torta permite observar que, en el país no hay una diferencia considerable entre el número de medallas obtenidas por género en los juegos olímpicos, pues los hombres lideran la cuenta con una diferencia de menos del 8%. Una gran ventaja de este gráfico es que permite representar proporciones obtenidas a partir de SQL, sin la necesidad de especificar en la búsqueda que se requiere obtener un porcentaje. Al pasar el cursor del mouse sobre cada una de las secciones del gráfico, se obtiene información adicional sobre lo que representa dicho porcentaje, y nos revela que en la historia las mujeres en representación de la delegación colombiana han obtenido 13 medallas mientras que los hombres han obtenido 15 medallas. Una limitación de este gráfico es que solo permite comparar diferentes resultados sobre dos tipos de variable, en este caso el número de medallas y género. Nos sería dificultoso sacar conclusiones sobre el número de medallas de bronce, oro y plata obtenidos por género en un solo gráfico, o el número de medallas y número de ganadores por género todo en la misma torta."),
            #dbc.Button("Ver consulta", color="success"),
        ]
    ),
    className="mt-3",
)

tab4_content = dbc.Card(
    dbc.CardBody(
        [
            #se construye el contenido del tab, con el analisis a fondo y la grafica que se esta analizando
            html.H4("Análisis de la participacion de mujeres por año en los Juegos Olímpicos de Verano", className="card-text"),
            dcc.Graph(
                id='Graph 4',
                figure=gr.figTime
                ),
            html.P("Este tipo de gráfico es muy útil para el análisis de los cambios que ha tenido una variable con el paso de los años, así, nos permite ver el aumento de la cantidad de mujeres que han participado en los Juegos Olímpicos a lo largo del lapso de los años de los que se tienen registro en nuestra base de datos. Vemos que este crecimiento tuvo un cambio importante en el crecimiento, pues determina un punto de inflexión a partir del cual la participación crece mucho más rápido que anteriormente, llegando así a un máximo de participación de 6223 mujeres en los Juegos Olímpicos de Río en el 2016, mostrando un incremento de 6200 participaciones en comparación del primer año del que se tiene registro. Las limitaciones de este gráfico se ven si quisiésemos ver de forma más detallada la información acerca del cambio, como ver por país este incremento. Sin embargo, además de permitir una buena inclusión de los datos obtenidos de la consulta a la base de datos, es una buena aproximación para ver que en efecto las mujeres cada vez representan un mayor número dentro de los participantes de los Juegos Olímpicos."),
            #dbc.Button("Ver consulta", color="success"),
        ]
    ),
    className="mt-3",
)

tab5_content = dbc.Card(
    dbc.CardBody(
        [
            #se construye el contenido del tab, con el analisis a fondo y la grafica que se esta analizando
            html.H4("Análisis de Medallas de oro por estatura del atleta en Atletismo", className="card-text"),
            dcc.Graph(
                id='Graph 5',
                figure=gr.figHeight
                ),
            html.P("Una creencia muy generalizada en el mundo del atletismo es que la estatura es un factor muy importante en la velocidad de los atletas. Es gráfico proporciona los datos de las medallas de oro ganadas según la estatura de los atletas. En el se observa una distribución aproximadamente normalizada en la estatura de 183 cm, en la cual es donde se concentran la mayor cantidad de oros ganadas. El gráfico, además, utiliza una escala de colores para identificar de forma más visual la cantidad de medallas que representa cada barra. A pesar de que con este gráfico muestra una fuerte tendencia a que en el rango de 178 a 188 es donde se concentran la mayor cantidad de medallas, no se puede demostrar una relación causal solo con este, puesto que pueden existir otros factores, como que la mayoría de los atletas que compiten están en este rango de estatura. Una limitación particular de este gráfico es que la información que proporciona es bastante limitada dado que relaciona dos variables (en este caso, estatura y número de medallas), sin embargo, para este análisis específico es un gráfico apropiado."),
            #dbc.Button("Ver consulta", color="success"),
        ]
    ),
    className="mt-3",
)

tab6_content = dbc.Card(
    dbc.CardBody(
        [
            #se construye el contenido del tab, con el analisis a fondo y la grafica que se esta analizando
            html.H4("Análisis de Medallas de oro obtenidas por atleta en la historia de la delegación de USA", className="card-text"),
            dcc.Graph(
                id='Graph 6',
                figure=gr.figBarUSA
                ),
            html.P("Mediante el gráfico de barras verticales es posible visualizar la cantidad de medallas ganadas por los 20 mayores medallistas de la congregación de Estados Unidos, en donde es más que evidente que Michael Phelps es el mayor medallista de Estados Unidos ya que cuenta con 23 medallas en total, lo cual es más del doble de los atletas que le siguen son 12 medallas. El gráfico también cuenta con una clave de colores que permite una mayor distinción entre las diferentes cantidades. Mediante este diagrama se hace una clasificación de mayores a menores medallistas estadounidenses y es posible realizar una comparación entre estos. A partir de este diagrama, la congregación del país puede saber cuáles de sus atletas han ganado más en los distintos eventos olímpicos para darles más patrocinio. No obstante, a pesar de que el gráfico es bastante ilustrativo para el análisis propuesto, solo se realiza una relación entre el atleta y la cantidad de medallas que ha ganado sin hacer ninguna especie de distinción entre medallas de bronce, plata y oro, tampoco es posible visualizar otras características del atleta como lo es la estatura, peso o la cantidad de eventos olímpicos en los que ha participado, que podrían resultar ser factores que influencien la cantidad de medallas ganadas por un atleta."),
            #dbc.Button("Ver consulta", color="success"),
        ]
    ),
    className="mt-3",
)

tabs = dbc.Tabs(
    [
        #se crea cada uno de los tabs con el contenido correspondiente
        dbc.Tab(tab1_content, label="Análisis 1",style={'text-align':'justify'}),
        dbc.Tab(tab2_content, label="Análisis 2",style={'text-align':'justify'}),
        dbc.Tab(tab3_content, label="Análisis 3",style={'text-align':'justify'}),
        dbc.Tab(tab4_content, label="Análisis 4",style={'text-align':'justify'}),
        dbc.Tab(tab5_content, label="Análisis 5",style={'text-align':'justify'}),
        dbc.Tab(tab6_content, label="Análisis 6",style={'text-align':'justify'}),
    ],style={'backgroundColor':'lightgray','borderRadius':5}
)

app.layout = html.Div(children=[

    #Sección Header
    dbc.Navbar([
                    #html.Img(className="logo", src='data:image/png;base64,{}'.format(encoded_image.decode()), alt='logo'), #en caso de querer usar las imagenes de forma local
                    html.Img(className="logo", src='https://raw.githubusercontent.com/Feligx/Olympics-Database/main/Python-webapp/img/oly_logo.png', alt='logo'), #en caso de querer usar las imagenes de forma remota
                    html.Nav(children=[ #Barra de naegacion del sitio,
                        html.Ul(className="nav__links",children=[ #Items que representarán los botones de navegacion en el nav
                            html.Li(children=[
                                html.A(href="#Home",children=["Descripción"],className="header_a"),#link hacia el anclaje puesto en la seccion de Home
                            ]),
                            html.Li(children=[
                                html.A(href="#Analisis",children=["Análisis"],className="header_a"),#link hacia el anclaje puesto en la seccion del Analisis
                            ]),
                            html.Li(children=[
                                html.A(href="#Funcionamiento",children=["Funcionamiento"],className="header_a"),#link hacia el anclaje puesto en la seccion de Funcionamiento
                            ]),
                            html.Li(children=[
                                html.A(href="#DashBoard",children=["DashBoard"],className="header_a"),#link hacia el anclaje puesto en la seccion del dashboard
                            ]),
                        ])
                    ]),
                html.Button(children=[html.A(href="https://github.com/Feligx/Olympics-Database",children=[ #link hacia el repositorio del proyecto
                    #html.Img(className="git", src='data:image/svg+xml;base64,{}'.format(encoded_image2.decode()),alt='GitHub'), # si se quieren incluir las img localmente
                    html.Img(className="git", src='https://raw.githubusercontent.com/Feligx/Olympics-Database/e9a7d6832e7b3c2b7bc7ebebab238bce7ec4f2a1/Python-webapp/img/github.svg',alt='GitHub'), #si se quieren usar las img de forma remota

                ],className="header_a")]),
    ],sticky="top",color="currentColor"),
    #------------ Sección de Home

    html.Div(children=[
        html.A(id="Home"), #anclaje para ser llamado hacia esta seccion
        html.Div(children=[
            html.H3("Bases de Datos de los Juegos Olímpicos"),
            html.P("Los Juegos Olímpicos constituyen un evento cultural e internacional, en el que participan atletas de diferentes disciplinas deportivas representando a sus respectivas delegaciones nacionales, constituyendo el festival mundial del deporte. “Sus objetivos, en última instancia, son el desarrollo personal y la paz mundial a través del deporte” (Acerca de los juegos olímpicos, 2019). "),
            html.P("Para el proyecto final de Manejo de Bases de Datos 2021-1, de la carrera de  Matemáticas Aplicadas y Ciencias de la Computación, de la Facultad de Ingeniería Ciencia y Tecnología de la Universidad del Rosario, hemos implementado una base de datos para postgreSQL con información sobre los Juegos Olímpicos desde 1896 a 2016. A partir de ella, con la librería Dash de Python hemos generado las gráficas de análisis que se presentan a continuación, de las que podemos obtener conclusiones sobre la historia de los juegos, los atletas, las delegaciones, los eventos y los deportes",style={'text-align':'justify'})
            ],
            className="col-md-6",style={'text-align':'justify'}),
        html.Div(children=[
            #html.Img(src='data:image/png;base64,{}'.format(encoded_image4.decode()), alt='main_img',style={'width':400,'margin-left':'auto','margin-right':'auto'}), #si se quiere usar las img de forma local
            html.Img(src='https://raw.githubusercontent.com/Feligx/Olympics-Database/main/Python-webapp/img/main_img.png', alt='main_img',style={'width':400,'margin-left':'auto','margin-right':'auto'}), #si se quiere usar las img desde el repo de forma remota
        ],className="col-md-6",style={'text-align':'center'})
    ],style={'padding':50,'align-items': 'center'}, **{'data-aos':"fade-up",'data-aos-duration':"3000"},className="row"),

    #------------ Sección de intro al Análisis
    #Se analiza levemente los graficos, el analisis a fondo se deja para la seccion #dashboard
    html.Div(children=[
                html.A(id="Analisis"), #anclaje para ser llamado desde el nav hacia esta sección
                html.Div(children=[card],className="col-md-7",style={'margin-top':28}), #se usa el card generado anteriormente con el contenido puesto mediante el callback de más abajo
                html.Div(children=[ #analisis leve de los gráficos obtenidos a partir de los datos de la BDD
                    html.H3("Gráficas de Análisis",style={'marginTop':25}),
                    html.P("A partir de la información de la Base de Datos sobre los Juegos Olímpicos, generamos las siguientes gráficas con contenido histórico relevante."),
                    html.P("La primera gráfica, es un gráfico de barras que muestra en orden descendente, los mayores medallistas de oro en la historia de los juegos con su respectivo número de medallas de oro, a nivel mundial."),
                    html.P("La segunda gráfica, es un mapa de calor que muestra las medallas de oro por pais en la historia de los juegos."),
                    html.P("La tercera pestaña contiene un gráfico de torta que ofrece información sobre el número de medallas obtenidas por Colombianos, agrupadas por género del atleta."),
                    html.P("La gráfica en la cuarta posición, es un gráfico de líneas que muestra como ha sido la participación de las mujeres en las competencias con respecto al tiempo."),
                    html.P("El gráfico 5, corresponde a las medallas de oro por estatura del atleta de mayor a menor Atletismo."),
                    html.P("Finalmente, se muestra un gráfico sobre los mayores medallistas en la historia de Estados Unidos."),
                    html.P(children=["Puedes ver los análisis de forma más detallada",html.A(" Aquí",href="#DashBoard",style={'text-decoration':'none'})])
                    ],
                    className="col-md-5",style={'margin-top':25,'text-align':'justify'}),
    ],className="row",style={'padding':25}),

    #---------- Sección Funcionamiento
    #Descripcion sencilla de la composición de la BDD
    html.Div(children=[
                html.A(id="Funcionamiento"), #anclaje para ser llamado desde el nav hacia esta seccion
                html.Div(children=[
                    html.H3("¿Cómo es la base de datos?",style={'marginTop':25}),
                    html.P(children=["La base de datos de los Juegos Olímpicos, consta de 7 tablas principales"],className='list'),
                    html.Li("1.  Evento: Tiene toda la información sobre los eventos olímpicos entre 1986 y 2016.",className='list'),
                    html.Li("2.  Ciudad: Las ciudades donde se han celebrado los eventos olímpicos.",className='list'),
                    html.Li("3.  Deporte: Tiene todo sobre los deportes que se juegan en un evento.",className='list'),
                    html.Li("4.  Categoría: Todas las categorías de un deporte.",className='list'),
                    html.Li("5.  Atleta: La información sobre todos los atletas que han participado en un Evento Olímpico.",className='list'),
                    html.Li("6.  Región: Las regiones que participan en eventos Olímpicos.",className='list'),
                    html.Li("7.  Medalla: Los 3 tipos básicos de medallas que se pueden ganar.",className='list'),
                    html.P("Y también hay otras tablas secundarias y relacionales.",className='list'),
                    ],
                    className="col-md-5",style={'text-align':'justify'}),
                html.Div(children=[
                    #html.Img(src='data:image/png;base64,{}'.format(encoded_image6.decode()), alt='main_img',style={'width':700,'margin-left':'auto','margin-right':10}),
                    html.Img(src='https://raw.githubusercontent.com/Feligx/Olympics-Database/main/Python-webapp/img/OlympicsR.png', alt='main_img',style={'width':600,'margin-left':10,'margin-right':10}),
                    ],className="col-md-6",style={'text-align':'center'})
    ],className="row",style={'padding':50}),

    #--------- Sección de Dashboard
    html.Div(children=[
                html.A(id="DashBoard"), #ancla para poder haccer el target desde el nav. hacia esta seccion
                html.Div(className="col-md-1"),
                html.Div(children=[html.H3("Análisis detallado",style={'color':'white'}),
                    tabs
                ],className="col-md-10"),
    ],className="row",style={'padding':50,'backgroundColor':'currentColor'}),

    #----- Seccion del footer, no es targeteada por el nav, así que no requiere anclaje
    html.Div(children=[
        html.Div(children=[
            #html.Img(src='data:image/png;base64,{}'.format(encoded_image5.decode()), alt='main_img',style={'width':400,'margin-left':'auto','margin-right':'auto'}) #si se quiere usar la img de forma local
            html.Img(src='https://raw.githubusercontent.com/Feligx/Olympics-Database/main/Python-webapp/img/macc_ur_logo.png', alt='main_img',style={'width':400,'margin-left':'auto','margin-right':'auto'}) #si se quiere usar la img remotamente desde el repo
        ],className="col-md-4"),
        html.Div(className="col-md-4"),
        html.Div(children=[
        html.P(children=["Hecho por:",html.P(children=[" Rafael Cabrera, Luna Gutierrez,",html.P("Felipe Martinez y Ana Garzón")])],style={'color':'white','font-size':16,'font-weight':'700'})
        ],className="col-md-4")
    ],className="row",style={'padding':50,'backgroundColor':'currentColor'}),

])

#callback para colocar el contenido de los tabs en la seccion de Analisis, usando la funcion tab_content
@app.callback(
    Output("card-content", "children"), [Input("card-tabs", "active_tab")]
)
#función para generar el contenido de las tabs de la tarjeta en la seccion de Analisis
def tab_content(active_tab):
    #determina el contenido del tab según el id del mismo
    if active_tab == "tab-1":
        #return "This is tab {}".format(active_tab)
        render=dcc.Graph( #se usan los graficos generados en el archivo graphs.py con el id del grafico
            id='Graph 1',
            figure=gr.figBar
            )
        return render
    elif active_tab == "tab-2":
        render=dcc.Graph( #se usan los graficos generados en el archivo graphs.py con el id del grafico
            id='Graph 2',
            figure=gr.figMap
            )
        return render
    elif active_tab == "tab-3":
        render=dcc.Graph( #se usan los graficos generados en el archivo graphs.py con el id del grafico
            id='Graph 3',
            figure=gr.figPie
            )
        return render
    elif active_tab == "tab-4":
        render=dcc.Graph( #se usan los graficos generados en el archivo graphs.py con el id del grafico
            id='Graph 4',
            figure=gr.figTime
            )
        return render
    elif active_tab == "tab-5":
        render=dcc.Graph( #se usan los graficos generados en el archivo graphs.py con el id del grafico
            id='Graph 5',
            figure=gr.figHeight
            )
        return render
    elif active_tab == "tab-6":
        render=dcc.Graph( #se usan los graficos generados en el archivo graphs.py con el id del grafico
            id='Graph 6',
            figure=gr.figBarUSA
            )
        return render

if __name__ == '__main__':
    app.run_server(debug=True)

#shutdown_server()
