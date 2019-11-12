# sysadmin_scripts
Scripts para facilitar la istalación y configuración de sistemas

##Instalar docker

Script encargado de instalar docker en un servidor de linux.

Para utilizarlo debemos ejecutarlo de la siguiente forma

```shell
$./install-docker
```	

##Hashman

Script encargado de sacar el hash de un fichero o de un directorio de forma recursiva y guardarlo en un fichero de texto.

Las opciones son:

- Ruta del fichero o directorio: *< -f filename>*
- Salida en un fichero de texto: *< -o nombreFichero>*. Si no se pone nombre del fichero, se genera uno automaticamente

```
./hashman.sh -f <nameFile| directory> -o <outputh_path>
```

##IpTables Config

Script encargado de crear una configuración con una serie de reglas básicas para el firewall

Las principales reglas son:

- Bloquea todo el trafico por defecto
- Crea una regla para el servicio Fail2ban y el puerto indicado para ssh
- Conectividad de los dockers
- Acceso a la bbdd desde la ip fija indicada en el puerto indicado
- Ping desde una ip fija