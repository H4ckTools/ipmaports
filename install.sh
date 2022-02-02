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
  printf "                                 ${BLUE}${BOLD}Instalación${NC}${NORMAL}\n"
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
  reset
  info "Verificando dependencias"
  checkdeps
  info "Descargando código fuente"
  git clone https://github.com/H4ckTools/ipmaports .ipmaports
  success "OK"
  info "Moviendo código fuente a /opt/ipmaports, usando sudo"
  sudo mv ./.ipmaports /opt/ipmaports
  success "OK"
  info "Creando el launcher en /usr/bin/ipmaports, usando sudo"
  sudo touch /usr/bin/ipmaports
  echo '#!/bin/bash' | sudo tee /usr/bin/ipmaports > /dev/null 2>&1
  echo 'sudo /opt/ipmaports/ipmaports.sh $@' | sudo tee -a /usr/bin/ipmaports > /dev/null 2>&1
  sudo chmod +x /opt/ipmaports/ipmaports.sh
  sudo chmod +x /usr/bin/ipmaports
  if command -v bat 2>&1 > /dev/null; then
    bat /usr/bin/ipmaports
  elif command -v batcat 2>&1 > /dev/null; then
    batcat /usr/bin/ipmaports
  else
    cat /usr/bin/ipmaports
  fi
  success "OK, instalación satisfactoria. Escribe 'ipmaports' para empezar"
}

main
