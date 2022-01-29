# execute a cmd and check if it exit successfully
# and print it to the user

ROOT=$(dirname $0)
source $ROOT/constants/colors.sh
source $ROOT/constants/styles.sh
source $ROOT/helpers/error.sh

cmd () {
  local cmd=$1
  local desc=$2
  printf "${MAGENTA}\$ ${cmd} ${GREY}# ${desc}${NORMAL}${NC}\n"
  $cmd
  if [[ $? != 0 ]]; then
    error "> The command returned an statuscode different that zero, it means the command is failure!"
  fi
}
