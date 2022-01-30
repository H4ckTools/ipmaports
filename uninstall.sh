#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

error () {
  >&2 printf "${RED}${BOLD}$@${NC}\n"
  exit 1
}

checkdeps () {
  deps='git sudo'
  for dep in $deps; do
    if ! command -v $dep 2>&1 > /dev/null; then
      error "Dependency '${dep}' not found, install it please"
    fi
  done
}

basebanner () {
cat << EOF
                                             
 ▄▄▄      ▗▄ ▄▖     ▗▄▄▖                     
 ▀█▀      ▐█ █▌     ▐▛▀▜▖           ▐▌       
  █  ▐▙█▙ ▐███▌ ▟██▖▐▌ ▐▌ ▟█▙  █▟█▌▐███ ▗▟██▖
  █  ▐▛ ▜▌▐▌█▐▌ ▘▄▟▌▐██▛ ▐▛ ▜▌ █▘   ▐▌  ▐▙▄▖▘
  █  ▐▌ ▐▌▐▌▀▐▌▗█▀▜▌▐▌   ▐▌ ▐▌ █    ▐▌   ▀▀█▖
 ▄█▄ ▐█▄█▘▐▌ ▐▌▐▙▄█▌▐▌   ▝█▄█▘ █    ▐▙▄ ▐▄▄▟▌
 ▀▀▀ ▐▌▀▘ ▝▘ ▝▘ ▀▀▝▘▝▘    ▝▀▘  ▀     ▀▀  ▀▀▀ 
     ▐▌                                      

EOF
}

banner () {
  printf "${RED}${BOLD}$(basebanner)${NC}${NORMAL}\n"
  printf "                              ${BLUE}${BOLD}Desinstalación${NC}${NORMAL}\n"
  printf "${GREEN}${BOLD}By AlphaTechnolog and KOK41${NC}${NORMAL}\n"
}

success () {
  printf "${GREEN}${BOLD}$@${NC}\n"
}

reset () {
  clear
  banner
}

info () {
  reset
  printf "${BLUE}${BOLD}$@...${NC}\n"
  sleep .5
}

main () {
  info "Verificando instalación"
  if ! command -v ipmaports 2>&1 > /dev/null; then
    error "El comando ipmaports no se puede encontrar en el sistema, instale el programa antes de ejecutar el desinstalador"
  fi
  success "OK"
  info "Eliminando el código fuente en '/opt/ipmaports', usando sudo"
  sudo rm -rf /opt/ipmaports
  success "OK"
  info "Eliminando el launcher en '/usr/bin/ipmaports', usando sudo"
  sudo rm /usr/bin/ipmaports
  success "OK, Desinstalación satisfactoria"
}

main
