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


# Layout

#Card con los gráficos sin análisis
card=dbc.Card([
    dbc.CardHeader(
    dbc.Tabs(
                    [
                        dbc.Tab(label="Análisis 1", tab_id="tab-1",className="ctest"),
                        dbc.Tab(label="Análisis 2", tab_id="tab-2",className="ctest"),
                        dbc.Tab(label="Análisis 3", tab_id="tab-3",className="ctest"),
                        dbc.Tab(label="Análisis 4", tab_id="tab-4",className="ctest"),
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
            html.H4("Medallas de oro obtenidas por atleta", className="card-text"),
            dcc.Graph(
                id='Graph 1',
                figure=gr.figBar
                ),
            html.P("Insertar análisis aquí: "),
            html.P("Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"),
            #dbc.Button("Ver consulta", color="success"),
        ]
    ),
    className="mt-3",
)

tab2_content = dbc.Card(
    dbc.CardBody(
        [
            html.P("This is tab 2!", className="card-text"),
            #dbc.Button("Don't click here", color="danger"),
        ]
    ),
    className="mt-3",
)
tabs = dbc.Tabs(
    [
        dbc.Tab(tab1_content, label="Tab 1"),
        dbc.Tab(tab2_content, label="Tab 2"),
        dbc.Tab(
            "This tab's content is never seen", label="Tab 3", disabled=True
        ),
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
            html.P("Implementamos una base de datos para postgreSQL con información de los eventos olímpicos de 1896 a 2016.",style={'text-align':'justify'})
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
                    html.H3("Análisis",style={'marginTop':25}),
                    html.P("Se hizo un análisis con datos de los juegos olímpicos de 1986 a 2016, usando la implementación que realizamos de la base, para poder consultarla y analizarla"),
                    html.P(children=["Puedes ver los análisis de forma más detallada",html.A(" Aquí",href="#DashBoard",style={'text-decoration':'none'})])
                    ],
                    className="col-md-5",style={'margin-top':25}),
    ],className="row",style={'padding':25}),

    #---------- Sección Funcionamiento
    html.Div(children=[
                html.A(id="Funcionamiento"),
                html.Div(children=[
                    html.H3("Cómo funciona",style={'marginTop':25}),
                    html.P("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum")
                    ],
                    className="col-md-5"),
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
            id='Graph 1',
            figure=gr.figBar
            )
        return render
    elif active_tab == "tab-4":
        render=dcc.Graph(
            id='Graph 4',
            figure=gr.figTime
            )
        return render

if __name__ == '__main__':
    app.run_server(debug=True)

shutdown_server()
