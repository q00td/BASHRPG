#!/bin/bash
clear
stty size | {
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
} 