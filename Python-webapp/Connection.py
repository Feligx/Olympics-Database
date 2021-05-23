import psycopg2

#Se define la conexion con la base de datos, para luego ser llamada en el archivo graphs.py
class Connection:

    def __init__(self):
        self.connection = None

    def openConnection(self):
        try:
            self.connection = psycopg2.connect(user="postgres",
                                               password="1606",
                                               database="Proyecto",
                                               host="localhost",
                                               port="5432")
        except Exception as e:
            print (e)

    def closeConnection(self):
        self.connection.close()
