#!/bin/bash

# Colors
b="\e[1m"
w="\e[0m"
r="\e[31m"
d="\e[2m"

# Banner
logo="$b
                          _cyqyc_
                      :>3qKKKKKKKq3>:
                  ';CpKKKKKKKkKKKKKKKpC;'
              -\"iPKKKKKKkkkCZ3R0KKKKKKKKKKPi\"-
          \`~v]KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK]v~\`
       ,rwKKKKKKKKKKKKKPv;,:'-':,;vPKKKKKKKKKKKKKwr,
      !KKKKKKKKKKKKKKK/             !KKKKKKKKKKKKKKK!
      !KKKKKKKKKKKKKKf       ?       CKKKKKKKKKKKKKK!
      !KKKKKKKKKKKKKp-               -qKKKKKKKKKKKKK!
      !KKKKKKKKKKKKK>\"               \"\\KKKKKKKKKKKKK!
      !KKKKKKKw;,_'-                   .-:,\"wKKKKKKK!
      !KKKKKKKKhi*;\"                   \";*ihKKKKKKKK!
      !KKKKKKKKKKKKK;                 ;KKKKKKKKKKKKK!
      !KKKKKKKKKKKKK2>'             '>2KKKKKKKKKKKKK!
      !KKKKKKKKKKKKKKKZ             ZKKKKKKKKKKKKKKK!
      !KKKKKKKKKKKKKKK5             eKKKKKKKKKKKKKKK!
      !KKKKKKKKKKKqC;-               -;CqKKKKKKKKKKK!
      <KKKKKKKKkr,                       ,rSKKKKKKKK<
       -\"v]qj;-                             -;jq]v\"-
                        $w[Safe_THM]$w
          $d Configuration iptables for TryHackMe
                  $d by $w$r@Commander.Z3R0$w"

echo -e "$logo"

# Verify privileges
if [ "$EUID" -ne 0 ]; then
  echo "   ----> Please execute the script with privileges."
  exit 1
fi

# Clear all existing rules and chains
iptables -F
iptables -X

ip6tables -F
ip6tables -X

# Set default policies
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

ip6tables -P INPUT DROP
ip6tables -P FORWARD DROP
ip6tables -P OUTPUT DROP

# Flush NAT and Mangle tables
iptables -t nat -F
iptables -t mangle -F

ip6tables -t nat -F
ip6tables -t mangle -F

# Ping machine rules
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
iptables -A INPUT -p icmp -j DROP

iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT
iptables -A OUTPUT -p icmp -j DROP

# Allow VPN connection only from specific machine
iptables -A INPUT -i tun0 -p tcp -s $1 -j ACCEPT
iptables -A OUTPUT -o tun0 -p tcp -d $1 -j ACCEPT
iptables -A INPUT -i tun0 -p udp -s $1 -j ACCEPT
iptables -A OUTPUT -o tun0 -p udp -d $1 -j ACCEPT
iptables -A INPUT -i tun0 -j DROP
iptables -A OUTPUT -o tun0 -j DROP

# Save the rules
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6
