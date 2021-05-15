#----------Medallas de oro por atleta de mayor a menor

def sql1():
    query= "SELECT a.id, a.full_name, COUNT(*) FROM athlete a INNER JOIN participates p ON a.id = p.id_athlete INNER JOIN competes c ON p.id = c.id_participates INNER JOIN medal m ON c.id_medal = m.id WHERE medal_name IN ('Gold') GROUP BY a.id, a.full_name ORDER BY COUNT(*) DESC;"
    return query
