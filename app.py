import mysql.connector

import mysql.connector

mydb = mysql.connector.connect(
    host="127.0.0.1",  # Conexión local
    user="appuser",    # Usuario creado en el Dockerfile
    password="",       # ¡Sin contraseña!  Inseguro para producción.
    database="testdb"  # Base de datos creada en el Dockerfile
)

# ... resto de tu código ...

cursor = mydb.cursor()

def crear_registro(nombre, edad):
    sql = "INSERT INTO usuarios (nombre, edad) VALUES (%s, %s)"
    val = (nombre, edad)
    cursor.execute(sql, val)
    mydb.commit()
    print(cursor.rowcount, "registro insertado.")

def leer_registros():
    cursor.execute("SELECT * FROM usuarios")
    resultados = cursor.fetchall()
    for resultado in resultados:
        print(resultado)

# ... funciones para actualizar y eliminar registros ...

if __name__ == "__main__":
    crear_registro("Juan", 30)
    leer_registros()
    mydb.close()