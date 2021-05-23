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
#ver las notas del main.py bajo los imports para entender estos tambien


#------- Construccion de las gráficas segun las consultas que se encuentran en el SQLquerys.py

# Consulta 1
# Medallas de oro por atleta de mayor a menor
con = Connection()
con.openConnection()
query = pd.read_sql_query(sql.sql1(), con.connection)
con.closeConnection()
Medals = pd.DataFrame(query)
figBar = px.bar(Medals.head(20), y="total_de_medallas", x="atleta",color="total_de_medallas", title = "Medallas de oro por atleta de mayor a menor")


# Consulta 2
# Medallas de oro por pais de mayor a menor
con = Connection()
con.openConnection()
q2 = pd.read_sql_query(sql.sql2(), con.connection)
con.closeConnection()
MedalsC = pd.DataFrame(q2)
figMap = px.choropleth(MedalsC, locations= "region_name",
                                locationmode = "country names",
                                color = "total_medallas",
                                hover_name = "region_name",
                                color_continuous_scale = "Bluyl",
                                title = "Medallas de oro por pais de mayor a menor")

#Consulta 3
##Número de medallas obtenidas por Colombianos agrupadas por género
con = Connection()
con.openConnection()
q3 = pd.read_sql_query(sql.sql3(), con.connection)
con.closeConnection()
MedalsCol = pd.DataFrame(q3)
figPie = px.pie(MedalsCol.head(25), values="numero_medallas", names="genero", title="Número de medallas obtenidas por Colombianos agrupadas por género")

# Consulta 4
# Participacion de mujeres por año de mayor a menor (verano)
con = Connection()
con.openConnection()
q4 = pd.read_sql_query(sql.sql4(), con.connection)
con.closeConnection()
Mujeres = pd.DataFrame(q4)
figTime = px.line(Mujeres, x="año", y="participacion", title='Participación de mujeres en los juegos olímpicos de verano')

#Consulta 5
#Medallas de oro por estatura del atleta de mayor a menor Atletismo
con = Connection()
con.openConnection()
q5 = pd.read_sql_query(sql.sql5(), con.connection)
con.closeConnection()
estatura = pd.DataFrame(q5)
figHeight = px.bar(estatura.head(25), x="medallas_oro", y="altura", orientation = 'h', title = "Medallas de oro por estatura del atleta de mayor a menor Atletismo", color="altura")

# Consulta 6
# Medallas de oro por atleta de mayor a menor
con = Connection()
con.openConnection()
q6 = pd.read_sql_query(sql.sql6(), con.connection)
con.closeConnection()
Medals = pd.DataFrame(q6)
figBarUSA = px.bar(Medals.head(20), y="total_medallas", x="atleta",color="total_medallas", title = "Mayores medallistas de USA")
