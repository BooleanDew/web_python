
FROM ubuntu:latest

# Actualizar y actualizar los paquetes
RUN apt-get update && apt-get upgrade -y

# Instalar MySQL Server y cliente
RUN apt-get install -y mysql-server mysql-client

# Instalar Python y pip
RUN apt-get install -y python3 python3-pip

# Crear el directorio de la aplicación
RUN mkdir -p /app
WORKDIR /app

# Copiar el archivo requirements.txt
COPY requirements.txt ./

# Instalar las dependencias de Python
RUN pip3 install -r requirements.txt

# Copiar el código de la aplicación
COPY . .

# Configurar MySQL (¡EXTREMADAMENTE INSEGURO PARA PRODUCCIÓN!)
RUN mysql_secure_installation --skip-name-prompt --skip-password --skip-networking

# Crear un usuario y base de datos (¡EXTREMADAMENTE INSEGURO PARA PRODUCCIÓN!)
RUN mysql -e "CREATE USER 'appuser'@'localhost' IDENTIFIED BY ''; CREATE DATABASE testdb; GRANT ALL PRIVILEGES ON testdb.* TO 'appuser'@'localhost'; FLUSH PRIVILEGES;"

# Exponer el puerto 3306
EXPOSE 3306

# Iniciar MySQL y la aplicación
CMD ["sh", "-c", "service mysql start && python3 app.py"]