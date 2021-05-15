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
con = Connection()
con.openConnection()
query = pd.read_sql_query(sql.sql1(), con.connection)
con.closeConnection()
Medals = pd.DataFrame(query)

# Creacion de gráficos
figBar = px.bar(Medals.head(20), y="count", x="full_name",color="id")
