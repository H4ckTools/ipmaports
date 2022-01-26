# this file provide a progressbar function

progressbar() {
  local cols=$(tput cols)
  local titlelength=$(echo "$2" | wc -c)
  local w=$(expr $cols - 9 - $titlelength) p=$1;  shift
  # create a string of spaces, then change them to dots
  printf -v dots "%*s" "$(( $p*$w/100 ))" ""; dots=${dots// /#};
  # print those dots on a fixed-width space plus the percentage etc. 
  printf "\r\e[K[%-*s] %3d %% %s" "$w" "$dots" "$p" "$*"; 
}
