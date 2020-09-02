#!/bin/bash

iptables -F
iptables -X

iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP

#Interfaz lo
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT


ip_fija=xxx.xx.x.x
ssh_port=22445
bbdd_port=3309
penlace=eth0


#---- Allow outgoing packets generated in this machine
iptables -A OUTPUT -p tcp  -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -p udp  -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

#---- Allow ongoing conversations (stateful filtering)
iptables -A INPUT -p tcp  -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp  -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p icmp -m state --state RELATED,ESTABLISHED -j ACCEPT


#Fail2tab rules

iptables -A INPUT -p tcp -m multiport --dports $ssh_port -j f2b-sshd

#ping desde ip fija

iptables -A INPUT -s $ip_fija -p icmp -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 8 -s 0/0 -d $ip_fija -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

iptables -A OUTPUT -p icmp --icmp-type 0 -s $ip_fija -d 0/0 -m state --state ESTABLISHED,RELATED -j ACCEPT

#SSH para conexiones establecidas, de esta manera no las cerrara
iptables -A INPUT -p tcp -m tcp --sport $ssh_port -m state --state ESTABLISHED -j ACCEPT

#Aceptamos las conexiones establecidas
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

#Damos conectividad a los docker
iptables -A FORWARD -i docker0 -o $penlace -j ACCEPT
iptables -A FORWARD -i $penlace -o docker0 -j ACCEPT

iptables -t nat -A POSTROUTING -s 172.17.0.0/24 -o $penlace -j MASQUERADE

#Si necesitamos dar acceso a la bbdd
iptables -A INPUT -i $penlace -p tcp -s $ip_fija --dport $bbdd_port -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -i $penlace -p tcp --sport $bbdd_port -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Registra todos los paquetes no aceptados
iptables -A INPUT -j LOG --log-prefix "Descartado (INPUT):" --log-level debug

#Si tenemos alguna regla fija, por ej de ssh las ponemos

#Incoming malformed NULL packets
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP


#Eliminamos las conexiones

sudo iptables -A INPUT -j DROP
