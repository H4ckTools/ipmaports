# this file provides the banner function

source ./constants/colors.sh

# function to print the banner of the script "IpMaPorts"
banner () {
printf "${RED}$(cat ./plain/banner.txt)${NC}\n"
}
