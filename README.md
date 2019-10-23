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