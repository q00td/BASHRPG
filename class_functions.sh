init_class(){
	: > stats.txt
	
	case ${1} in
        1)
            #warrior-----------------
            echo "str:6">>stats.txt
			echo "mana:2">>stats.txt
			echo "hp:15">>stats.txt
            ;;
        2)
            #thief-------------------
            echo "str:7">>stats.txt
			echo "mana:7">>stats.txt
			echo "hp:7">>stats.txt

            ;;
        3)
            #Mage--------------------
            echo "str:8">>stats.txt
			echo "mana:8">>stats.txt
			echo "hp:8">>stats.txt
            ;;
        4)
            #Ranger------------------
            echo "str:9">>stats.txt
			echo "mana:4">>stats.txt
			echo "hp:4">>stats.txt
            ;;
        *)  #------------------------
            echo "Error : Wrong choice , but i don't know how you managed to do such a mistake .."
            ;;
    esac
}

choose_map(){
	rnd=$((RANDOM%3))
	echo "map randomed : $rnd"
	case ${rnd} in
			0)
				#MONSTER-----------------
				echo "Oh crap, you encounter some monsters"
				result=1
				return $result
				;;
			1)
				#CHEST-------------------
				echo "Look a chest !"
				result=2
				return $result
				;;
			2)
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
				nb=$1
				#MONSTER-----------------
				nb_monster=$((RANDOM%3))
				echo "number of monster to generate : $((nb_monster + 1))"
				for ((i=0; i<=nb_monster; i++)); do
				   line_separator_ingame
				   echo ""
				   tableau=("monster1.txt" "monster2.txt" "monster3.txt" "monster4.txt") ; tab_size=${#tableau[@]} ; cat ${tableau[$(( $RANDOM % tab_size ))]}
				   echo ""
				   echo ""
				   x=$(generate_monsters)
				   echo "current monster (hp,str,xp) : $x"
				   stats_p=$(get_player_stats)
				   echo "current Player (hp,str,mana) : $stats_p"
				   fight_PvM $x $stats_p
				   
				   #fight_monster
				done
				;;
			2)
				#CHEST-------------------
				result=2
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
	str_monster=$((RANDOM%str + 3 ))
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
	hp=$?
	get_current_max_str_player
	str=$?
	get_current_max_mana_player
	mana=$?
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
	str=$(cut -d ":" -f 2 <<< "$x")
return $str
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
		echo " Choose an action : "
		echo "      1) Attack (Melee)"
		echo "      2) Block(Slight chance to counter attack)" 
		echo "      3) Run away like a Coward ! "
		read -r -p "Your choice [1..4]" choice
		case ${choice} in
			1)
				echo "you attacked"
				generate_dmg
				dmg=$?
				echo "you dealed $dmg dmg"
				monster_hp=$((monster_hp - dmg))
				echo "hp left monster : $monster_hp"
				;;
			2)
				echo "you blocked"
				;;
			3)
				echo "You ran away from this fight (No XP,No L00T)"
				break
				;;
			*)
				echo "Is it that hard to type a number between 1 and 3 ?"
				;;
		esac
	done

}

line_separator_ingame(){
echo "------------------------------------------------------------"
}

generate_dmg(){
	x=$(sed -n '1p' < stats.txt)
	str=$(cut -d ":" -f 2 <<< "$x")
	echo "YOUR STR : $str"
	str_p=$(echo "$str" | sed 's/-//g')

	dmg=$((RANDOM%str)) #TODO CHANGE DAMAGE RATE1
	return $dmg
}

