# this file provides a function to check if the user dependencies are
# installed

ROOT=$(dirname $0)
source $ROOT/helpers/error.sh

checkdeps () {
  deps='xclip nmap ping whatweb lynx python3'
  for dep in $deps; do
    if ! command -v $dep 2>&1 > /dev/null; then
      error "The dependency \"$dep\" is required, you must install it on your system, try with your package manager or recompiling it from source code"
    fi
  done
}
