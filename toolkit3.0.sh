#!/bin/bash
clear

guardarRuta(){
    echo "======================="
    read -p "Ingrese una ruta a guardar: " ruta
    while [ ! -e "$ruta" ] || [ -z "$ruta" ]; do
        echo "La ruta ingresada no existe."
        read -p "Por favor, ingrese una ruta válida: " ruta	
    done	
    rutaGuard="$ruta"
    echo "Ruta guardada correctamente."
    echo "IMPORTANTE:"
    echo "Esta será la ruta predeterminada para el resto de las operaciones en esta terminal."
    echo "Si desea usar otra ruta, seleccione nuevamente la opción 7."
    echo "Nota: Las rutas relativas se tomarán desde donde se ejecuta el script."
    echo "======================="
}

urlTxt(){
    echo "======================="
    read -p "Ingrese la URL a guardar: " url
    ruta=$rutaGuard
    if [ ! -e "$ruta" ]; then	
        read -p "La ruta predeterminada no es válida. Ingrese otra ruta: " ruta
        while [ ! -e "$ruta" ] || [ -z "$ruta" ]; do
            echo "La ruta ingresada no existe."
            read -p "Ingrese una ruta válida (o escriba 0 para cancelar): " ruta
            [ "$ruta" == "0" ] && return 1
        done
    fi
    echo "$url" >> "${ruta}/paginaweb.txt" 
    echo "La URL se ha guardado correctamente en ${ruta}/paginaweb.txt."
    echo "======================="
}

reporteSist(){
    echo "======================="
    echo "Usuario actual: $(whoami)"
    echo "Fecha y hora actual: $(date "+%H:%M %A %d/%m/%Y")"
    echo "Último inicio de sesión: $(who | tr -s ' ' | cut -d' ' -f3,4)"
    echo "======================="
}

buscadorPalabra(){
    echo "======================="
    carpBusq=$rutaGuard
    if [ ! -e "$carpBusq" ]; then
        read -p "Ingrese la ruta de la carpeta para buscar: " carpBusq
        while [ ! -e "$carpBusq" ] || [ -z "$carpBusq" ]; do
            echo "La ruta ingresada no existe."
            read -p "Ingrese una ruta válida (o escriba 0 para cancelar): " carpBusq
            [ "$carpBusq" == "0" ] && return 1
        done
    fi
    read -p "Ingrese una palabra para buscar: " palabra
    resultados=$(grep -rnw "$carpBusq" -e "$palabra" 2>/dev/null)
    if [ -z "$resultados" ]; then
        echo "No se encontraron coincidencias para '$palabra' en '$carpBusq'."
    else
        echo "$resultados"
    fi
    echo "======================="
}

discoDuroEst(){
    echo "======================="
    disco="/mnt/c"
    if df -h "$disco" &>/dev/null; then
        espLibre=$(df -h "$disco" | tail -n 1 | tr -s ' ' | cut -d" " -f4)
        espOcupado=$(df -h "$disco" | tail -n 1 | tr -s ' ' | cut -d" " -f3)
        if ls "$disco" &>/dev/null; then
            masGrande=$(ls -S "$disco" | head -n 1)
        else
            masGrande="No se pudo acceder al directorio para listar archivos."
        fi
        echo "Espacio libre: $espLibre"
        echo "Espacio ocupado: $espOcupado"
        echo "Archivo más grande: $masGrande"
    else
        echo "No se pudo acceder al disco '$disco'."
        echo "Esto puede deberse a que no está montado o a permisos insuficientes."
    fi
    echo "======================="
}

renomBck(){
    echo "======================="
    carpRenom=$rutaGuard
    if [ ! -e "$carpRenom" ]; then
        read -p "Ingrese la ruta de la carpeta a renombrar: " carpRenom
        while [ ! -e "$carpRenom" ] || [ -z "$carpRenom" ]; do
            echo "La ruta ingresada no existe."
            read -p "Ingrese una ruta válida (o escriba 0 para cancelar): " carpRenom
            [ "$carpRenom" == "0" ] && return 1
        done
    fi
    for i in "$carpRenom"/*; do
        mv "$i" "${i}bck"
        echo "Renombrado: $i -> ${i}bck"
    done
    echo "======================="
}

propCarpeta(){	
    echo "======================="
    carpProp=$rutaGuard
    if [ ! -e "$carpProp" ]; then
        read -p "Ingrese la ruta de la carpeta: " carpProp
        while [ ! -e "$carpProp" ] || [ -z "$carpProp" ]; do
            echo "La ruta ingresada no existe."
            read -p "Ingrese una ruta válida (o escriba 0 para cancelar): " carpProp
            [ "$carpProp" == "0" ] && return 1
        done
    fi
    cantArchivos=$(find "$carpProp" -maxdepth 1 -type f | wc -l)
    cantSubCarp=$(find "$carpProp" -mindepth 1 -type d | wc -l)
    if [ "$cantSubCarp" -eq 0 ]; then
        echo "No hay subdirectorios dentro de '$carpProp'."
    else
        echo "Cantidad de subdirectorios: $cantSubCarp"
    fi
    echo "Cantidad de archivos: $cantArchivos"
    archivosTot=$(ls -S "$carpProp" 2>/dev/null)
    masPesado=$(echo "$archivosTot" | head -n 1)
    menosPesado=$(echo "$archivosTot" | tail -n 1)
    echo "Archivo más pesado: $masPesado"
    echo "Archivo menos pesado: $menosPesado"
    echo "======================="
}

# Menú principal
while true ; do
    echo "======================="
    echo "          MENÚ         "
    echo "======================="
    echo "1) Propiedades de una carpeta"
    echo "2) Agregar sufijo 'bck' a archivos"
    echo "3) Estado del disco duro"
    echo "4) Buscador de palabras en archivos"
    echo "5) Reporte del sistema"
    echo "6) Guardar URL en archivo .txt"
    echo "7) Definir ruta predeterminada"
    echo "0) Salir"
    echo "======================="
    read -p "Seleccione una opción: " opcion

    case $opcion in
        0)
            echo "======================="
            echo "Gracias por utilizar el programa. ¡Hasta luego!"
            echo "======================="
            break
            ;;
        1) propCarpeta ;;
        2) renomBck ;;
        3) discoDuroEst ;;
        4) buscadorPalabra ;;
        5) reporteSist ;;
        6) urlTxt ;;
        7) guardarRuta ;;
        *) echo "Opción inválida. Intente nuevamente." ;;
    esac
done
