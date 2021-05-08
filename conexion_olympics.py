import psycopg2

try:
    conexion = psycopg2.connect( user="postgres",
                                 password="160902",
                                 database="olympics",
                                 host="localhost",
                                 port="5432")
    print("Conexion correcta")

    sql1 = """select * from athlete;"""
    sql2 = """select * from category;"""
    sql3 = """select * from city;"""
    sql4 = """select * from competes;"""
    sql5 = """select * from event;"""
    sql6 = """select * from event_city;"""
    sql7 = """select * from medal;"""
    sql8 = """select * from participates;"""
    sql9 = """select * from region;"""
    sql10 = """select * from represents;"""
    sql11 = """select * from sport;"""

    cursor = conexion.cursor()

#consulta athlete
    cursor.execute(sql1)
    athletes = cursor.fetchall()
    print("*** ATHLETES ***")
    for athlete in athletes:
        print("id = ", athlete[0])
        print("full_name = ", athlete[1], "\n")
        print("gender = ", athlete[2], "\n")
        print("height = ", athlete[3], "\n")
        print("weight = ", athlete[4], "\n")


#consulta category
    cursor.execute(sql2)
    categories = cursor.fetchall()
    print("*** CATEGORIES ***")
    for category in categories:
        print("id = ", category[0])
        print("id_sport = ", category[1], "\n")
        print("category_name = ", category[2], "\n")


#consulta city
    cursor.execute(sql3)
    cities = cursor.fetchall()
    print("*** CITIES ***")
    for city in cities:
        print("id = ", city[0])
        print("city_name = ", city[1], "\n")


#consulta competes
    cursor.execute(sql4)
    competes = cursor.fetchall()
    print("*** COMPETES ***")
    for compete in competes:
        print("id_category = ", compete[0])
        print("id_participates = ", compete[2])
        print("id_medal = ", compete[3], "\n")


#consulta event
    cursor.execute(sql5)
    regions = cursor.fetchall()
    print("*** REGIONES ***")
    for region in regions:
        print("CODE = ", region[0])
        print("NAME = ", region[1], "\n")


#consulta event_city
    cursor.execute(sql6)
    event_city = cursor.fetchall()
    print("*** EVENT_CITY ***")
    for host in event_city:
        print("id_event = ", host[0])
        print("id_city = ", host[1], "\n")


#consulta medal
    cursor.execute(sql7)
    medals = cursor.fetchall()
    print("*** MEDALS ***")
    for medal in medals:
        print("id = ", medal[0])
        print("medal_name = ", medal[1], "\n")

#consulta participates
    cursor.execute(sql8)
    participates = cursor.fetchall()
    print("*** PARTICIPATES ***")
    for participate in participates:
        print("id = ", participate[0])
        print("id_event = ", participate[1])
        print("id_athlete = ", participate[2])
        print("age = ", participate[3], "\n")

#consulta region
    cursor.execute(sql9)
    regions = cursor.fetchall()
    print("*** REGION ***")
    for region in regions:
        print("id = ", region[0])
        print("noc = ", region[1])
        print("region_name = ", region[2], "\n")

#consulta represents
    cursor.execute(sql10)
    represents = cursor.fetchall()
    print("*** REPRESENTS ***")
    for represent in represents:
        print("id_athlete = ", represent[0])
        print("id_region = ", represent[1], "\n")

#consulta sport
    cursor.execute(sql11)
    sports = cursor.fetchall()
    print("*** SPORTS ***")
    for sport in sports:
        print("id = ", sport[0])
        print("sport_name = ", sport[1], "\n")

except psycopg2.Error as e:
    print ("Error al consultar", e)
    conexion.rollback();
finally:
    cursor.close()
    conexion.close()
    print ("Conexion cerrada")
