#!/bin/bash

ROOT=$(dirname $0)

# imports
source $ROOT/ui/banner.sh
source $ROOT/helpers/error.sh
source $ROOT/helpers/uid.sh
source $ROOT/helpers/deps.sh
source $ROOT/helpers/cmd.sh
source $ROOT/helpers/extractPorts.sh

# main function
main () {
  banner
  checkuid
  checkdeps
  ip=$1
  if [[ $ip == "" ]]; then
    error "$(basename $0): error: usage: $0 <ip>"
  fi
  printf "${BLUE}${BOLD}> Nombre de archivo para exportar evidencia nmap: ${GREEN}"
  read filename
  while [[ $filename == "" ]]; do
    printf "${RED}${BOLD}X Invalid response. ${BLUE}Nombre de archivo para exportar evidencia nmap: ${GREEN}"
    read filename
    printf "${NC}"
  done
  formats='N X S G A'
  explained_formats='N = Nmap, X = Xml, S = ScRipT KIdd|3, G = Grepeable (ejecuta extractPorts automaticamente), A = Salida en todos los formatos'
  printf "${BLUE}${BOLD}> Formato de exportación de evidencia (${explained_formats}): ${GREEN}"
  read format
  ok=0
  for f in ${formats}; do
    if [[ $format == $f ]]; then
      ok=1
    fi
  done
  if [[ $ok == 0 ]]; then
    error "Formato inválido, formatos son ${explained_formats}"
  fi
  printf "${BLUE}${BOLD}> Quieres min-rate? (y/n) ${GREEN}${NC}"
  read want_min_rate
  while [[ $want_min_rate != 'y' && $want_min_rate != 'n' ]]; do
    printf "${RED}${BOLD}> Ingresa y o n ${GREEN}${NC}"
    read want_min_rate
  done

  cmd "ping -c 1 $ip" "Enviando paquetes a la ip"
  if [[ $want_min_rate == 'y' ]]; then
    cmd "nmap -p- -sS --min-rate 5000 --open -vvv -n $ip -o${format} ${filename}" "Ejecutando nmap con opcion minrate y exportando archivo $filename"
  else
    printf "${BLUE}${BOLD}> Plantilla de temporizado para nmap (1, 2, 3, 4 o 5): ${GREEN}"
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
    cmd "nmap -p- --open -T${temporizing_level} -v -n $ip -o${format} ${filename}" "Escaneando puertos de la ip con nmap, exporta evidencias en ${filename}"
  fi
  if [[ $format == 'G' ]]; then
    printf "${BLUE}${BOLD}Intentando extraer puertos con extractPorts (por s4vitar)${NC}\n"
    extractPorts $filename
    printf "${GREEN}${BOLD}OK, intenta usar Ctrl + Shift + V para pegar los puertos.${NC}\n"
  fi
  if [[ $format == 'G' ]]; then
    printf "${BLUE}${BOLD}> Intento obtener contenido html de todos los puertos? (y/n) ${GREEN}${NC}"
    read get_contents
    while [[ $get_contents != 'y' && $get_contents != 'n' ]]; do
      printf "${RED}${BOLD}> Ingresa y o n ${GREEN}${NC}"
      read get_contents
    done
    if [[ $get_contents == 'y' ]]; then
      ports=$(getExtractedPorts $filename)
      for port in $ports; do
        printf "${BLUE}${BOLD}Intentando obtener contenido de http://$ip:$port${MAGENTA}${NORMAL}\n"
        if ! lynx "http://${ip}:${port}" -dump 2> /dev/null; then
          printf "${RED}${BOLD}[x] No se pudo obtener contenido${NC}${NORMAL}\n"
        fi
        echo
      done
    fi
  fi
}

main $@
