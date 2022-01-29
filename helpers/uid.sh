# provide a function that checks if the user is
# root or not, it's required to nmap

ROOT=$(dirname $0)
source $ROOT/helpers/error.sh

checkuid () {
  if [[ $UID != 0 ]]; then
    error "$(basename $0): error: is required you have root permisions, execute me with sudo or as root pls :)"
  fi
}
