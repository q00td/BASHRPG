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
# Version : 0.01 Closed Beta

# This is a one path Rogue like RPG based on the "In real life" RPG

my_dir="$(dirname $0)"
source "${my_dir}/class_functions.sh"

echo "---------------------------------------------------------------------------------"
echo ""
echo ""
echo "                 HELLO AND WELCOME TO A BASH RPG GAME "
echo "                       LET'S START THE ADVENTURE"
echo ""
echo "---------------------------------------------------------------------------------"

cat bg_menu.txt

echo "---------------------------------------------------------------------------------"
echo ""
echo " So which Class would you like to pick : "
echo "      1) Warrior (Tank/Damage)"
echo "      2) Thief (High Damage/chance of evading)" 
echo "      3) Mage (Very high damage)"
echo "      4) Ranger (Average damage/ chance of double attack )"

while :
do
    read -r -p "Your choice [1..4]" class_nb

    case ${class_nb} in
        1)
            echo "choix : warrior"
            init_class $class_nb
            break
            ;;
        2)
            echo "choix : classe thief"
            init_class $class_nb
            break
            ;;
        3)
            echo "choix : classe Mage"
            init_class $class_nb
            break
            ;;
        4)
            echo "choix : classe Ranger"
            init_class $class_nb
            break
            ;;
        *)
            echo "Is it that hard to type a number between 1 and 4 ?"
            ;;
    esac
done


#TODO : A function that put all the data inside a txt file

 

echo "Here is your stats : "
cat "stats.txt"
#TODO : Show stats 

#get_stats

echo "---------------------------------------------------------------------------------"
echo ""
echo ""
echo ""
cat door.txt
echo " You'll now enter the dungeon"
echo "---------------------------------------------------------------------------------"
#TODO : Game_LOOP

#Test Variables
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

	echo "Room cleared , do you want to do something ?"

	echo "1) Inventory"
	echo "2) Go to the next room"
	echo "3) Quit"

	while :
	do
	    read -r -p "Your choice [1..3]" context_choice

	    case ${context_choice} in
		1)
		    #open_inventory
		    break
		    ;;
		2)
		    echo "Going to the next room..."
		    break
		    ;;
		3)
		    #TODO Méthode pour break tout le prgrm
			exit
		    ;;
		*)
		    echo "Seriously could you just type a number between 1 & 3 ?"
		    ;;
	    esac
	done
	echo "--------------------------------------------------------------------------------"
done


	



