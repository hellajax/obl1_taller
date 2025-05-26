#!/bin/bash

guardarRuta(){
	echo "======================="
	read -p "Ingrese una ruta a guardar: " ruta
	rutaGuard="$ruta"
	while [ ! -e "$ruta" ] || [ -z "$ruta" ]; do
		echo no existe la ruta
		read -p "ingrese ruta valida: " ruta	
	done	
	echo se ha guardado correctamennte	
	echo ¡¡¡IMPORTANTE!!!
	echo Esta sera su ruta para el resto de operaciones de esta terminal
	echo Si desea usar otra, seleccione la opcion 7 de vuelta
	echo "======================="
}	

urlTxt(){
	echo "======================="
	read -p "ingrese su url: " url
	ruta=$rutaGuard
	if [ ! -e "$ruta" ];then	
		read -p "Ingrese ruta: " rutA	
		ruta=$rutA
		while [ ! -e "$ruta" ] || [ -z "$ruta" ]; do
                echo no existe la ruta
		read -p "ingrese ruta valida (o un 0 para salir): " ruta
        	if [ "$ruta" -eq 0 ]; then
                        return 1
                fi
		done
	fi
	echo "$url" >> "${ruta}/paginaweb.txt" 
	echo se guardo correctamente su url
	echo "======================="
}

reporteSist(){
	echo "======================="
	echo "el usuario actual es: "$(who | tr -s ' ' | cut -d' ' -f1)""
	echo " "
	echo "la hora actual es: "$(date "+%H:%M %a %d/%m/%Y")""
	echo " "
	echo "el ultimo inicio: "$(who | tr -s ' ' | cut -d' ' -f 3,4)""
	echo "======================="
}


buscadorPalabra(){
	echo "======================="
	carpBusq=$rutaGuard
        if [ ! -e "$carpBusq" ];then
                read -p "Ingrese ruta de carpeta: " rutA
                carpBusq=$rutA
		while [ ! -e "$carpBusq" ] || [ -z "$carpBusq" ]; do
                echo no existe la ruta
		read -p "ingrese ruta valida (o un 0 para salir): " carpBusq
		if [ "$carpBusq" -eq 0 ]; then
                        return 1
                fi
        	done
        fi
	read -p "Ingrese una palabra para buscar: " palabra
	
	grep --color -rnwH "$palabra" "$carpBusq"
	echo "======================="
}





discoDuroEst(){
	  echo "======================="
	  espLibre=$(df -h /mnt/c | tail -n 1 | tr -s ' ' | cut -d" " -f4)
	  espOcupado=$(df -h /mnt/c | tail -n 1 | tr -s ' ' | cut -d" " -f3)
	  masGrande=$(ls -S /mnt/c | head -n 1)
	  echo "el espacio libre es $espLibre"
	  echo "el espacio ocupado es $espOcupado"
	  echo "el archivo mas grande del disco es $masGrande"
	  echo "======================="
}



renomBck(){
	echo "======================="
	carpRenom=$rutaGuard
        if [ ! -e "$carpRenom" ];then
                read -p "Ingrese ruta de la carpeta: " rutA
                carpRenom=$rutA
		while [ ! -e "$carpRenom" ] || [ -z "$carpRenom" ]; do
                echo no existe la ruta
		read -p "ingrese ruta valida (o un 0 para salir): " carpRenom
        	if [ "$carpRenom" -eq 0 ]; then
                        return 1
                fi
	
		done
        fi
	for i in "$carpRenom"/*; do
		mv "$i" "${i}bck"
		echo "renombre "$i" -> "${i}bck""
	done
	echo "======================="
}



propCarpeta(){	
	carpProp=$rutaGuard
        echo "======================="
	if [ ! -e "$carpProp" ];then
                read -p "Ingrese ruta de la carpeta: " rutA
                carpProp=$rutA
		while [ ! -e "$carpProp" ] || [ -z "$carpProp" ] ; do
                echo no existe la ruta
		read -p "ingrese ruta valida (o un 0 para salir): " carpProp
		if [ "$carpProp" -eq 0 ]; then
			return 1
		fi	
        	done
        fi
	cantArchivos=$(ls "$carpProp" | wc -l)
	cantSubCarp=$(ls "$carpProp"/*/ | wc -l)
	echo "la cantidad de archivos es de $cantArchivos"
        echo "la cantidad de elementos en las subcarpetas es de $cantSubCarp"
	archivosTot=$(ls -S "$carpProp")
	masPesado=$(echo "$archivosTot" | head -n 1)
	menosPesado=$(echo "$archivosTot" | tail -n 1)
	echo "el archivo mas pesado es $masPesado"
	echo "el archivo menos pesado es $menosPesado"
	echo "======================="
}	




while true ; do
	echo "======================="
	echo "Nuestras opciones son:"
	echo "1) propiedad de carpeta"
	echo "2) sufijo bck a archivos"
	echo "3) estado disco duro"
	echo "4) buscador de palabras"
	echo "5) reporte del sistema"
	echo "6) guardar url en un txt"
	echo "7) guardar ruta (recomendado al iniciar)"
	echo "0) Salir"
	echo "======================="

	read -p "Ingrese numero de opcion: " opcion


	case $opcion in
	0)
		echo "======================="
		echo "Gracias por usar, adios"
		echo "======================="
		break
		;;
	1)
		propCarpeta
		;;
	2) 	
		renomBck
		;;
	3)	
		discoDuroEst
		;;
	4)
		buscadorPalabra
		;;
	5)
		reporteSist
		;;
	6)
		urlTxt
		;;
	7)
		guardarRuta
		;;
	esac
done
