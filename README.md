# Olympics Database
This is a database with olympic games data from 1896 to 2016, structured for postgresql with all the archives related to building and management the database.

**Note:** Despite this description and some info on the database is in english, the commentaries on the code are on spanish, and also if you want to see the proyect description (this file) on spanish go [here](https://github.com/Feligx/Olympics-Database/blob/main/README_%5BES%5D.md).

### | Building the DDL of the database

First, we made the E-R diagram in order to get a first sketch on how to make the database and the possibles analysis of it.

![E-R Diagram](https://github.com/Feligx/Olympics-Database/blob/main/Diagrams/Modelo_Base_de_Datos_Olimpicos_3.png)
> Entity-Relationship diagram of the database
 
 Then, with that, it was possible to start thinking on how the tables of the database will work, with all the constraints around it and searching the Third-Normal Form (3NF) to get a good database structure, preventing issues with it in future. So, we made the Relational diagram in [pgModeler](https://pgmodeler.io), and this is what we got:
 
 ![Relational Diagram](https://github.com/Feligx/Olympics-Database/blob/main/Diagrams/OlympicsR.png)
 >Relational diagram of the database in 3NF
 
 With that we had a complete DDL guide for the database, so the next step was writing (with help of [pgModeler](https://pgmodeler.io)) the SQL code to build the DDL of our database, and [this](https://github.com/Feligx/Olympics-Database/blob/main/relational_olympics.sql) is what it ended up like.
 
 It consists of 7 main tables:
 * `Event:` It has all the info about the Olympic Events between 1986 and 2016.
 * `City:` The cities where the Olympic Events are hosted.
 * `Sport:` It has all about the sports played on a Event.
 * `Category:` All the categories in a Sport.
 * `Athlete:` The info about all the athletes that have participated on a Olympic Event.
 * `Region:` The Regions that participate on Olympic events.
 * `Medal:` The basic 3 types of medals to be won.

Some Examples can be seen [here](https://github.com/Feligx/Olympics-Database/blob/main/tab_examples.md)

And there are also another secondary and relational tables.

### | Loading all the data and building python modules to query them

Now with all the DDL done, we started to load all [data](https://github.com/Feligx/Olympics-Database/tree/main/Data) on the database, and making the [SQL code](https://github.com/Feligx/Olympics-Database/blob/main/remaining_inserts.sql) to do it using COPY for all the data in the csv archives. 
The information load to the database was a [transparent process](https://github.com/Feligx/Olympics-Database/blob/main/Data/upload_data_csv). No changes were made to the original files and no problems occurred during any of the phases.


And then, having the database with the resective data on it, we made the python module to make the connection to the database and get the data from it to analyse it, you can se the module [here](https://github.com/Feligx/Olympics-Database/blob/main/conexion_olympics.py).

Finally, we need to do some analysis using the data on tha database, using the python packages `Pandas` and `Dash`.

### | Building the Web App on python

With the DataBase-Python connection ready to work, we can start building the web app where we are going to include the graphs and their respective analysis.

In this way, we created the [Python-webapp](https://github.com/Feligx/Olympics-Database/tree/main/Python-webapp) folder that'll contain all the files about the app, and started by creating the [Connection](https://github.com/Feligx/Olympics-Database/blob/main/Python-webapp/Connection.py) an [SQLquerys](https://github.com/Feligx/Olympics-Database/blob/main/Python-webapp/SQLquerys.py) files where we'll setup the connection to the database and create the querys we want to call them later, respectively. Using that, we created the [Graphs](https://github.com/Feligx/Olympics-Database/blob/main/Python-webapp/graphs.py) file where we make all the graphs using dash around the data obtained from the querys in order to import them later on the web app.

> **Note:** here you have to install the dash-bootstrap-components additional to the `Dash` main components, use:
```
pip install dash-bootstrap-components
```

Finally, we made the "[main](https://github.com/Feligx/Olympics-Database/blob/main/Python-webapp/main.py)" file where all the structure of the web app rest, here we used the `Dash` components like `dash-core-components`, `dash-html-components`, `dash-bootstrap-components` and also `Plotly` and `Pandas` for making it possible. Here we imported the graphs created by the previous mentioned file to put them into cards with tabs to analyse them. The file has a little description for some things that need explanation.

On the web app there is a summarized version of this file describing the project, and other thing to take into account, is that we use `base64` library to encode local images and using them into the web app because `Dash` don't allow this, but we still let that part up to the user, is possible also to use them leaving in the "src" attribute of the `<img>` tag as a url to the images on this repo (as we did! leaving the other part hidden as comments).


Hope you find usefull this "little" description of our database proyect and how it works!

### | **List of errors and bugs we found during the process and still exist on the files:** 
* None :)
