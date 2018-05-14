#!/bin/bash
############################################
#                                          #
#                                          #
#              A SHELL RPG GAME            #
#                                          #
#                    2018                  #
#                                          #
############################################

# Author : Quentin OTERNAUD , Quentin GANDILLET
# Previous versions : 0.3-0.5-0.7-1.0-2.0
# Version : 3.00 Closed Beta

# This is a one path Rogue like RPG based on the RPG you can play in real life
_TrappedExit(){
	clear
	echo ""
	echo "╔═╗╔═╗╔═╗╔╦╗  ╔╗ ╦ ╦╔═╗  ┬  
║ ╦║ ║║ ║ ║║  ╠╩╗╚╦╝║╣   │  
╚═╝╚═╝╚═╝═╩╝  ╚═╝ ╩ ╚═╝  o "
	exit 0
}
trap '_TrappedExit' SIGTERM SIGINT
clear
my_dir="$(dirname $0)"
source "${my_dir}/class_functions.sh"	
aplay -q music.wav &
echo -e "\e[5m Press a key to skip... \e[25m "
tell_story2 "Once upon a time, a Young adventurer called Elyos who only activity was to hunt deers to feed his sister, found the entrance to a another world, so dark and so deep into the earth that no one would even want to go through that gate. But one day his last member of his family, her sister, suddenly dissapeared. The only trail he had was some blood following a path, leading to the gate he found before. This the Quest about finding the last thing you treasure the most. This is your Quest.."

z=18
for (( i=0;i<z; i++ )); do
	echo "---------------------------------------------------------------------------------"
	echo ""
	echo ""
	echo "                 HELLO AND WELCOME TO A BASH RPG GAME "
	echo "                       LET'S START THE ADVENTURE"
	echo ""
	echo "---------------------------------------------------------------------------------"
	echo -en "\e[31m"
	x=$((RANDOM%3+1))
	sleep 0.2
	clear
	cat "bg_menu${x}.txt"
	echo -en "\e[39m" 
done

echo "---------------------------------------------------------------------------------"
echo ""

clear

while :
do
read -r -p "Do you want to continue your last game ? y/n : " context_choice

	    case ${context_choice} in
		y)
			if [ ! -s "stats.txt" ];
				then
				echo "Error : For Some reasons you don't seem to have any save files"
			else
				break;
			fi
		    ;;
		n)
			init
		   	echo -e " \e[4m So which Class would you like to pick :\e[24m"
			tell_story1 "      1) Warrior (Tank/ special attack heal on hit)"
			tell_story1 "      2) Thief (High Damage/Steal item on special attack)" 
			tell_story1 "      3) Mage (Very high damage/ Very high damage special attack)"
			tell_story1 "      4) Ranger (Average damage/ high damage special attack)"

			while :
			do
			    read -r -p "Your choice [1..4]" class_nb

			    case ${class_nb} in
			        1)
			            init_class $class_nb
			            break
			            
			            ;;
			        2)
			            init_class $class_nb
			            break
			            
			            ;;
			        3)
			            init_class $class_nb
			            break
			            
			            ;;
			        4)
			            init_class $class_nb
			            break
			            
			            ;;
			        *)
			            echo "Is it that hard to type a number between 1 and 4 ?"
			            ;;
			    esac
			done
			break
		    ;;

		*)
		    echo "Seriously could you just type y or n ?"

		    ;;
	    esac


done
test_hud



#TODO : A function that put all the data inside a txt file

 

echo "Here is your stats : "

cat "stats.txt" | disp_hud_stats

tell_story2 "Press a key To enter the dungeon..."
clear
#TODO : Show stats 

#get_stats

echo "---------------------------------------------------------------------------------"
echo ""
echo ""
echo ""
#cat door.txt
echo " You'll now enter the dungeon"
echo "-------------------------------------------------------"
finished=0
# "true" will change it to get_hp further

while [ "true" -a "$finished" -eq "0" ];
do


	#CHOOSE A MAP AND SAVE IT INSIDE A VARIABLE
	choose_map
	res=$?
	play_map $res
#	generate_map #TODO GENERATE THE MAP , AND SECOND GAME_LOOP INSIDE IT, FIGHTS , XP , TREASURES , MERCHANT
echo "---------------------------------------NEW_ROOM---------------------------------"

	

	while :
	do
		echo -e "\e[4mRoom cleared , do you want to do something ?\e[24m"

		echo "1) Inventory"
		echo "2) Go to the next room"
		echo "q) Quit"
	    read -r -p "Your choice [1..q]" context_choice

	    case ${context_choice} in
		1)
		    #open_inventory
			clear
			open_inventory
		    ;;
		2)
		    echo "Going to the next room..."
		    break
		    ;;
		"q")
		    #TODO Méthode pour break tout le prgrm
			echo ""
			echo "╔═╗╔═╗╔═╗╔╦╗  ╔╗ ╦ ╦╔═╗  ┬  
║ ╦║ ║║ ║ ║║  ╠╩╗╚╦╝║╣   │  
╚═╝╚═╝╚═╝═╩╝  ╚═╝ ╩ ╚═╝  o "
			exit
		    ;;
		*)
		    echo "Seriously could you just type a number between 1 & 3 ?"
		    ;;
	    esac
	done
	echo "--------------------------------------------------------------------------------"
done


	



