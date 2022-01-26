#!/bin/bash

# changing the script pwd
cd $(dirname $0)

# imports

# ui/banner: provides the function: banner
source ./ui/banner.sh
source ./constants/colors.sh

# main function
main () {
  banner
}

main
