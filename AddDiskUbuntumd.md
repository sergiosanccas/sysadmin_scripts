Añadimos el disco a la maquina virtual

Listamos los discos

```console
sergio@server01:~$ sudo fdisk -l
Disk /dev/loop0: 87 MiB, 91160576 bytes, 178048 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk /dev/loop1: 54.6 MiB, 57229312 bytes, 111776 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk /dev/sda: 278.5 GiB, 298999349248 bytes, 583983104 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 631BE3B6-EFA6-4135-B213-C4B7D677ACA4

Device       Start       End   Sectors  Size Type
/dev/sda1     2048   1050623   1048576  512M EFI System
/dev/sda2  1050624 583981055 582930432  278G Linux filesystem

Disk /dev/sdb: 3.6 TiB, 3995997306880 bytes, 7804682240 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x94014387
```
## Comenzamos con el procedimiento

1. Damos formato al disco y creamos la particion

```console
sergio@server01:~$ sudo fdisk /dev/sdb
Welcome to fdisk (util-linux 2.31.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (1-4, default 1): 
First sector (2048-4294967295, default 2048): 
Last sector, +sectors or +size{K,M,G,T,P} (2048-4294967294, default 4294967294): 

Created a new partition 1 of type 'Linux' and of size 2 TiB.
Command (m for help): w
The partition table has been altered.
Failed to add partition 1 to system: Device or resource busy

The kernel still uses the old partitions. The new table will be used at the next reboot. 
Synching disks.
```

2. Creamos el sistema de ficheros

```console
sergio@server01:~$ sudo mkfs -t ext4 /dev/sdb1
mke2fs 1.44.1 (24-Mar-2018)
/dev/sdb1 contains a ext4 filesystem
last mounted on Wed Aug 29 13:52:29 2018
Proceed anyway? (y/N) y
Creating filesystem with 536870655 4k blocks and 134217728 inodes
Filesystem UUID: 7cdb6e60-b655-4f15-9a8c-982154ac2194
Superblock backups stored on blocks:
32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
102400000, 214990848, 512000000

Allocating group tables: done
Writing inode tables: done
Creating journal (262144 blocks): done
Writing superblocks and filesystem accounting information: done

```

3. Creamos el punto de montaje

```console
sergio@server01:~$ ssudo mkfs -t ext4 /dev/sdb1

```

4. Obtenemos el uuid del disco

```console
sergio@server01:~$ ls -al /dev/disk/by-uuid/
total 0
drwxr-xr-x 2 root root 100 Aug 29 14:57 .
drwxr-xr-x 7 root root 140 Aug 29 13:52 ..
lrwxrwxrwx 1 root root  10 Aug 29 13:52 421A-0CA5 -> ../../sda1
lrwxrwxrwx 1 root root  10 Aug 29 14:57 7cdb6e60-b655-4f15-9a8c-982154ac2194 -> ../../sdb1
lrwxrwxrwx 1 root root  10 Aug 29 13:52 8d1e89e0-7b7d-4935-8276-401d611eaba1 -> ../../sda2
```

5. Editamos el fichero **/etc/fstab**

```console
sergio@server01:~$ sudo nano /etc/fstab

```
Le debemos añadir la siguiente linea

```bash
UUID=7cdb6e60-b655-4f15-9a8c-982154ac2194        /media/StorageVm       ext4    defaults 0      0

```

6. Reiniciamos el servidor

```console
sergio@server01:~$ sudo nreboot

```


