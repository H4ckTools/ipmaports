# this file provides the whichSystem.py integration for bash

ROOT=$(dirname $0)

whichSystem () {
  ip=$@
  if [[ $ip == 'localhost' ]]; then
    ip='127.0.0.1'
  fi
  python3 $ROOT/scripts/whichSystem.py $ip
}
