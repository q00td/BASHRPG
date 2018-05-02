#!/bin/bash


clear

ecran=$(stty size | {
  read y x
  tput sc # save cursor position
  for((i=0;i<10;i++))
	do
	
	tput cup "$((i))" "$((x))" # position cursor
	printf %s "│"
	done
	for((i=0;i<10;i++))
		do
		
		tput cup "$((i))" "$((x-10))" # position cursor
		printf %s "│"
	done
	for((i=0;i<10;i++))
			do
			
			tput cup "$((0))" "$((x-i-1))" # position cursor
			printf %s "-"
		done
	for((i=0;i<10;i++))
			do
			
			tput cup "$((10))" "$((x-i-1))" # position cursor
			printf %s "-"
		done
  tput rc # restore cursor.
}
)

echo $ecran
