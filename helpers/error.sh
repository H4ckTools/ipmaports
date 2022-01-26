# define a custom error function

source ./constants/colors.sh
source ./constants/styles.sh

# error function
error () {
  >&2 printf "${RED}${BOLD}${@}${NC}\n"
  exit 1
}
