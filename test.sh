#!/bin/bash
clear
ecran=$(stty size | {
	read y x
	for((i=0;i<10;i++)) ; do
	printf "\e[%d;%dH%s" "$((i))" "$((x))" "│"
	done
	for((i=0;i<10;i++)) ; do
	printf "\e[%d;%dH%s" "$((i))" "$((x-10))" "│"
	done
	for((i=0;i<11;i++))     ; do
	printf "\e[%d;%dH%s" "0" "$((x-i))" "-"
	done
	for((i=0;i<11;i++)) ; do
	printf "\e[%d;%dH%s" "10" "$((x-i))" "-"
	done 
	printf "\e[$((2));$((x-9))H"
	printf %s "xxxx"
	printf "\e[$((3));$((x-9))H"
	printf %s "yyyyyyyy"
	printf "\e[$((4));$((x-9))H"
	printf %s "zzzz"
	printf "\e[$((5));$((x-9))H"
	printf %s "ee"
} 
)
echo $ecran