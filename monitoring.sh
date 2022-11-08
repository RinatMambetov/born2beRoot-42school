#!/bin/bash
arc=$(arch)
kernel=$(hostnamectl | grep "Kernel" | awk '{printf ("%s %s\n", $2, $3)}')
pcpu=$(cat /proc/cpuinfo | grep "physical id" | wc -l)
vcpu=$(cat /proc/cpuinfo | grep processor | wc -l)
mem_total=$(free -m | grep Mem | awk '{print $3}')
mem_used=$(free -m | grep Mem | awk '{print $2}')
mem_perc=$(free -m | grep Mem | awk '{printf ("(%.2f%%)", (($3/$2)*100))}')
diskuse=$(df -h --total | grep total | awk '{printf ("%d/%dGb (%d%%)", $4, $2, $5)}')
cpul=$(top -bn1 | grep '%Cpu' | awk '{printf("%.1f%%", $2 + $3)}')
lboot=$(who -b | awk '{print $3, $4, $5}')
lvm=$(cat /etc/fstab | grep /dev/mapper/ | wc -l)
islvm=$(if [ $lvm = 0 ]; then echo no; else echo yes; fi)
actcon=$(ss | grep tcp | wc -l | awk '{printf ("%d", $1)}')
ulog=$(who | awk '{ print $1 }' | uniq | wc -l)
ip=$(hostname -I)
mac=$(ip a | grep -m1 link/ether | awk '{print $2}')
sudocom=$(cat /var/log/sudo/sudo.log | grep "COMMAND=" | wc -l)
wall "#Architecture: $arc $kernel
#CPU physical: $pcpu
#Virtual CPU: $vcpu
#Memory usage: $mem_total/$mem_used $mem_perc
#Disk usage: $diskuse
#CPU load: $cpul
#Last reboot: $lboot
#LVM use: $islvm
#Active TCP: $actcon
#Users log: $ulog
#Network: $ip $mac
#Sudo: $sudocom"
