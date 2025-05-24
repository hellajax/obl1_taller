#!/bin/bash

discoDuroEst(){
	  espLibre=$(df -h /mnt/c)
	  espOcupado=$(du -sh /mnt/c)
	  masGrande=$(ls -S /mnt/c | head -n 1)
	  echo "el espacio libre es $espLibre"
	  echo "el espacio ocupado es $espOcupado"
	  echo "el archivo mas grande del disco es $masGrande"

}



renomBck(){
	read -p "Ingrese ruta de la carpeta: " carpRenom
	for i in "$carpRenom"/*; do
		mv "$i" "${i}bck"
		echo "renombre "$i" -> "${i}bck""
	done
}



propCarpeta(){
        read -p "Ingrese ruta de la carpeta: " carpProp	
	cantArchivos=$(ls "$carpProp" | wc -l)
	cantSubCarp=$(ls "$carpProp"/*/ | wc -l)
	echo "la cantidad de archivos es de $cantArchivos"
        echo "la cantidad de elementos en las subcarpetas es de $cantSubCarp"
	archivosTot=$(ls -S "$carpProp")
	masPesado=$(echo "$archivosTot" | head -n 1)
	menosPesado=$(echo "$archivosTot" | tail -n 1)
	echo "el archivo mas pesado es $masPesado"
	echo "el archivo menos pesado es $menosPesado"
}	




while true ; do
	echo "opciones:"
	echo "1) prop de carpeta"
	echo "2) renombrar a bck"
	echo "3) estado disco duro"
	echo "4) buscador de palabras"
	echo "5) reporte del sistema"
	echo "7) txt de url"
	echo "7) guardar ruta"
	echo "0) Salir"
	read -p "Ingrese numero de opcion: " opcion

	case $opcion in
	0)
		echo "adios"
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
