#!/bin/bash

TIME=$(date)

#Manditory Info
OS=$(hostnamectl | grep 'Operating System' | cut -d ' ' -f5-)
KER=$(uname -r)
pCPU=$(grep "physical id" /proc/cpuinfo | sort -u | wc -l)
#	(Virtual CPU = (Threads x Cores) x Physical CPU)
vCPU=$(grep "^processor" /proc/cpuinfo | wc -l)
RAM=$(free -m | awk 'NR==2{printf "%s/%s MB (%.2f%%)\n", $3,$2,$3*100/$2 }')
DISK=$(df -h --total | grep "total" | awk '{printf "%sB/%sB (%s)\n", $3, $2, $5}')
BOOT=$(who -b | cut -d ' ' -f13-)
LVM=$(lsblk | grep "lvm" | awk 'NR==1{if ($6=="lvm") {print"Active";exit;} else print"Non-active"}')
ACCO=$(ss | grep "4242" | wc -l)
USER=$(who | cut -d " " -f1 | sort -u | wc -l)
IPv4=$(hostname -I)
MAC=$(ip -o link show | cut -d ' ' -f2,20 | awk '$1!="lo:" {print$2}')
SUDO=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall -n "Server Overview of $TIME

#Operating system:		$OS
#Kernel:			$KER
#Physical CPU:			$pCPU
#Virtual CPU:			$vCPU
#RAM Status:			$RAM
#Disk Usage:			$DISK
#Last Boot:			$BOOT
#LVM Status:			$LVM
#Active Connections:		$ACCO
#Unique Users Connected:	$USER
#IPv4 & MAC:			$IPv4 ($MAC)
#Sudo Commands Executed:	$SUDO
"
