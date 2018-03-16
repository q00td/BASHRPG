init_class(){
	: > stats.txt
	
	case ${1} in
        1)
            #warrior-----------------
            echo "str:9">>stats.txt
			echo "mana:2">>stats.txt
			echo "hp:50">>stats.txt
			echo "xp:0">>stats.txt
            ;;
        2)
            #thief-------------------
            echo "str:15">>stats.txt
			echo "mana:7">>stats.txt
			echo "hp:30">>stats.txt
			echo "xp:0">>stats.txt


            ;;
        3)
            #Mage--------------------
            echo "str:12">>stats.txt
			echo "mana:8">>stats.txt
			echo "hp:35">>stats.txt
			echo "xp:0">>stats.txt
            ;;
        4)
            #Ranger------------------
            echo "str:13">>stats.txt
			echo "mana:4">>stats.txt
			echo "hp:40">>stats.txt
            echo "xp:0">>stats.txt
			;;
        *)  #------------------------
            echo "Error : Wrong choice , but i don't know how you managed to do such a mistake .."
            ;;
    esac
}

choose_map(){
	rnd=$((RANDOM%10))
	case ${rnd} in
			[0-4])
				#MONSTER-----------------
				echo "Oh crap, you encounter some monsters"
				result=1
				return $result
				;;
			[5-6])
				#CHEST-------------------
				echo "Look a chest !"
				
				result=2
				return $result
				;;
			[7-10])
				#TOWN--------------------
				tableau=("Salhem" "Small town" "Hell(it's a town)") ; tab_size=${#tableau[@]} ; str=${tableau[$(( $RANDOM % tab_size ))]} 
				echo "Welcome to $str ! "
				result=3
				return $result
				;;
			*)  #------------------------
				echo "Error : how is it even possible ?"
				;;
		esac
}
play_map(){
	case ${1} in
			1)
				echo "YOU ENCOUNTER MONSTERS"
				sleep 1
				nb=$1
				#MONSTER-----------------
				nb_monster=$((RANDOM%3))
				echo "number of monster to generate : $((nb_monster + 1))"
				for ((i=0; i<=nb_monster; i++)); do
				   clear
				   line_separator_ingame
				   echo ""
				   color=("32" "31" "33" "94" "36" "96") ; color_size=${#color[@]} ; y=${color[$(( $RANDOM % color_size ))]}
				   echo -en "\e[${y}m"
				   tableau=("monster1.txt" "monster2.txt" "monster3.txt" "monster4.txt") ; tab_size=${#tableau[@]} ; cat ${tableau[$(( $RANDOM % tab_size ))]}
				   echo -en "\e[39m" 
				   echo ""
				   echo ""
				   x=$(generate_monsters)
				   echo "current monster (hp,str,xp) : $x"
				   stats_p=$(get_player_stats)
				   echo "current Player (hp,str,mana) : $stats_p"
				   line_separator_ingame
				   fight_PvM $x $stats_p
				   
				   
				   
				   #fight_monster
				done
				;;
			2)
				#CHEST-------------------
				clear
				cat chest.txt
				result=2
			
				item=$(shuf -n 1 database.txt)
				echo "You found : $item !!!"
				echo $item >> inventory.txt
				return $result
				
				;;
			3)
				#TOWN--------------------
				result=3
				return $result
				;;
			*)  #------------------------
				echo "Error : how is it even possible ?"
				;;
		esac
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

#*************************************************
# GET MAX XP OF PLAYER
#*************************************************
get_current_max_xp_player(){
	x=$(sed -n '4p' < stats.txt)
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


#*************************************************
# Fight function
#*************************************************
fight_PvM(){	
	monster=$1
	player=$2
	#------Monster---
	monster_str=$(cut -d ":" -f 2 <<< "$monster")
	monster_hp=$(cut -d ":" -f 1 <<< "$monster")
	monster_xp=$(cut -d ":" -f 3 <<< "$monster")
	#------Player----
	player_str=$(cut -d ":" -f 2 <<< "$player")
	player_hp=$(cut -d ":" -f 1 <<< "$player")
	player_mana=$(cut -d ":" -f 3 <<< "$player")
	while [ "$monster_hp" -gt "0" -a "$player_hp" -gt "0" ];
	do	
		echo ""
		echo ""
		echo "-----------------------------------------------------"
		echo -e "| \e[4mChoose an action : \e[24m                                | "							
		echo "|      1) Attack (Melee)                             |"     
		echo "|      2) Block(Slight chance to counter attack)     |" 
		echo "|      3) Run away like a Coward !                   | "

		read -r -p "| Your choice [1..3] : " choice
		echo "-----------------------------------------------------"

		case ${choice} in
			1)

				generate_dmg
				dmg=$?
				line_separator_ingame_fight
				echo "You did : $dmg DMG -> MONSTER"
				monster_hp_tmp=$monster_hp
				monster_hp=$((monster_hp_tmp - dmg))
				generate_dmg_monster monster_str
				dmg_monster=$?
				echo "Monster : $dmg DMG -> YOU"
				player_hp=$((player_hp - dmg_monster))
				echo "                             -INFO-"
				echo "[current monster (hp,str,xp) : $monster_hp:$monster_str ]                                       "
				echo "[your current state (hp,str,mana) : $player_hp:$player_str:$player_mana ]"
				line_separator_ingame_outfight

				;;
			2)
				echo "you blocked"
				;;
			3)
				if [ $((RANDOM%2)) -eq "0" ]
				then
					echo "You ran away from this fight (No XP,No L00T)"
					break
				else
					line_separator_ingame_fight
					echo "you failed to run away"
					generate_dmg_monster monster_str
					dmg_monster=$?
					echo "Monster : $dmg DMG -> YOU"
					player_hp=$((player_hp - dmg_monster))
					echo "                             -INFO-"
					echo "[current monster (hp,str,xp) : $monster_hp:$monster_str ]                                       "
					echo "[your current state (hp,str,mana) : $player_hp:$player_str:$player_mana ]"
					echo "                             ------"
					line_separator_ingame_outfight
				fi
				;;
			*)
				echo "Is it that hard to type a number between 1 and 3 ?"
				;;
		esac
		
		
	done
	get_current_max_xp_player
	xp=$?
	sed -i -e "s/^hp:[0-9]*/hp:$player_hp/g" ./stats.txt
	sed -i -e "s/^xp:[0-9]*/xp:$((xp + monster_xp))/g" ./stats.txt

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


open_inventory(){


while :
	do
	echo "     └> _____________________________________________________"
	echo -e "       |\e[4mWhat do you want to do : \e[24m                              |"
	echo "       |  1) Check your items                                |"
	echo "       |  2) Check your bag to use/drop/(Des)equip items     |"
	echo "       |  3) Quit inventory                                  |"
	echo "       ------------------------------------------------------"
	    read -r -p "Your choice [1..3]" context_choice

	    case ${context_choice} in
		1)
			liste | disp_hud
		    ;;
		2)
			liste_bagpack #merci
			equip
			
		    ;;
		3)
			clear
			break
		    ;;
		*)
		    echo "Seriously could you just type a number between 1 & 2 ?"
		    ;;
	    esac
	done
}

init(){ #CREATE ALL THE FILES TO SAVE DATA ( WEAPONS , INVENTORY ETC .. )
#: > inventory.txt
: > stats.txt
: > equipped.txt
echo "head=" >> equipped.txt
echo "hand=" >> equipped.txt
echo "offhand=" >> equipped.txt
echo "chest=" >> equipped.txt
echo "arm=" >> equipped.txt
echo "legs=" >> equipped.txt

}


liste_bagpack() {
    
	local idx=1
	echo "┌-NAME:DAMAGE/DEFENSE:CTG-┐"
	while read ligne 
	do
		echo "${idx}) $ligne"
		((idx = idx + 1 ))
		
	done < inventory.txt
	echo "└--------------------------┘"
	
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
  echo "$hand $offhand $chest"
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

equip(){
echo "     └> _____________________________________________________"
echo -e "       |\e[4mWhat do you want to do : \e[24m                        |"
echo "       |  ) Write number to equip/use                      |"
echo "       |  2) or 'q' to Quit inventory                      |"
echo "       ------------------------------------------------------"

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
			#SOCCUPER DE LA POTION DE HEAL
			break
		    ;;
		*)
		    echo "Seriously could you just type a number between 1 & 2 ?"
		    ;;
	    esac

echo $itemX
}
