

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

my_dir="$(dirname "$0")"
"$my_dir/class_functions.sh"

source "class_functions.sh"

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
echo "Your choice [1..4] : " 
read class_nb

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



































init_class(){
	
    touch stats.txt	
	> stats.txt
	if [ $1 -eq "1" ]
		then
		echo "You chose Warrior"
		echo "str:5">stats.txt
		echo "mana:2">stats.txt
		echo "hp:15">stats.txt

	elif [ $1 -eq "2" ]
		then
		echo "You chose Thief"
		echo "str:5">stats.txt
		echo "mana:2">stats.txt
		echo "hp:15">stats.txt

	elif [ $1 -eq "3" ]
		then
		echo "You chose Mage"
		echo "str:5">stats.txt
		echo "mana:2">stats.txt
		echo "hp:15">stats.txt

	elif [ $1 -eq "4" ]
		then
		echo "You chose Ranger"
		echo "str:5">stats.txt
		echo "mana:2">stats.txt
		echo "hp:15">stats.txt
	fi
}