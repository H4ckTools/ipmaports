#!/bin/bash

# changing the script pwd
cd $(dirname $0)

# imports
source ./ui/banner.sh
source ./helpers/error.sh

# main function
main () {
  banner
  ip=$1
  if [[ $ip == "" ]]; then
    error "$0: error: usage: $0 <ip>"
  fi
  echo $ip
  echo "Enviando paquetes a la ip"
    ping -c 1 $ip
  echo "Escaneando puertos de la ip con "
    nmap -p- --open -Tx -v -n $ip
  echo "nmap opcion minrate y triple vervose"
    nmap -p- -sS --min-rate 5000 --open -vvv -n $ip "aqui faltaria lo que viene siendo          en que formato deseas exportarlo"
}

main $@
