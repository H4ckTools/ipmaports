#!/bin/bash

# changing the script pwd
cd $(dirname $0)

# imports

# ui/banner: provides the function: banner
source ./ui/banner.sh
source ./ui/progressbar.sh

# main function
main () {
  banner
  for n in {1..100}; do
    progressbar $n "Exiting..."
    sleep .05
  done
}

main
