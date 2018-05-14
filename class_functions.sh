init_class(){
	: > stats.txt
	
	case ${1} in
        1)
            #warrior-----------------
            echo "str:9">>stats.txt
			echo "mana:2">>stats.txt
			echo "hp:50">>stats.txt
			echo "xp:0">>stats.txt
			echo "base_hp:50">>stats.txt
			echo "gold:30">>stats.txt
			echo "warrior">>stats.txt
			echo "lvl:1">>stats.txt
            ;;
        2)
            #thief-------------------
            echo "str:15">>stats.txt
			echo "mana:7">>stats.txt
			echo "hp:30">>stats.txt
			echo "xp:0">>stats.txt
			echo "base_hp:30">>stats.txt
			echo "gold:30">>stats.txt
			echo "thief">>stats.txt
			echo "lvl:1">>stats.txt



            ;;
        3)
            #Mage--------------------
            echo "str:12">>stats.txt
			echo "mana:8">>stats.txt
			echo "hp:35">>stats.txt
			echo "xp:0">>stats.txt
			echo "base_hp:35">>stats.txt
			echo "gold:30">>stats.txt
			echo "mage">>stats.txt
			echo "lvl:1">>stats.txt

            ;;
        4)
            #Ranger------------------
            echo "str:13">>stats.txt
			echo "mana:4">>stats.txt
			echo "hp:40">>stats.txt
            echo "xp:0">>stats.txt
			echo "base_hp:40">>stats.txt
			echo "gold:30">>stats.txt
			echo "ranger">>stats.txt
			echo "lvl:1">>stats.txt

			;;
        *)  #------------------------
            echo "Error : Wrong choice , but i don't know how you managed to do such a mistake .."
            ;;
    esac
}

test_hud(){

	clear
	
	ecran=$(stty size | {
	read y x
	for((i=0;i<10;i++)) ; do
		printf "\e[%d;%dH%s" "$((i))" "$((x))" "│"
	done
	for((i=0;i<$((y-3));i++)) ; do
		printf "\e[%d;%dH%s" "$((i))" "$((x-15))" "│"
	done
	for((i=1;i<15;i++))     ; do
		printf "\e[%d;%dH%s" "0" "$((x-i))" "─"
	done
	for((i=1;i<15;i++)) ; do
		printf "\e[%d;%dH%s" "10" "$((x-i))" "─"
	done 
	for((i=1;i<15;i++)) ; do
		printf "\e[%d;%dH%s" "3" "$((x-i))" "─"
	done 
	
	
		for((i=0;i<x;i++))     ; do
		printf "\e[%d;%dH%s" "$((y-3))" "$((i))" "─"
	done
	
	

	z=$(cat stats.txt)

	a=$(printf "%s" "$z" | sed -n '1p')
	printf "\e[$((4));$((x-11))H"
	printf %s "$a"

	a=$(printf "%s" "$z" | sed -n '2p')
	printf "\e[$((5));$((x-11))H"
	printf %s "$a"

	a=$(printf "%s" "$z" | sed -n '3p')
	printf "\e[$((6));$((x-11))H"
	printf %s "$a"

	a=$(printf "%s" "$z" | sed -n '4p')
	printf "\e[$((7));$((x-11))H"
	printf %s "$a"

	a=$(printf "%s" "$z" | sed -n '6p')
	printf "\e[$((8));$((x-11))H"
	printf %s "$a"

	a=$(printf "%s" "$z" | sed -n '8p')
	printf "\e[$((9));$((x-11))H"
	printf %s "$a"

	printf "\e[$((2));$((x-11))H"
	printf %s "STATS : "

	printf "\e[$((0));$((x))H"
	printf %s "┐"
	printf "\e[$((0));$((x-15))H"
	printf %s "┌"
	printf "\e[$((y-3));$((x-15))H"
	printf %s "┘"
	printf "\e[$((10));$((x))H"
	printf %s "┘"
	printf "\e[$((10));$((x-15))H"
	printf %s "└"

	printf "\e[$((0));$((0))H"

	printf "\e[$((y));$((x-80))H"

	mhp=$(printf "%s" "$z" | sed -n '5p' | cut -d ":" -f 2)
	hp=$(printf "%s" "$z" | sed -n '3p'| cut -d ":" -f 2)
	mana=$(printf "%s" "$z" | sed -n '2p'| cut -d ":" -f 2)
	bar HP $hp $mhp
	printf "\e[$((y-1));$((x-80))H"
	bar MANA $mana 10
	
	
	printf "\e[$((0));$((0))H"


} 
)
echo $ecran
}

choose_map(){
	clear
	test_hud
	rnd=$((RANDOM%10))
	case ${rnd} in
			[0-6])
				#MONSTER-----------------
				echo "Oh crap, you encounter some monsters"
				result=1
				return "$result"
				;;
			7)
				#CHEST-------------------
				echo "Look a chest !"
				
				result=2
				return "$result"
				;;
			[8-9])
				clear
				test_hud
				#TOWN--------------------
				tableau=("Salhem" "Small town" "Hell(it's a town)") ; tab_size=${#tableau[@]} ; str=${tableau[$(( $RANDOM % tab_size ))]}
				echo ""
				tableau=("salhem.txt" "smalltown.txt" "hell.txt") ; tab_size=${#tableau[@]} ; cat ${tableau[$(( $RANDOM % tab_size ))]}
				
				tell_story1 "Welcome to $str ! "
				result=3
				echo ""
				return "$result"

				;;
			*)  #------------------------
				;;
		esac
}
tell_story1(){ #For the little scene in the intro
	echo ""
	str="$1"
	
	for (( i=0; i<${#str}; i++ )); do
		printf -v t "0.%0.2d" "$((RANDOM % 15))"
		read -t $t -n1 -s &&  echo "${str:$((i))}" && break || printf "${str:$i:1}"
	done
	
	
}
tell_story2(){ #For the little scene in the intro
	echo ""
	str="$1"
	
	for (( i=0; i<${#str}; i++ )); do
		printf -v t "0.%0.2d" "$((RANDOM % 15))"
		read -t $t -n1 -s &&  echo "${str:$((i))}" && break || printf "${str:$i:1}"
	done
	read -n1 -s ; clear
	test_hud
}
play_map(){
	case ${1} in
			1)
				tell_story2 "Monsters are attacking you !"
				sleep 1
				nb=$1
				#MONSTER-----------------
				nb_monster=$((RANDOM%3+1))
				for ((i=0; i<=nb_monster; i++)); do
				   clear
				   test_hud
				   color=("32" "31" "33" "94" "36" "96") ; color_size=${#color[@]} ; y=${color[$(( $RANDOM % color_size ))]}
				   echo -en "\e[${y}m"
				   tableau=("monster1.txt" "monster2.txt" "monster3.txt" "monster4.txt") ; tab_size=${#tableau[@]} ; monster=${tableau[$(( $RANDOM % tab_size ))]}
				   echo -en "\e[39m" 
				   x=$(generate_monsters)
				   stats_p=$(get_player_stats)
				   fight_PvM $x $stats_p $monster
				   
				   
				   
				   #fight_monster
				done
				sleep 1
				clear
				test_hud
				
				;;
			2)
				#CHEST-------------------
				clear
				test_hud
				cat chest.txt
				result=2
			
				item=$(shuf -n 1 database.txt)
				tell_story1 "You found : $item !!!"
				echo $item >> inventory.txt
				return $result
				;;
			3)
				#TOWN--------------------
				: > shop.txt
				init_shop
				play_town
				result=3
				return $result
				;;
			*)  #------------------------
				echo "Error : how is it even possible ?"
				;;
		esac
}
get_defense(){
	x=$(cat equipped.txt)
	a=$(printf "%s" "$x" | sed -n '1p')
	a=$(echo $a | sed 's/[^0-9]*//g')
	if [ ${#a} -eq 0 ];
	then 
	a=0 
	fi

	b=$(printf "%s" "$x" | sed -n '3p')
	b=$(echo $b | sed 's/[^0-9]*//g')
	if [ ${#b} -eq 0 ];
	then 
	b=0 
	fi
	c=$(printf "%s" "$x" | sed -n '4p')
	c=$(echo $c | sed 's/[^0-9]*//g')
	if [ ${#c} -eq 0 ];
	then 
	c=0 
	fi
	d=$(printf "%s" "$x" | sed -n '4p')
	d=$(echo $d | sed 's/[^0-9]*//g')
	if [ ${#d} -eq 0 ];
	then 
	d=0 
	fi
	e=$(printf "%s" "$x" | sed -n '6p')
	e=$(echo $e | sed 's/[^0-9]*//g')
	if [ ${#e} -eq 0 ];
	then 
	e=0 
	fi
	return  "$(( a + b + c + d + e ))"	
}	
low_hp(){
	if [ $1 -lt 10 ];
		then
		echo -e "\e[5m \e[31m $1 \e[0m"
	else
		echo "$1"
	fi
}
get_attack(){
	x=$(cat equipped.txt)
	e=$(printf "%s" "$x" | sed -n '2p')
	e=$(echo $e | sed 's/[^0-9]*//g')
	if [ ${#e} -eq 0 ];
	then 
	e=0 
	fi
	return $e
}
play_town(){
while :
do
	echo "┌────────────────────────────────────────────────────┐"
			echo -e "| \e[4mChoose an action : \e[24m                                | "							
			echo "│      1) Shop.                                      │"     
			echo "│      2) Sell.                                      │"     
			echo "│      3) Rest.                                      │" 
			echo "│      4) Leave.                                     │ "

			read -r -p "| Your choice [1..4] : " choice
			echo "└───────────────────────────────────────────────────┘"

			case ${choice} in
				1)
					shop
					;;
				2)
					sell
					;;
				3)
					get_current_max_base_hp_player
					hp=$?
					sed -i -e "s/^hp:[0-9]*/hp:$((hp))/g" ./stats.txt
					sed -i -e "s/^mana:[0-9]*/mana:5/g" ./stats.txt
					clear
					test_hud
					cat nurse.txt
					tell_story2 " You have been healed .. "
					clear
					test_hud
					;;
				4)
					clear
					break
					;;
				*)
					clear
					test_hud
					echo "Is it that hard to type a number between 1 and 3 ?"
					;;
			esac
done


}
init_shop(){
local IFS=$'\n'
for i in `shuf -n 5 database.txt`; do
	echo "$i:$((RANDOM%20 + 20))" >> shop.txt
	done
}
shop(){
clear
test_hud
cat shop.txt | disp_hud_shop
echo "     └>┌───────────────────────────────────────────────────┐"
echo -e "       |\e[4mWhat do you want to do : \e[24m                          |"
echo "       │  X) Write number to equip/use                     │"
echo "       │  q) or 'q' to Quit Shop                           │"
echo "       └───────────────────────────────────────────────────┘"
get_current_gold_player
gold="$?"
echo "       YOU HAVE $gold GOLD\$"

while :
	do
	    read -r -p "Your choice : " context_choice

	    case ${context_choice} in
		[0-9]*)
			buy_item ${context_choice}
			break
		    ;;
		q)
			break
		    ;;
		*)
		    echo "Seriously could you just type a number between 1 & 2 ?"
		    ;;
	    esac
	done
}

sell(){
clear
test_hud
cat inventory.txt | disp_hud_sell
echo "     └>┌───────────────────────────────────────────────────┐"
echo -e "       |\e[4mWhat do you want to do : \e[24m                          |"
echo "       │  X) Write number to sell                          │"
echo "       │  q) or 'q' to Quit Shop                           │"
echo "       └───────────────────────────────────────────────────┘"
get_current_gold_player
gold="$?"
echo "       YOU HAVE $gold GOLD\$"

while :
	do
	    read -r -p "Your choice : " context_choice

	    case ${context_choice} in
		[0-9]*)
			sell_item ${context_choice}
			break
		    ;;
		q)
			break
		    ;;
		*)
		    echo "Seriously could you just type a number between 1 & 2 ?"
		    ;;
	    esac
	done
}


buy_item(){
y=$1 #chiffre correspondant a une ligne dans l'inventaire
itemX=$(sed -n ${y}p < shop.txt) #on récupere la string correspondant
pos=$(cut -d ":" -f 4 <<< "$itemX") # on extrait les golds pour le Case
get_current_gold_player
gold="$?"
if [ "$gold" -ge "$pos" ]
then
	sed -i -e "s/^gold:[0-9]*/gold:$(( gold - pos ))/g" ./stats.txt
	echo $itemX | cut -d":" -f1,2,3 >> inventory.txt
	echo "Ka-Ching !"
else
	echo "You don't have enough golds"
	sleep 1
fi
	

echo ""
clear
test_hud
}

sell_item(){
y=$1 #chiffre correspondant a une ligne dans l'inventaire
itemX=$(sed -n ${y}p < inventory.txt) #on récupere la string correspondant

echo $itemX
get_current_gold_player
sed -i -e "s/^gold:[0-9]*/gold:$((gold + 5))/g" ./stats.txt
sed -i -e "/^${itemX}/d" inventory.txt
tell_story1 "Ka-Ching !"
echo ""

test_hud

}


#*************************************************
# MONSTER GENERATION
#*************************************************
generate_monsters(){
	generate_hp_monster
	hp=$?
	generate_str_monster
	str=$?
	generate_xp_monster
	xp=$?
	string="$hp:$str:$xp"
echo $string
}

#*************************************************
# HP MONSTER GENERATION
#*************************************************
generate_hp_monster(){
	get_current_max_hp_player
	hp=$?
	hp_monster=$((RANDOM%hp + 10 ))
return $hp_monster
}

#*************************************************
# STR MONSTER GENERATION
#*************************************************
generate_str_monster(){
	get_current_max_str_player 
	str=$?
	str_monster=$((RANDOM%str))
return $str_monster
}

#*************************************************
# XP MONSTER GENERATION
#*************************************************
generate_xp_monster(){
	xp_monster=$((RANDOM%15 + 1))
	return $xp_monster
}

#*************************************************
# PLAYER STATS
#*************************************************
get_player_stats(){

	get_current_max_hp_player
	local hp=$?
	get_current_max_str_player
	local str=$?
	get_current_max_mana_player
	local mana=$?
	string="$hp:$str:$mana"
	echo $string
}


#*************************************************
# GET MAX HP OF PLAYER
#*************************************************
get_current_max_hp_player(){
	x=$(sed -n '3p' < stats.txt)
	hp=$(cut -d ":" -f 2 <<< "$x")
return $hp
}
check_hp(){
	if [ "$1" -lt "0" ] || [ "$1" -eq "0" ];
		then
		echo "-----YOU LOOOOOSTTTTT-----"
		exit
	fi
}
get_current_max_base_hp_player(){
	x=$(sed -n '5p' < stats.txt)
	base_hp=$(cut -d ":" -f 2 <<< "$x")
return $base_hp
}
#*************************************************
# GET MAX XP OF PLAYER
#*************************************************
get_current_max_xp_player(){
	x=$(sed -n '4p' < stats.txt)
	xp=$(cut -d ":" -f 2 <<< "$x")
return $xp
}

#*************************************************
# GET LEVEL OF PLAYER
#*************************************************
get_current_level_player(){
	x=$(sed -n '8p' < stats.txt)
	lvl=$(cut -d ":" -f 2 <<< "$x")
return $lvl
}


#*************************************************
# GET GOLD OF PLAYER
#*************************************************
get_current_gold_player(){
	x=$(sed -n '6p' < stats.txt)
	xp=$(cut -d ":" -f 2 <<< "$x")
return $xp
}
#*************************************************
# GET MAX STR OF PLAYER
#*************************************************
get_current_max_str_player(){
	x=$(sed -n '1p' < stats.txt)
	str=$(cut -d ":" -f 2 <<< "$x")
return $str
}

#*************************************************
# GET MAX MANA OF PLAYER
#*************************************************
get_current_max_mana_player(){
	x=$(sed -n '2p' < stats.txt)
	mana=$(cut -d ":" -f 2 <<< "$x")
return $mana
}

get_current_gold_player(){
	x=$(sed -n '6p' < stats.txt)
	mana=$(cut -d ":" -f 2 <<< "$x")
return $mana
}


#*************************************************
# Fight function
#*************************************************
fight_PvM(){	

	dmg_player="x"
	dmg_final=0
	get_attack
	attack="$?"
	get_defense
	def="$?"
	
	monster=$1
	player=$2
	#------Monster---
	monster_str=$(cut -d ":" -f 2 <<< "$monster")
	monster_hp=$(cut -d ":" -f 1 <<< "$monster")
	monster_mhp=$monster_hp
	monster_xp=$(cut -d ":" -f 3 <<< "$monster")
	#------Player----
	player_str=$(cut -d ":" -f 2 <<< "$player")
	player_hp=$(cut -d ":" -f 1 <<< "$player")
	player_mana=$(cut -d ":" -f 3 <<< "$player")
	while [ "$monster_hp" -gt "0" -a "$player_hp" -gt "0" ];
	do	
		echo -en "\e[${y}m"
	    cat $3
	    echo -en "\e[39m" 
		echo ""
		echo ""
		if [[ "$dmg_player" != "x" ]];
			then
		echo "You did : $dmg_player DMG -> MONSTER"
		echo "Monster : $dmg_final DMG -> YOU"
		fi
		echo "┌────────────────────────────────────────────────────┐"
		echo -e "| \e[4mChoose an action : \e[24m                                | "							
		echo "│      1) Attack (Melee)                             │"     
		echo "│      2) Special attack (MP)                        │"
		echo "│      3) Run away like a Coward !                   │ "

		read -r -p "| Your choice [1..3] : " choice
		echo "└────────────────────────────────────────────────────┘"

		case ${choice} in
			1)

				generate_dmg
				dmg=$?
				clear
				echo ""
				test_hud
				monster_hp_tmp=$monster_hp
				dmg_player=$((dmg + attack))
				monster_hp=$((monster_hp_tmp - dmg - attack))
				generate_dmg_monster monster_str
				dmg_monster=$?
				
				if [ $(( dmg_monster - def )) -lt "0" ]
				then
					dmg_final=0
				else
					dmg_final="$(( dmg_monster - def ))"
				fi
				player_hp=$((player_hp - dmg_final))
				check_hp $player_hp
				sed -i -e "s/^hp:[0-9]*/hp:$player_hp/g" ./stats.txt
				printf "\e[$((0));$((0))H"
				bar MONSTER_HP $monster_hp $monster_mhp
				printf "\e[$((0));$((0))H"
				echo ""
				
				

				;;
		
			2)
			clear
			echo ""
			sed -i -e "s/^hp:[0-9]*/hp:$player_hp/g" ./stats.txt
			test_hud
			class=$(get_class)

			if [ $player_mana -gt "0" ]
				then
				case ${class} in
				"warrior")
					generate_magic_dmg_warrior
					dmg=$?
					monster_hp=$((monster_hp - dmg))
				    ;;
				"thief")
					generate_magic_dmg_thief
					dmg=$?
					monster_hp=$((monster_hp - dmg))
				    ;;
				"mage")
					generate_magic_dmg_mage
					dmg=$?
					monster_hp=$((monster_hp - dmg))
				    ;;
				"ranger")
					generate_magic_dmg_ranger
					dmg=$?
					monster_hp=$((monster_hp - dmg))
				    ;;
	   		esac
	   		player_mana=$((player_mana - 1 ))
			sed -i -e "s/^mana:[0-9]*/mana:$player_mana/g" ./stats.txt
			echo "You did : $dmg DMG -> MONSTER"
			generate_dmg_monster monster_str
			dmg_monster=$?
				
			if [ $(( dmg_monster - def )) -lt "0" ]
				then
					dmg_final=0
				else
					dmg_final="$(( dmg_monster - def ))"
				fi
				
			echo "Monster : $dmg DMG -> YOU"
			player_hp=$((player_hp - dmg_final))

			printf "\e[$((0));$((0))H"
			bar MONSTER_HP $monster_hp $monster_mhp
			printf "\e[$((0));$((0))H"

			echo ""

			else
				echo "You dont have any MP"
			fi
			
			check_hp $player_hp
			;;
			3)
				if [ $((RANDOM%2)) -eq "0" ]
				then
					echo "You ran away from this fight (No XP,No L00T)"
					break
				else
					echo ""
					
					echo "you failed to run away"
					clear
					test_hud
					generate_dmg_monster monster_str
					dmg_monster=$?
					echo "Monster : $dmg DMG -> YOU"
					player_hp=$((player_hp - dmg_monster))

					printf "\e[$((0));$((0))H"
					bar MONSTER_HP $monster_hp $monster_mhp
					printf "\e[$((0));$((0))H"


					echo ""
				fi
				check_hp $player_hp
				sleep 1
				clear
				sed -i -e "s/^hp:[0-9]*/hp:$player_hp/g" ./stats.txt
				test_hud
				;;
			*)
				clear
				sed -i -e "s/^hp:[0-9]*/hp:$player_hp/g" ./stats.txt
				test_hud
				echo "Is it that hard to type a number between 1 and 3 ?"
				;;
		esac
		
		
	done
	cat cup.txt
		tell_story2 " You survived this fight !!!..."
	get_current_max_xp_player
	xp=$?
	sed -i -e "s/^hp:[0-9]*/hp:$player_hp/g" ./stats.txt
	if [ ! "$monster_hp" -gt "0" ] ;
	then
		
		
		sed -i -e "s/^xp:[0-9]*/xp:$((xp + monster_xp))/g" ./stats.txt
		get_current_gold_player
		gold=$?
		sed -i -e "s/^gold:[0-9]*/gold:$((RANDOM%10 + gold))/g" ./stats.txt
		check_xp
	fi
	

}
get_class(){
	tmp=$(sed -n 7p stats.txt) #ON RECUPERE CURRENT WEAPON
	echo $tmp

}
generate_magic_dmg_warrior(){

	get_current_max_hp_player
	hp=$?
	get_current_max_base_hp_player
	mhp=$?
	if [ "$((hp+5))" -gt "$mhp" ];
		then
		sed -i -e "s/^hp:[0-9]*/hp:$mhp/g" ./stats.txt
	else
		sed -i -e "s/^hp:[0-9]*/hp:$(( hp + 5 ))/g" ./stats.txt
	fi
	return $((RANDOM%10 + 10))
}
generate_magic_dmg_mage(){
	return $((RANDOM%15 + 15))
}
generate_magic_dmg_thief(){
	shuf -n1 database.txt >> inventory.txt
	return $((RANDOM%5 + 5))
}
generate_magic_dmg_ranger(){
	return $((RANDOM%10 + 10))
}

line_separator_ingame(){
echo "--------------| F I G H T----------------S T A R T I N G |--------------"
}
line_separator_ingame_fight(){
echo "         /_________________               _________________\ "
echo "<=======| _________________>  F I G H T  <_________________ |=======>"
echo "         \                                                 / "
}
line_separator_ingame_outfight(){
echo "_________________________________________________________________"
}

generate_dmg(){
	x=$(sed -n '1p' < stats.txt)
	str=$(cut -d ":" -f 2 <<< "$x")
	str_p=$(echo "$str" | sed 's/-//g')

	dmg=$((RANDOM%str)) #TODO CHANGE DAMAGE RATE1
	return $dmg
}

generate_dmg_monster(){
	str_tmp=$1
	str=$((str_tmp + 1 ))
	dmg=$((RANDOM%str)) #TODO CHANGE DAMAGE RATE1
	return $dmg
}

check_xp(){
get_current_max_xp_player
xp=$?
get_current_level_player
lvl=$?
if [ $xp -gt 20 ]
	then
	sed -i -e "s/^xp:[0-9]*/xp:0/g" ./stats.txt
	sed -i -e "s/^lvl:[0-9]*/lvl:$((lvl + 1))/g" ./stats.txt

	upstat
fi
}

upstat(){
get_current_max_base_hp_player
base_hp=$?
sed -i -e "s/^base_hp:[0-9]*/base_hp:$((base_hp+5))/g" ./stats.txt
sed -i -e "s/^hp:[0-9]*/hp:$((base_hp + 5))/g" ./stats.txt

get_current_max_str_player
str=$?
cat victory.txt
sleep 1
sed -i -e "s/^str:[0-9]*/str:$(( str + 5 ))/g" ./stats.txt
sed -i -e "s/^mana:[0-9]*/mana:$((10))/g" ./stats.txt

}
open_inventory(){


while :
	do
	echo "     └>┌─────────────────────────────────────────────────────┐"
	echo -e "       |\e[4mWhat do you want to do : \e[24m                            │"
	echo "       │  1) Check your items                                │"
	echo "       │  2) Check your bag to use/drop/(Des)equip items     │"
	echo "       │  3) Quit inventory                                  │"
	echo "       └─────────────────────────────────────────────────────┘"
	    read -r -p "Your choice [1..3]" context_choice

	    case ${context_choice} in
		1)
			clear
			test_hud
			liste | disp_hud
		    ;;
		2)
			clear
			test_hud
			cat inventory.txt | liste_bagpack #merci
			equip
			clear
			test_hud
			
		    ;;
		3)
			clear
			test_hud
			break
		    ;;
		*)
		    echo "Seriously could you just type a number between 1 & 2 ?"
		    ;;
	    esac
	done
	clear
	test_hud
}

init(){ #CREATE ALL THE FILES TO SAVE DATA ( WEAPONS , INVENTORY ETC .. )
#: > inventory.txt
: > stats.txt
: > equipped.txt
shuf -n1 database.txt > inventory.txt
: > shop.txt
{
echo "head="
echo "hand="
echo "offhand="
echo "chest="
echo "arm="
echo "legs=" 
} >> equipped.txt
}


liste_bagpack() {
 x=1
 local idx
  printf "┌%*s┬%*s┐\n" "40" "-Name- " "10" "-Power-" | sed 's/ /─/g ; s/-/ /g'
  while read l ; do
    un=${l%%:*}
    deux=${l#$un:}
    deux=${deux%%:*}

    padding=$(( -40 - $(wc -c <<<$l) + ${#l} +1 ))
    printf "│%*s│%*s│\n" "$padding" "${x})$un" "10" "$deux"
	((x++))
  done
  printf "└%*s┴%*s┘\n" "40" "" "10" "" | sed 's/ /─/g'
	
}

liste() {
  x=$(sed -n '1p' < equipped.txt)
  head=$(cut -d "=" -f 2 <<< "$x")
  echo "$head"
  y=$(sed -n '2p' < equipped.txt)
  hand=$(cut -d "=" -f 2 <<< "$y")
  z=$(sed -n '3p' < equipped.txt)
  offhand=$(cut -d "=" -f 2 <<< "$z")
  alpha=$(sed -n '4p' < equipped.txt)
  chest=$(cut -d "=" -f 2 <<< "$alpha")

  arm=$(sed -n '4p' < equipped.txt)
  arm2=$(cut -d "=" -f 2 <<< "$arm")

  echo "$hand $offhand $chest $arm2"
  beta=$(sed -n '6p' < equipped.txt)
  leg=$(cut -d "=" -f 2 <<< "$beta")
  echo "$leg"
}


disp_hud() {
  declare -a right=(
" o     "
" /|\    "
" / \    "
)
  local idx
  printf "┌%*s┬%*s┐\n" "40" "-Status- " "10" "" | sed 's/ /─/g ; s/-/ /g'
  while read l ; do
    padding=$(( -40 - $(wc -c <<<$l) + ${#l} +1 ))
    printf "│%*s│%*s│\n" "$padding" "$l" "10" "${right[$((idx++))]}"
  done
  printf "└%*s┴%*s┘\n" "40" "" "10" "" | sed 's/ /─/g'
}
disp_hud_stats() {
  declare -a right=(
" o     "
" /|\    "
" / \    "
)
  local idx
  printf "┌%*s┐\n" "40" "-Stats- " | sed 's/ /─/g ; s/-/ /g'
  while read l ; do
    padding=$(( -40 - $(wc -c <<<$l) + ${#l} +1 ))
    printf "│%*s│\n" "$padding" "$l"
  done
  printf "└%*s┘\n" "40" ""  | sed 's/ /─/g'
}

disp_hud_shop() {
  declare -a right=(
" o     "
" /|\    "
" / \    "
)
  local idx
x=1
  printf "┌%*s┬%*s┬%*s┐\n" "40" "-Item- " "10" "Power" "10" "Price" | sed 's/ /─/g ; s/-/ /g'
  while read l ; do
	
    un=${l%%:*}
    deux=${l#$un:}
    deux=${deux%%:*}
	trois=${l#$un:$deux:}
	trois=${trois%%:*}
    quatre=${l##*:}
    padding=$(( -40 - $(wc -c <<<$un) + ${#un} +1 ))
    printf "│%*s│%*s│%*s│\n" "$padding" "${x})$un" "10" "$deux" "10" "$quatre"
	((x++))
  done
  printf "└%*s┴%*s┴%*s┘\n" "40" "" "10" "" "10" "" | sed 's/ /─/g'
}


disp_hud_sell() {

  local idx
  printf "┌%*s┬%*s┐\n" "40" "-Status- " "10" "" | sed 's/ /─/g ; s/-/ /g'
  while read l ; do
    padding=$(( -40 - $(wc -c <<<$l) + ${#l} +1 ))
    printf "│%*s│%*s│\n" "$padding" "$l" "10" ""
  done
  printf "└%*s┴%*s┘\n" "40" "" "10" "" | sed 's/ /─/g'
}


equip(){
echo "     └>┌───────────────────────────────────────────────────┐"
echo -e "       │\e[4mWhat do you want to do : \e[24m                          │"
echo "       │  X) Write number to equip/use                     │"
echo "       │  q) or 'q' to Quit inventory                      │"
echo "       └───────────────────────────────────────────────────┘"

while :
	do
	    read -r -p "Your choice : " context_choice

	    case ${context_choice} in
		[0-9]*)
			use_item ${context_choice}
			break
		    ;;
		q)
			break
		    ;;
		*)
		    echo "Seriously could you just type a number between 1 & 2 ?"
		    ;;
	    esac
	done
}

waiting2(){
sleep 2
}

use_item(){

#Reproduire le bug
#1) Acceder a l'inventaire
#2) Check your bag to use/drop/(Des)equip items 
#3) choisir un chiffre pour équipper l'item


y=$1 #chiffre correspondant a une ligne dans l'inventaire
itemX=$(sed -n ${y}p < inventory.txt) #on récupere la string correspondant
pos=$(cut -d ":" -f 3 <<< "$itemX") # on extrait la catégorie pour le Case

#PB : Ne rentrera jamais dans le case 
#Solution bizarre : pré-remplire le fichier inventory.txt 

case ${pos} in
		p)
			tmp=$(sed -n 2p equipped.txt) #ON RECUPERE CURRENT WEAPON
			tmp_x=$(cut -d "=" -f 2 <<< "$tmp")
			echo $tmp_x >> inventory.txt # ON L'ENVOIE DANS L'INVENTAIRE
			sed -i -e "s/^hand=.*$/hand=$itemX/" ./equipped.txt # ET ON REMPLACE
			sed  -i -e "s/$itemX//" ./inventory.txt
			sed -i '/^$/d' ./inventory.txt
			break
		    ;;
		d)
			tmp=$(sed -n 3p equipped.txt) #ON RECUPERE CURRENT WEAPON
			tmp_x=$(cut -d "=" -f 2 <<< "$tmp")
			echo $tmp_x >> inventory.txt # ON L'ENVOIE DANS L'INVENTAIRE
			sed -i -e "s/^offhand=.*$/offhand=$itemX/" ./equipped.txt # ET ON REMPLACE
			sed  -i -e "s/$itemX//" ./inventory.txt
			sed -i '/^$/d' ./inventory.txt
			break
		    ;;
		c)
			tmp=$(sed -n 4p equipped.txt) #ON RECUPERE CURRENT WEAPON
			tmp_x=$(cut -d "=" -f 2 <<< "$tmp")
			echo $tmp_x >> inventory.txt # ON L'ENVOIE DANS L'INVENTAIRE
			sed -i -e "s/^chest=.*$/chest=$itemX/" ./equipped.txt # ET ON REMPLACE
			sed  -i -e "s/$itemX//" ./inventory.txt
			sed -i '/^$/d' ./inventory.txt
			break
		    ;;
		hl)
			tmp=$(sed -n 1p equipped.txt) #ON RECUPERE CURRENT WEAPON
			tmp_x=$(cut -d "=" -f 2 <<< "$tmp")
			echo $tmp_x >> inventory.txt # ON L'ENVOIE DANS L'INVENTAIRE
			sed -i -e "s/^head=.*$/head=$itemX/" ./equipped.txt # ET ON REMPLACE
			sed  -i -e "s/$itemX//" ./inventory.txt
			sed -i '/^$/d' ./inventory.txt
			break
		    ;;
		l)
			tmp=$(sed -n 6p equipped.txt) #ON RECUPERE CURRENT WEAPON
			tmp_x=$(cut -d "=" -f 2 <<< "$tmp")
			echo $tmp_x >> inventory.txt # ON L'ENVOIE DANS L'INVENTAIRE
			sed -i -e "s/^legs=.*$/legs=$itemX/" ./equipped.txt # ET ON REMPLACE
			sed  -i -e "s/$itemX//" ./inventory.txt
			sed -i '/^$/d' ./inventory.txt
			break
		    ;;
		g)
			tmp=$(sed -n 5p equipped.txt) #ON RECUPERE CURRENT WEAPON
			tmp_x=$(cut -d "=" -f 2 <<< "$tmp")
			echo $tmp_x >> inventory.txt # ON L'ENVOIE DANS L'INVENTAIRE
			sed -i -e "s/^arm=.*$/arm=$itemX/" ./equipped.txt # ET ON REMPLACE
			sed  -i -e "s/$itemX//" ./inventory.txt
			sed -i '/^$/d' ./inventory.txt
			break
		    ;;
		h)
			#SOCCUPER DE LA POTION DE HEAL
			get_current_max_hp_player
			hp=$?
			sed -i -e "s/^hp:[0-9]*/hp:$(( hp + 15 ))/g" ./stats.txt
			sed -i '/^heal/d' ./inventory.txt
			break
		    ;;
		m)
			#SOCCUPER DE LA POTION DE Mana
			sed -i -e "s/^hp:[0-9]*/hp:5/g" ./stats.txt
			sed -i '/^mana/d' ./inventory.txt
			break
			break
		    ;;
		*)
		    echo "Seriously could you just type a number between 1 & 2 ?"
		    ;;
	    esac

echo $itemX
}

bar(){
	
	
    colorReset=$(tput sgr0)
    colorRed=$(tput bold; tput setaf 1)
    colorYellow=$(tput bold; tput setaf 3)
    colorBlue=$(tput bold; tput setaf 4)

    text=$1
    current=$2
    total=$3

	if [ "$current" -lt "0" ]; then
        current="0"
    fi

    PERCENTAGE=$(( 100*(current)/total ))
    BAR_PROGRESS=$(( PERCENTAGE/2  ))



    if [ $PERCENTAGE -eq 100 ]; then
        (( BAR_PROGRESS-- ))
    fi
    [[ ${PERCENTAGE} -gt 25 ]] && printf "${text} [" || printf "${colorYellow}${text}${colorReset} ["
    if [[ "${text}" == "MANA" ]]; then
        printf "${colorBlue}%-*s${colorReset}" $((BAR_PROGRESS+1)) | tr ' ' '#'
    else
        printf "${colorRed}%-*s${colorReset}" $((BAR_PROGRESS+1)) | tr ' ' '#'
    fi
    printf "%*s" $((50-BAR_PROGRESS)) | tr ' ' '-'
    printf '] '
    [[ ${PERCENTAGE} -gt 25 ]] && printf "${current} / ${total}" || printf "${colorYellow}${current}${colorReset} / ${total}"
}

