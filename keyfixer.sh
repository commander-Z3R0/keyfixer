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
                       $w[Key-Fixer]$w
      $d Simple Script to Fix EXPKEYSIG Kali Linux Repo
                $d Author by $w$r@Commander.Z3R0$w"

echo -e "$logo"

# Verify privileges
if [ "$EUID" -ne 0 ]; then
  echo "       [!] Please execute the script with privileges."
  exit 1
fi

# Download the .deb key file
wget https://http.kali.org/kali/pool/main/k/kali-archive-keyring/kali-archive-keyring_2022.1_all.deb &>/dev/null

# Install the .deb file
apt install ./kali-archive-keyring_2022.1_all.deb  &>/dev/null

# Delete the installed .deb file
rm kali-archive-keyring_2022.1_all.deb  &>/dev/null

echo "          [+] The process finished successfully."



