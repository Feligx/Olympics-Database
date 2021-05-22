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

# Consulta 1
# Medallas de oro por atleta de mayor a menor
con = Connection()
con.openConnection()
query = pd.read_sql_query(sql.sql1(), con.connection)
con.closeConnection()
Medals = pd.DataFrame(query)


# Creacion de gráficos
figBar = px.bar(Medals.head(20), y="count", x="full_name",color="count")


# Consulta 2
# Medallas de oro por pais de mayor a menor
con = Connection()
con.openConnection()
q2 = pd.read_sql_query(sql.sql2(), con.connection)
con.closeConnection()
MedalsC = pd.DataFrame(q2)
figMap = px.choropleth(MedalsC, locations= "region_name",
                                locationmode = "country names",
                                color = "count",
                                hover_name = "region_name",
                                color_continuous_scale = "Bluyl")

# Consulta 4
# Participacion de mujeres por año de mayor a menor (verano)
con = Connection()
con.openConnection()
q4 = pd.read_sql_query(sql.sql4(), con.connection)
con.closeConnection()
Mujeres = pd.DataFrame(q4)
figTime = px.line(Mujeres, x="year", y="count", title='Participación de mujeres en los juegos olímpicos de verano')
