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
  printf "                              ${BLUE}${BOLD}Uninstallation${NC}${NORMAL}\n"
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
  info "Checking installation"
  if ! command -v ipmaports 2>&1 > /dev/null; then
    error "The command 'ipmaports', cannot be found in your PATH, please ensure you have ipmaports installed before run this uninstaller"
  fi
  success "Done"
  info "Removing /opt/ipmaports, using sudo"
  sudo rm -rf /opt/ipmaports
  success "Done"
  info "Removing the launcher /usr/bin/ipmaports, using sudo"
  sudo rm /usr/bin/ipmaports
  success "Done, uninstallation successfully"
}

main
