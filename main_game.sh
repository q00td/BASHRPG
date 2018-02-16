

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

echo "----------------------------------------------------------------------"
echo " "
echo " "
echo "                 HELLO AND WELCOME TO A BASH RPG GAME "
echo "                       LET'S START THE ADVENTURE"
echo " "
echo "----------------------------------------------------------------------"

 cat bg_menu.txt


 echo "---------------------------------------------------------------------------------"
 echo ""
 echo ""
 echo ""
 echo " So which Class would you like to pick : "
 echo "      1) Warrior (Tank/Damage)"
 echo "      2) Thief (High Damage/chance of evading)" 
 echo "      3) Mage (Very high damage)"
 echo "      4) Ranger (Average damage/ chance of double attack )"
 read -p "Your choice [1..4] : " class_nb

#TODO : A function that put all the data inside a txt file
 init_class class_nb 

echo "Here is your stats : "
#TODO : Show stats 
get_stats



