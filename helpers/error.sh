# define a custom error function

ROOT=$(dirname $0)
source $ROOT/constants/colors.sh
source $ROOT/constants/styles.sh

# error function
error () {
  >&2 printf "${RED}${BOLD}${@}${NC}\n"
  exit 1
}
