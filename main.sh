#!/bin/bash

# changing the script pwd
cd $(dirname $0)

# imports
source ./ui/banner.sh
source ./helpers/error.sh
source ./helpers/uid.sh
source ./helpers/cmd.sh
source ./ui/prompt.sh

# main function
main () {
  banner
  checkuid
  ip=$1
  if [[ $ip == "" ]]; then
    error "$0: error: usage: $0 <ip>"
  fi
  printf "${BLUE}${BOLD}> Nombre de archivo para exportar evidencia nmap: ${GREEN}"
  read filename
  while [[ $filename == "" ]]; do
    printf "${RED}${BOLD}X Invalid response. ${BLUE}Nombre de archivo para exportar evidencia nmap: ${GREEN}"
    read filename
    printf "${NC}"
  done
  printf "${BLUE}${BOLD}> Plantilla de temporizado para nmap (1, 2, 3, 4 o 5): "
  read temporizing_level
  printf "${NC}"
  ok=0
  for n in {1..5}; do
    if [[ $temporizing_level == $n ]]; then
      ok=1
    fi
  done
  if [[ $ok == 0 ]]; then
    error "Plantilla de temporizado debe ser 1, 2, 3, 4 o 5"
  fi
  cmd "ping -c 1 $ip" "Enviando paquetes a la ip"
  cmd "nmap -p- --open -T${temporizing_level} -v -n $ip" "Escaneando puertos de la ip con nmap"
  cmd "nmap -p- -sS --min-rate 5000 --open -vvv -n $ip -oN ${filename}" "Ejecutando nmap con opcion minrate y exportando archivo $filename"
}

main $@
