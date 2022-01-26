# this file provides the banner function

source ./constants/colors.sh
source ./constants/styles.sh

# function to print the banner of the script "IpMaPorts"
banner () {
  clear
  printf "${RED}$(cat ./plain/banner.txt)${NC}\n"
  printf "${GREEN}${BOLD}\nBy AlphaTechnolog and KOK41${NORMAL}\n\n"
}
