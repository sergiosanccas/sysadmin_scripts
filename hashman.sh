
#!/bin/bash
#title           :hashman.sh
#description     :This script will make hash file or directory
#author		 	 : Sergio Sanchez
#date            :20191010
#version         :1.0   
#usage		     :hashman.sh -f <nameFile| directory> -o <outputh_path>
#bash_version    :4.1.5(1)-release
#==============================================================================



echo " \x1B[32m  _   _   ___   _____ _   _ ___  ___  ___   _   _ \x1B[0m";
echo " \x1B[32m | | | | / _ \ /  ___| | | ||  \/  | / _ \ | \ | |\x1B[0m";
echo " \x1B[32m | |_| |/ /_\ \\ \`--.| |_| || .  . |/ /_\ \|  \| |\x1B[0m";
echo " \x1B[32m |  _  ||  _  | \`--. \  _  || |\/| ||  _  || . \` |\x1B[0m";
echo " \x1B[32m | | | || | | |/\__/ / | | || |  | || | | || |\  |\x1B[0m";
echo " \x1B[32m \_| |_/\_| |_/\____/\_| |_/\_|  |_/\_| |_/\_| \_/\x1B[0m";
echo " \x1B[32m                                                  \x1B[0m";
echo " \x1B[32m	   Sergio Sanchez Castell | v1.0                 \x1B[0m";


CURR_DIR="$(dirname $0)"
today=$(date +%Y-%m-%d-%H:%M:%S)
echo $today
printf "Script executed by user: %s\n" $(whoami)

menuHelp(){

	echo "Select one of the next parameters"
	echo "-f <nameFile> : File or directory path to hash"
	echo "-o <nameFile> : File to save the information.Empty to generate automatically the file"
	echo $CURR_DIR
}

createFile(){
	#Parameters:
		#$1: name of file where saving the data
		#$2: name file/path to hash

	NAMEFILE=$1
	printf "****************  HASH REPORT  *********************\n" >> $NAMEFILE
	printf " Start date:\t%s\n File path /name:\t%s\n" $today $2 >> $NAMEFILE
	printf "****************************************************\n" >> $NAMEFILE

}



if [ -n "$1" ]; then #Comprobamos que se pase un parametro
	while [ -n "$1" ]; do # while loop starts
	 
	    case "$1" in

	    -h|--help)
			menuHelp ;;
	 
	    -f|--file) 
			param_file="$2"
	        shift
	        ;;
	 
	    -o) 
			
			if [ -z $2 ]; then
					output_path="$(date +%Y%m%d-%H%M%S)_Hashreport.txt"
			else
				output_path="$2"
			fi
	 		createFile $output_path $param_file
	        shift
	        ;;
	 
	    --)
	        shift
	 
	        break
	        ;;
	 
	    *) echo "Option $1 not recognized" 
			menuHelp ;;
	 
	    esac
	 
	    shift
	 
	done
else
	echo "Please, use one of the next parameters"
	menuHelp
fi

############################################################################################
#								FUNCIONES DEL PROGRAMA
############################################################################################


#Recorremos todos los ficheros de la ruta
hashFiles(){

nmeFile=$2 #Nombre del fichero pasado


if [ -n "$1" ]; then #Comprobamos que se pase un parametro
	# bash for loop
	for f in $( find $1 -type f ); do
		if [ -f $f ]; then #Comprobamos que sea un fichero
			if [ -z $2 ]; then #No hay output, mostramos por pantalla
				echo $(shasum $f)
			else
				#createFile $nmeFile $1 #Creamos el fichero con la cabecera
				echo $(shasum $f) >> $2 #Redirigir la salida al fichero
			fi
		fi
	done 
	
else
	exit 0
fi
}





############################################################################################
if [ -n "$param_file" ]  #No es un fichero
then
    echo "Take the hash"
    hashFiles $param_file $output_path
    #createFile
fi




exit 0
