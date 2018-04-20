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
# Previous versions : 0.3,0.5
# Version : 0.70 Closed Beta

# This is a one path Rogue like RPG based on the RPG you can play in real life 
clear
my_dir="$(dirname $0)"
source "${my_dir}/class_functions.sh"

echo -e "\e[5m Press a key to skip... \e[25m "
tell_story2 "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras molestie eros at libero aliquam, et consectetur mi laoreet. Quisque nec ex bibendum, vestibulum ipsum nec, gravida tortor. Cras tincidunt, lacus eu cursus ullamcorper, diam nisi sagittis sem, eget consequat urna tortor eu ligula. Quisque id purus eu nunc malesuada sagittis at quis erat. Morbi laoreet finibus risus, sed auctor est. Nam pulvinar lectus mauris, et porta nulla imperdiet sit amet. Sed et tristique tellus, eget blandit nunc. In aliquet nec odio a scelerisque. Praesent consequat auctor tortor viverra tincidunt. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Duis id egestas enim. Proin vel euismod libero, non molestie eros. Nam id condimentum turpis. "
echo "---------------------------------------------------------------------------------"
echo ""
echo ""
echo "                 HELLO AND WELCOME TO A BASH RPG GAME "
echo "                       LET'S START THE ADVENTURE"
echo ""
echo "---------------------------------------------------------------------------------"

echo -en "\e[31m"
cat  bg_menu.txt
echo -en "\e[39m" 

echo "---------------------------------------------------------------------------------"
echo ""


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
			tell_story1 "      1) Warrior (Tank/Damage)"
			tell_story1 "      2) Thief (High Damage/chance of evading)" 
			tell_story1 "      3) Mage (Very high damage)"
			tell_story1 "      4) Ranger (Average damage/ chance of double attack )"

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




#TODO : A function that put all the data inside a txt file

 

echo "Here is your stats : "
echo "┌---------------------------------┐"
cat "stats.txt"
echo "└---------------------------------┘"
waiting2
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
		echo "3) Quit"
	    read -r -p "Your choice [1..3]" context_choice

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
		3)
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


	



