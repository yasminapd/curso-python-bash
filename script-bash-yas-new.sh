#!/bin/bash

# Verificar si se ha proporcionado un parámetro
if [ -z "$1" ]; then
	echo "Debe proporcionar una palabra como parámetro."
	exit 1
fi

# Imprimir la palabra del parámetro
echo "La palabra proporcionada es: $1"

# Obtener el usuario que ha ejecutado el script
usuario=$(whoami)

# Verificar si el usuario es root
if [ "$usuario" != "root" ]; then
	echo "Este script debe ser ejecutado por el usuario root."
	exit 1
fi

# Si el script llega aquí, significa que el usuario es root
echo "El script ha sido ejecutado por el usuario root."
