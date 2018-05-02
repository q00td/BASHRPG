#!/bin/bash
clear
stty size | {
  read y x
  tput sc # save cursor position
  for((i=0;i<10;i++)) ; do
    printf "\e[$((i));$((x))H"
    printf %s "│"
  done
  for((i=0;i<10;i++)) ; do
    printf "\e[$((i));$((x-10))H"
    printf %s "│"
  done
  for((i=0;i<11;i++))   ; do
    #tput cup "$((0))" "$((x-i-1))" # position cursor
    printf "\e[0;$((x-i))H"
    printf %s "-"
  done
  for((i=0;i<11;i++)) ; do
    printf "\e[10;$((x-i))H"
    printf %s "-"
  done
  tput rc # restore cursor.
} 