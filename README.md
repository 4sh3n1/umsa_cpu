
# UMSA CPU DATA LEAK

Cualquier estudiante puede obtener información de cualquier otro estudiante de la UMSA desde el portal CPU del SIA

Incluyendo:
- Nombre Completo (Nombre y Apellidos)
- Cédula de identidad
- Registro único universitario
- Modalidad de ingreso
- Carrera o Carreras actuales
- Facultad a la que pertenece
- Estado actual, etc.

La vulnerabilidad aún no ha sido corregida.

Se puede descargar la información de los aproximadamente **441000** registros de estudiantes de la Universidad Mayor de San Andrés (560 MB)

Responsabilidad de los programadores incompetentes contratados por el Rector de la UMSA 2024

# Ejecución utilizando una Terminal de Linux

Copiar .env.prod to .env

```sh
cp .env.prod .env
```

Llenar el archivo .env con las credenciales de estudiante regular


# ACTUALIZACION MARZO 2024

Introdujeron un hot fix al sistema inhabilitado la descarga completa de la información 

Aun es posible descargar de forma especifica solo con CI, herramienta actualizada e implementación con docker

Un usuario anónimo nos envió la información en raw disponible en [RAW](https://mega.nz/file/068kBZTY#14td5BsG2mUg9uDLnUIreUvsabPd1orwd9vgiqm3Ffg)

Ejecutar el siguiente script en la terminal remplazando `[CI]` por el CI a buscar

```sh
chmod +x app.sh
./app.sh [CI]
```

Con Docker y compose remplazar en el archivo docker-compose.yaml el CI a buscar

```sh
docker compose build
docker compose run
```

Solo Docker remplazar en el comando el `[CI]` por el CI a buscar
```sh
docker build . -t mi_image
docker run --env-file .env -v ./download:/app/download mi_image /bin/bash /app/app.sh [CI]
```

---

# UMSA CPU DATA LEAK

Any student can access information about any other UMSA student through the CPU portal of the SIA

This includes:
- Full name (First name and Last name)
- Identity card
- Unique university ID
- Admission mode
- Current program or programs
- Faculty affiliation
- Current status, etc.

The vulnerability has not yet been fixed.

Information on approximately **441000** students of the Universidad Mayor de San Andrés can be downloaded (560 MB), 

Responsibility lies with the incompetent programmers hired by the UMSA Rector in 2024

# Execution using Linux Terminal

Copy .env.prod to .env

```sh
cp .env.prod .env
```

Fill the .env file with the student credentials

Execute the following script in the terminal


# UPDATE MARCH 2024

They introduced a hot fix to the system disabling the complete download of information.

It is still possible to download specific information only with CI, updated tools, and implementation with Docker.

An anonymous user sent us the information in raw format, available at:[RAW](https://mega.nz/file/068kBZTY#14td5BsG2mUg9uDLnUIreUvsabPd1orwd9vgiqm3Ffg)

To execute the following script in the terminal, replacing `[CI]` with the CI to search

```sh
chmod +x app.sh
./app.sh [CI]
```

With Docker and Compose replace in the docker-compose.yaml the `[CI]` with the CI to search

```sh
docker compose build
docker compose run
```

Only with Docker replace in the command the `[CI]` with the CI to search
```sh
docker build . -t mi_image
docker run --env-file .env -v ./download:/app/download mi_image /bin/bash /app/app.sh [CI]
```
