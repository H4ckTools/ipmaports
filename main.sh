#!/bin/bash

# changing the script pwd
cd $(dirname $0)

# imports
source ./ui/banner.sh
source ./helpers/error.sh
source ./helpers/uid.sh
source ./helpers/cmd.sh

# main function
main () {
  banner
  checkuid
  ip=$1
  if [[ $ip == "" ]]; then
    error "$0: error: usage: $0 <ip>"
  fi
  cmd "ping -c 1 $ip" "Enviando paquetes a la ip"
  cmd "nmap -p- --open -Tx -v -n $ip" "Escaneando puertos de la ip con nmap"
  cmd "nmap -p- -sS --min-rate 5000 --open -vvv -n $ip -oG allPorts" "nmap opcion minrate y triple verbose" # por ahora puse grepeable con allPorts
}

main $@
