propCarpeta(){
        read -p "Ingrese ruta de la carpeta" carpProp	
	cantArchivos=$("$carpProp" | ls | wc -l)
	cantSubCarp=$("$carpProp" | ls -R | wc -l)
	echo "la cantidad de archivos es de $cantArchivos"
        echo "la cantidad de elementos en las subcarpetas es de $cantSubCarp"
	archivosTot = $("$carpProp" | ls )
	echo "el archivo mas pesado pesa $("$archivosTot" | sort -n | head -n 1)"
	echo "el archivo menos pesado pesa $("$archivosTot" | sort -nr | tail -n 1)"
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
