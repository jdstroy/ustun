#!/bin/sh

/usr/local/sbin/us6tables -N CRACKERIPS
/usr/local/sbin/us6tables -A INPUT -p ipv6-icmp -s 2001:470:1f08:135d::1/128 -j ACCEPT -m comment --comment "PING von der Gegenstelle akzeptieren"
/usr/local/sbin/us6tables -A INPUT -j CRACKERIPS -m comment --comment "Cracker's IPs"
/usr/local/sbin/us6tables -A INPUT -m state --state NEW,RELATED,ESTABLISHED -j ACCEPT
/usr/local/sbin/us6tables -A INPUT -p ipv6-icmp --icmpv6-type 128 -j ACCEPT -m comment --comment "PING akzeptieren"
/usr/local/sbin/us6tables -A INPUT -p tcp -m multiport --dports smtp,smtps,submission,domain,www,https,pop3,pop3s -m comment --comment "SMTP, DNS, POP3, HTTP und HTTPs erlauben" -j ACCEPT
/usr/local/sbin/us6tables -A INPUT -p udp --dport domain -m comment --comment "DNS erlauben" -j ACCEPT
/usr/local/sbin/us6tables -A INPUT -s 2001:470:9735::/48 -m comment --comment "Alles von meinem Netz erlauben" -j ACCEPT
/usr/local/sbin/us6tables -A INPUT -j LOG --log-prefix IPv6 --log-level 7 -m comment --comment "Der Rest wird geloggt"
/usr/local/sbin/us6tables -P INPUT DROP
