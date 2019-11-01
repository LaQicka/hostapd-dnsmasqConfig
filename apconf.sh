#!/usr/bin/env bash
iptables --flush
iptables -t nat --flush
iptables --delete-chain
iptables -t nat --delete-chain
sysctl -w net.ipv4.ip_forward=1
ifconfig wlan1 192.168.2.1 netmask 255.255.255.0 up
ifconfig wlan1
iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
iptables -A FORWARD -i wlan1 -j ACCEPT
service hostapd stop
h=`service hostapd start`
if [ -z "$h" ]; then
  service hostapd start
  echo "hostapd started"
else
  echo $h
fi
service dnsmasq stop
d=`service dnsmasq start`
if [ -z "$d" ]; then
  service dnsmasq start
  echo "dnsmasq started"
else
  echo $d
fi
