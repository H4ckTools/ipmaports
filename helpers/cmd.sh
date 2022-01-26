# execute a cmd and check if it exit successfully
# and print it to the user

source ./constants/colors.sh
source ./constants/styles.sh
source ./helpers/error.sh

cmd () {
  local cmd=$1
  local desc=$2
  printf "${BLUE}\$ ${cmd}: ${desc}${NORMAL}${NC}\n"
  $cmd
  if [[ $? != 0 ]]; then
    error "> The command returned an statuscode different that zero, it means the command is failure!"
  fi
}
