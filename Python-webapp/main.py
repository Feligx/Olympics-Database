import dash
import dash_core_components as dcc
import dash_html_components as html
import dash_bootstrap_components as dbc
from dash.dependencies import Input, Output
import plotly.express as px
import pandas as pd
from Connection import Connection
import SQLquerys as sql
import base64
import graphs as gr

external_stylesheets = ["https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"]

# Inicializacion app dash
app = dash.Dash(__name__, external_stylesheets=external_stylesheets)



#Creacion de las rutas de imagenes a usar
image_filename = 'img\oly_logo.png'
encoded_image = base64.b64encode(open(image_filename, 'rb').read())

image_filename2 = 'img\github.svg'
encoded_image2 = base64.b64encode(open(image_filename2, 'rb').read())


image_filename3 = 'img\macc_ur_logo.png'
encoded_image3 = base64.b64encode(open(image_filename3, 'rb').read())


image_filename4 = 'img\main_img.png'
encoded_image4 = base64.b64encode(open(image_filename4, 'rb').read())


image_filename5 = 'img\macc_ur_logo.png'
encoded_image5 = base64.b64encode(open(image_filename5, 'rb').read())

image_filename6 = 'img\OlympicsR.png'
encoded_image6 = base64.b64encode(open(image_filename6, 'rb').read())


# Layout

#Card con los gráficos sin análisis
card=dbc.Card([
    dbc.CardHeader(
    dbc.Tabs(
                    [
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
            html.H4("Análisis de medallas de oro obtenidas por atleta", className="card-text"),
            dcc.Graph(
                id='Graph 1',
                figure=gr.figBar
                ),
            html.P("A partir de la gráfica anterior podemos concluir que: "),
            html.P("Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"),
            #dbc.Button("Ver consulta", color="success"),
        ]
    ),
    className="mt-3",
)

tab2_content = dbc.Card(
    dbc.CardBody(
        [
            html.H4("Análisis de medallas de oro obtenidas por país en la historia de los juegos", className="card-text"),
            dcc.Graph(
                id='Graph 2',
                figure=gr.figMap
                ),
            html.P("El mapa de calor nos deja ver que: "),
            html.P("Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"),
            #dbc.Button("Ver consulta", color="success"),
        ]
    ),
    className="mt-3",
)

tab3_content = dbc.Card(
    dbc.CardBody(
        [
            html.H4("Análisis de porcentaje de medallas obtenidas por Colombianos agrupadas por género", className="card-text"),
            dcc.Graph(
                id='Graph 3',
                figure=gr.figPie
                ),
            html.P("El gráfico de torta nos permite concluir que: "),
            html.P("Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"),
            #dbc.Button("Ver consulta", color="success"),
        ]
    ),
    className="mt-3",
)

tab4_content = dbc.Card(
    dbc.CardBody(
        [
            html.H4("Análisis de la participacion de mujeres por año en los Juegos Olímpicos de Verano", className="card-text"),
            dcc.Graph(
                id='Graph 4',
                figure=gr.figTime
                ),
            html.P("La línea del gráfico nos permite observar que: "),
            html.P("Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"),
            #dbc.Button("Ver consulta", color="success"),
        ]
    ),
    className="mt-3",
)

tab5_content = dbc.Card(
    dbc.CardBody(
        [
            html.H4("Análisis de Medallas de oro por estatura del atleta en Atletismo", className="card-text"),
            dcc.Graph(
                id='Graph 5',
                figure=gr.figHeight
                ),
            html.P("El análisis que podemos hacer con base en la gráfica anterior es: "),
            html.P("Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"),
            #dbc.Button("Ver consulta", color="success"),
        ]
    ),
    className="mt-3",
)

tab6_content = dbc.Card(
    dbc.CardBody(
        [
            html.H4("Análisis de Medallas de oro obtenidas por atleta en la historia de la delegación de USA", className="card-text"),
            dcc.Graph(
                id='Graph 6',
                figure=gr.figBarUSA
                ),
            html.P("A partir de la gráfica anterior, concluimos que: "),
            html.P("Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"),
            #dbc.Button("Ver consulta", color="success"),
        ]
    ),
    className="mt-3",
)

tabs = dbc.Tabs(
    [
        dbc.Tab(tab1_content, label="Análisis 1"),
        dbc.Tab(tab2_content, label="Análisis 2"),
        dbc.Tab(tab3_content, label="Análisis 3"),
        dbc.Tab(tab4_content, label="Análisis 4"),
        dbc.Tab(tab5_content, label="Análisis 5"),
        dbc.Tab(tab6_content, label="Análisis 6"),
    ],style={'backgroundColor':'lightgray','borderRadius':5}
)

app.layout = html.Div(children=[

    #Sección Header
    dbc.Navbar([
                    html.Img(className="logo", src='data:image/png;base64,{}'.format(encoded_image.decode()), alt='logo'),
                    html.Nav(children=[
                        html.Ul(className="nav__links",children=[
                            html.Li(children=[
                                html.A(href="#Home",children=["Descripción"],className="header_a"),
                            ]),
                            html.Li(children=[
                                html.A(href="#Analisis",children=["Análisis"],className="header_a"),
                            ]),
                            html.Li(children=[
                                html.A(href="#Funcionamiento",children=["Funcionamiento"],className="header_a"),
                            ]),
                            html.Li(children=[
                                html.A(href="#DashBoard",children=["DashBoard"],className="header_a"),
                            ]),
                        ])
                    ]),
                html.Button(children=[html.A(href="https://github.com/Feligx/Olympics-Database",children=[
                    html.Img(className="git", src='data:image/svg+xml;base64,{}'.format(encoded_image2.decode()),alt='GitHub'),

                ],className="header_a")]),
    ],sticky="top",color="currentColor"),
    #------------ Sección de Home

    html.Div(children=[
        html.A(id="Home"),
        #html.P(children=["Proyecto Manejo de bases de datos 2021-S1"],style={'fontWeight':500,'fontSize':30,'margin':10,'marginBottom':20}),
        html.Div(children=[
            html.H3("Bases de Datos de los Juegos Olímpicos"),
            html.P("Los Juegos Olímpicos constituyen un evento cultural e internacional, en el que participan atletas de diferentes disciplinas deportivas representando a sus respectivas delegaciones nacionales, constituyendo el festival mundial del deporte. “Sus objetivos, en última instancia, son el desarrollo personal y la paz mundial a través del deporte” (Acerca de los juegos olímpicos, 2019). "),
            html.P("Para el proyecto final de Manejo de Bases de Datos 2021-1, de la carrera de  Matemáticas Aplicadas y Ciencias de la Computación, de la Facultad de Ingeniería Ciencia y Tecnología de la Universidad del Rosario, hemos implementado una base de datos para postgreSQL con información sobre los Juegos Olímpicos desde 1896 a 2016. A partir de ella, con la librería Dash de Python hemos generado las gráficas de análisis que se presentan a continuación, de las que podemos obtener conclusiones sobre la historia de los juegos, los atletas, las delegaciones, los eventos y los deportes",style={'text-align':'justify'})
            ],
            className="col-md-6"),
        html.Div(children=[
            html.Img(src='data:image/png;base64,{}'.format(encoded_image4.decode()), alt='main_img',style={'width':400,'margin-left':'auto','margin-right':'auto'}),
        ],className="col-md-6",style={'text-align':'center'})
    ],style={'padding':50,'align-items': 'center'}, **{'data-aos':"fade-up",'data-aos-duration':"3000"},className="row"),

    #------------ Sección de intro al Análisis
    html.Div(children=[
                html.A(id="Analisis"),
                html.Div(children=[card],className="col-md-7",style={'margin-top':28}),
                html.Div(children=[
                    html.H3("Gráficas de Análisis",style={'marginTop':25}),
                    html.P("A partir de la información de la Base de Datos sobre los Juegos Olímpicos, generamos las siguientes gráficas con contenido histórico relevante"),
                    html.P("La primera gráfica, es un gráfico de barras que muestra en orden descendente, los mayores medallistas de oro en la historia de los juegos con su respectivo número de medallas de oro, a nivel mundial"),
                    html.P("la segunda gráfica, es un mapa de calor que muestra las medallas de oro por pais en la historia de los juegos."),
                    html.P("La tercera es un gráfico de torta que ofrece información sobre el número de medallas obtenidas por Colombianos, agrupadas por género del atleta"),
                    html.P("la gráfica en la cuarta posición, es un gráfico de líneas que muestra como ha sido la participación de las mujeres en las competencias con respecto al tiempo"),
                    html.P("El gráfico 5, corresponde a las medallas de oro por estatura del atleta de mayor a menor Atletismo"),
                    html.P("Finalmente, se muestra un gráfico sobre los mayores medallistas en la historia de Estados Unidos"),
                    html.P(children=["Puedes ver los análisis de forma más detallada",html.A(" Aquí",href="#DashBoard",style={'text-decoration':'none'})])
                    ],
                    className="col-md-5",style={'margin-top':25}),
    ],className="row",style={'padding':25}),

    #---------- Sección Funcionamiento
    html.Div(children=[
                html.A(id="Funcionamiento"),
                html.Div(children=[
                    html.H3("¿Cómo es la base de datos?",style={'marginTop':25}),
                    html.P("La base de datos de los Juegos Olímpicos, consta de 7 tablas principales"),
                    html.P("1.  Evento: Tiene toda la información sobre los eventos olímpicos entre 1986 y 2016."),
                    html.P("2.  Ciudad: Las ciudades donde se han celebrado los eventos olímpicos."),
                    html.P("3.  Deporte: Tiene todo sobre los deportes que se juegan en un evento."),
                    html.P("4.  Categoría: Todas las categorías de un deporte."),
                    html.P("5.  Atleta: La información sobre todos los atletas que han participado en un Evento Olímpico."),
                    html.P("6.  Región: Las regiones que participan en eventos Olímpicos."),
                    html.P("7.  Medalla: Los 3 tipos básicos de medallas que se pueden ganar."),
                    html.P("Y también hay otras tablas secundarias y relacionales."),
                    ],
                    className="col-md-5"),
                html.Div(children=[
                    html.Img(src='data:image/png;base64,{}'.format(encoded_image6.decode()), alt='main_img',style={'width':700,'margin-left':'auto','margin-right':10}),
                    ],className="col-md-6",style={'text-align':'center'})
    ],className="row",style={'padding':50}),

    #--------- Sección de Dashboard
    html.Div(children=[
                html.A(id="DashBoard"),
                html.Div(className="col-md-1"),
                html.Div(children=[html.H3("Análisis detallado",style={'color':'white'}),
                    tabs
                ],className="col-md-10"),
    ],className="row",style={'padding':50,'backgroundColor':'currentColor'}),

    html.Div(children=[
        html.Div(children=[
            html.Img(src='data:image/png;base64,{}'.format(encoded_image5.decode()), alt='main_img',style={'width':400,'margin-left':'auto','margin-right':'auto'})
        ],className="col-md-4"),
        html.Div(className="col-md-4"),
        html.Div(children=[
        html.P(children=["Hecho por:",html.P(children=[" Rafael Cabrera, Luna Gutierrez,",html.P("Felipe Martinez y Ana Garzón")])],style={'color':'white','font-size':16,'font-weight':'700'})
        ],className="col-md-4")
    ],className="row",style={'padding':50,'backgroundColor':'currentColor'}),

])

@app.callback(
    Output("card-content", "children"), [Input("card-tabs", "active_tab")]
)
def tab_content(active_tab):
    if active_tab == "tab-1":
        #return "This is tab {}".format(active_tab)
        render=dcc.Graph(
            id='Graph 1',
            figure=gr.figBar
            )
        return render
    elif active_tab == "tab-2":
        render=dcc.Graph(
            id='Graph 2',
            figure=gr.figMap
            )
        return render
    elif active_tab == "tab-3":
        render=dcc.Graph(
            id='Graph 3',
            figure=gr.figPie
            )
        return render
    elif active_tab == "tab-4":
        render=dcc.Graph(
            id='Graph 4',
            figure=gr.figTime
            )
        return render
    elif active_tab == "tab-5":
        render=dcc.Graph(
            id='Graph 5',
            figure=gr.figHeight
            )
        return render
    elif active_tab == "tab-6":
        render=dcc.Graph(
            id='Graph 6',
            figure=gr.figBarUSA
            )
        return render

if __name__ == '__main__':
    app.run_server(debug=True)

#shutdown_server()
