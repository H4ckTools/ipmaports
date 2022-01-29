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

success () {
  printf "${GREEN}${BOLD}$@${NC}\n"
}

info () {
  printf "${BLUE}${BOLD}$@${NC}\n"
}

checkdeps () {
  deps='git sudo'
  for dep in $deps; do
    if ! command -v $dep 2>&1 > /dev/null; then
      error "Dependency '${dep}' not found, install it please"
    fi
  done
}

main () {
  checkdeps
  info "Downloading source code"
  git clone https://github.com/H4ckTools/ipmaports .ipmaports
  success "Done"
  info "Using sudo to move code to /opt"
  sudo mv ./.ipmaports /opt/ipmaports
  success "Done"
  info "Creating the launcher to /usr/bin, using sudo"
  sudo touch /usr/bin/ipmaports
  echo '#!/bin/bash' | sudo tee /usr/bin/ipmaports
  echo 'sudo /opt/ipmaports/main.sh $@' | sudo tee -a /usr/bin/ipmaports
  sudo chmod +x /opt/ipmaports/main.sh > /dev/null 2>&1
  sudo chmod +x /usr/bin/ipmaports > /dev/null 2>&1
  success "Done, installation successfully. Type ipmaports to start"
}

main
