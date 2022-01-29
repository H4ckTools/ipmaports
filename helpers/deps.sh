# this file provides a function to check if the user dependencies are
# installed

ROOT=$(dirname $0)
source $ROOT/helpers/error.sh

checkdeps () {
  deps='xclip nmap ping whatweb'
  for dep in $deps; do
    if ! command -v $dep 2>&1 > /dev/null; then
      error "The dependency \"$dep\" is required, you must install it on your system"
    fi
  done
}
