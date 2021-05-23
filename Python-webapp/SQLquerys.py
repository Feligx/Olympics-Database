#Querys que se realizarán a la base de datos construida para realizar analisis a partir de los datos resultantes de la consulta

#----------Medallas de oro por atleta de mayor a menor

# Medallas de oro por atleta de mayor a menor
def sql1():
    q1 = """SELECT a.id, a.full_name as atleta, COUNT(*) as total_de_medallas
        FROM athlete a
        INNER JOIN participates p ON a.id = p.id_athlete
        INNER JOIN competes c ON p.id = c.id_participates
        INNER JOIN medal m ON c.id_medal = m.id
        WHERE medal_name IN ('Gold')
        GROUP BY a.id, a.full_name
        ORDER BY COUNT(*) DESC;"""
    return q1

# Medallas de oro por pais de mayor a menor
def sql2():
    q2 = """SELECT noc.region_name, COUNT(*) as total_medallas
        FROM region noc INNER JOIN represents r ON noc.id = r.id_region
        INNER JOIN athlete a ON r.id_athlete = a.id
        INNER JOIN participates p ON a.id = p.id_athlete
        INNER JOIN competes c ON p.id = c.id_participates
        INNER JOIN medal m ON c.id_medal = m.id
        WHERE medal_name IN ('Gold')
        GROUP BY noc.region_name
        ORDER BY COUNT(*) DESC;"""
    return q2

#Número de medallas obtenidas por Colombianos agrupadas por género del atleta
def sql3():
    q3 = """SELECT count(medal.id) as numero_medallas, gender as genero
            FROM region, represents, participates, competes, athlete, medal
            WHERE region.id = represents.id_region
                AND competes.id_participates = participates.id
                AND athlete.id = participates.id_athlete
                AND athlete.id = represents.id_athlete
                AND region_name = 'Colombia'
                AND medal.id = competes.id_medal
                AND medal.id != 4
                GROUP BY gender;"""
    return q3

# Participacion de mujeres por año en verano de mayor a menor
def sql4():
    q4 = """SELECT e.year as año, COUNT(a.id) as participacion
        FROM athlete a
        INNER JOIN participates p ON a.id = p.id_athlete
        INNER JOIN competes c ON p.id = c.id_participates
        INNER JOIN event e on e.id = p.id_event
        WHERE a.gender = 'F' and e.season = 'Summer'
        GROUP BY e.year
        ORDER BY year ASC;"""
    return q4

#Medallas de oro por estatura del atleta de mayor a menor Atletismo
def sql5():
    q5 = """SELECT s.sport_name, a.height as altura, COUNT(*) as medallas_oro
           FROM athlete a
           INNER JOIN participates p ON a.id = p.id_athlete
           INNER JOIN competes c ON p.id = c.id_participates
           INNER JOIN medal m ON c.id_medal = m.id
           INNER JOIN category ct ON ct.id = c.id_category
           INNER JOIN sport s ON s.id = ct.id_sport
           WHERE medal_name IN ('Gold') and sport_name = 'Athletics' and a.height != 0
           GROUP BY a.height, s.sport_name
           ORDER BY COUNT(*) DESC;"""
    return q5

# Mayores medallistas de USA
def sql6():
    q6 = """SELECT a.full_name as atleta, COUNT(*) as total_medallas
        FROM region noc INNER JOIN represents r ON noc.id = r.id_region
        INNER JOIN athlete a ON r.id_athlete = a.id
        INNER JOIN participates p ON a.id = p.id_athlete
        INNER JOIN competes c ON p.id = c.id_participates
        INNER JOIN medal m ON c.id_medal = m.id
        WHERE medal_name IN ('Gold','Silver', 'Bronze') AND noc.region_name = 'USA'
        GROUP BY a.full_name
        ORDER BY COUNT(*) DESC;"""
    return q6
