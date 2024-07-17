import os
import json

def create_results_directory():
    """Crea la carpeta Results si no existe."""
    if not os.path.exists('Results'):
        os.makedirs('Results')

def save_users_to_files(users):
    """Guarda cada usuario en un archivo JSON separado en la carpeta Results."""
    create_results_directory()
    for user in users:
        filename = f'Results/{user["name"]}.json'
        with open(filename, 'w') as f:
            json.dump(user, f, indent=4)

def load_json_file(filepath):
    """Carga un archivo JSON y devuelve el contenido."""
    with open(filepath, 'r') as f:
        return json.load(f)

def find_user_by_name(name):
    """Busca un usuario por nombre en la carpeta Results."""
    filepath = f'Results/{name}.json'
    if os.path.exists(filepath):
        return load_json_file(filepath)
    else:
        return None

def main():
    # Cargar los datos del archivo usuarios.json
    try:
        data = load_json_file('usuarios.json')
    except FileNotFoundError:
        print("El archivo usuarios.json no se encontró.")
        return
    except json.JSONDecodeError:
        print("Error al decodificar el archivo JSON.")
        return

    # Extraer los usuarios del JSON
    users = data.get("users", [])

    # Guardar los usuarios en archivos individuales
    save_users_to_files(users)

    # Solicitar el nombre del usuario
    user_input = input("Ingrese el nombre del usuario: ")
    user_data = find_user_by_name(user_input)

    if user_data:
        print(json.dumps(user_data, indent=4))
    else:
        print("Usuario no encontrado")

if __name__ == "__main__":
    main()