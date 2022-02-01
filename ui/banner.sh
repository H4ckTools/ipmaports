# this file provides the banner function

ROOT=$(dirname $0)
source $ROOT/constants/colors.sh
source $ROOT/constants/styles.sh

# function to print the banner of the script "IpMaPorts"
banner () {
  clear
  printf "${RED}$(cat $ROOT/plain/banner.txt)${NC}\n"
  printf "${GREEN}${BOLD}\nBy AlphaTechnolog and KOK41${NORMAL}\n\n"
  printf "${RED}${BOLD}Warning:${NC}${NORMAL}\n"
  printf "${BLUE}This Tool is made for educational purpose only${RED}!${NC}\n"
  printf "${BLUE}Author will not be responsible for any misuse of this toolkit${RED}!${NC}\n"
  echo
}
