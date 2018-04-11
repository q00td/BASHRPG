#!/bin/bash

liste() {
  # A NOTER QUE LES ACCENTS NE SONT PAS RECONNUS
  x=$(sed -n '1p' < equipped.txt)
  head=$(cut -d ":" -f 2 <<< "$x")
  echo "$head"
  y=$(sed -n '2p' < equipped.txt)
  hand=$(cut -d ":" -f 2 <<< "$y")
  z=$(sed -n '3p' < equipped.txt)
  offhand=$(cut -d ":" -f 2 <<< "$z")
  alpha=$(sed -n '4p' < equipped.txt)
  chest=$(cut -d ":" -f 2 <<< "$alpha")
  echo "$hand $offhand $chest"
  beta=$(sed -n '5p' < equipped.txt)
  leg=$(cut -d ":" -f 2 <<< "$beta")
  echo "$leg"
}


disp_hud() {
  declare -a right=(
" o     "
" /|\    "
" / \    "
)
  local idx
  printf "┌%*s┬%*s┐\n" "40" "-Status- " "10" "" | sed 's/ /─/g ; s/-/ /g'
  while read l ; do
    printf "│%*s│%*s│\n" "-40" "$l" "10" "${right[$((idx++))]}"
  done
  printf "└%*s┴%*s┘\n" "40" "" "10" "" | sed 's/ /─/g'
}

