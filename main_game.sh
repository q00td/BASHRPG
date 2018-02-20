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
echo " "
echo " "
echo "                 HELLO AND WELCOME TO A BASH RPG GAME "
echo "                       LET'S START THE ADVENTURE"
echo " "
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
            break
            ;;
        2)
            echo "choix : classe thief"
            break
            ;;
# etc .... à toi de faire la suite !
        *)
            echo "j'ai dit entre 1 et 4 !"
            ;;
    esac
done


#TODO : A function that put all the data inside a txt file

init_class $class_nb 

echo "Here is your stats : "
#TODO : Show stats 

#get_stats

echo "---------------------------------------------------------------------------------"
echo "..."
echo ""
echo ""
echo ""
cat door.txt
echo " You'll now enter the dungeon"
#TODO : Game_LOOP
