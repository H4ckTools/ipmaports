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
  printf "${BLUE}${BOLD}> Nmap results exportation filename: ${GREEN}"
  read filename
  while [[ $filename == "" ]]; do
    printf "${RED}${BOLD}X Invalid response. ${BLUE}Nmap results exportation filename: ${GREEN}"
    read filename
    printf "${NC}"
  done
  formats='N X S G A'
  explained_formats='N = Nmap, X = Xml, S = ScRipT KIdd|3, G = Grepeable (execute the extractPorts function automatically (by s4vitar)), A = All formats'
  printf "${RED}[${NC}::${RED}]${ORANGE} Select exportation format ${RED}[${NC}::${RED}]${ORANGE}\n"
  printf "${RED}[${NC}X${RED}]${ORANGE} Xml       ${RED}[${NC}S${RED}]${ORANGE} ScRiPT KiDd|E\n"
  printf "${RED}[${NC}N${RED}]${ORANGE} Nmap      ${RED}[${NC}A${RED}]${ORANGE} All Formats\n"
  printf "${RED}[${NC}G${RED}]${ORANGE} Grepeable\n"
  printf "${BLUE}${BOLD}> Results exportation format: ${GREEN}"
  read format
  ok=0
  for f in ${formats}; do
    if [[ $format == $f ]]; then
      ok=1
    fi
  done
  if [[ $ok == 0 ]]; then
    error "Invalid format, valid formats are: ${explained_formats}"
  fi
  printf "${BLUE}${BOLD}> You want min-rate to nmap? (y/n) ${GREEN}"
  read want_min_rate
  while [[ $want_min_rate != 'y' && $want_min_rate != 'n' ]]; do
    printf "${RED}${BOLD}> Write y or n (y = yes or n = no) ${GREEN}"
    read want_min_rate
  done

  cmd "ping -c 1 $ip" "Sending packages to the host using ping"
  if [[ $want_min_rate == 'y' ]]; then
    cmd "nmap -p- -sS --min-rate 5000 --open -vvv -n $ip -o${format} ${filename}" "Executing nmap with min-rate and exporting results to $filename"
  else
    printf "${BLUE}${BOLD}> Temporizing template (1, 2, 3, 4 or 5): ${GREEN}"
    read temporizing_level
    printf "${NC}"
    ok=0
    for n in {1..5}; do
      if [[ $temporizing_level == $n ]]; then
        ok=1
      fi
    done
    if [[ $ok == 0 ]]; then
      error "Temporizing level only can be 1, 2, 3, 4 o 5"
    fi
    cmd "nmap -p- --open -T${temporizing_level} -v -n $ip -o${format} ${filename}" "Escaneando puertos de la ip con nmap, exporta evidencias en ${filename}"
  fi
  if [[ $format == 'G' ]]; then
    printf "${BLUE}${BOLD}Trying to get and copy opened ports with the extractPorts function (by s4vitar)${NC}\n"
    extractPorts $filename
    printf "${GREEN}${BOLD}OK, try using Ctrl + Shift + V to paste the ports in your shell.${NC}\n"
  fi
  if [[ $format == 'G' ]]; then
    printf "${BLUE}${BOLD}> Try to get the html content in the terminal (this has terminal html rendering)? (y/n) ${GREEN}"
    read get_contents
    while [[ $get_contents != 'y' && $get_contents != 'n' ]]; do
      printf "${RED}${BOLD}> Write y or n (y = yes and n = no) ${GREEN}"
      read get_contents
    done
    if [[ $get_contents == 'y' ]]; then
      ports=$(getExtractedPorts $filename)
      for port in $ports; do
        printf "${BLUE}${BOLD}Trying to get content of http://$ip:$port${MAGENTA}${NORMAL}\n"
        cmd "whatweb http://${ip}:${port}" "Page data with whatweb"
        if ! lynx "http://${ip}:${port}" -dump 2> /dev/null; then
          printf "${RED}${BOLD}[x] Cannot get content of page with lynx${NC}${NORMAL}\n"
        fi
        echo
      done
    fi
  fi
}

main $@
