#!/bin/bash

# Directorio de resultados
RESULTS_DIR="Results"

# Crea el directorio de resultados si no existe
mkdir -p $RESULTS_DIR

# Divide los usuarios en archivos individuales
split_users() {
    # Lee el archivo usuarios.yaml y procesa cada usuario
    awk -v dir="$RESULTS_DIR" '
    BEGIN {
        FS=": ";
        RS="- \\{"; # Registra la nueva separación de registros
        OFS=": ";
    }
    # Extrae y almacena cada usuario en un archivo separado
    {
        if (NR > 1) {
            user = substr($0, 1, length($0)-1); # Elimina la última coma
            split(user, lines, "\n");

            # Agrega la cabecera
            header = "aplicacion: Intranet Fake Data\nuser:\n";
            user_content = "";

            for (i in lines) {
                if (lines[i] ~ /_id|name|gender|company|email/) {
                    user_content = user_content "  " lines[i] "\n";
                    if (lines[i] ~ /name: /) {
                        split(lines[i], name_line, ": ");
                        name = name_line[2];
                    }
                }
            }

            # Escribe el archivo para el usuario
            filename = dir "/" name ".yaml";
            print header user_content > filename;
        }
    }' usuarios.yaml
}

# Buscar un usuario por nombre
search_user() {
    read -p "Introduce el nombre del usuario: " username
    user_file="${RESULTS_DIR}/${username}.yaml"
    if [ -f "$user_file" ]; then
        cat "$user_file"
    else
        echo "Usuario no encontrado"
    fi
}

# Ejecutar funciones
split_users
search_user