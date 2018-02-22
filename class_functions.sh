init_class(){
    touch stats.txt	
	> stats.txt
	
	case ${1} in
        1)
            #warrior-----------------
            echo "str:5">>stats.txt
			echo "mana:2">>stats.txt
			echo "hp:15">>stats.txt
            ;;
        2)
            #thief-------------------
            echo "str:5">>stats.txt
			echo "mana:2">>stats.txt
			echo "hp:15">>stats.txt

            ;;
        3)
            #Mage--------------------
            echo "str:5">>stats.txt
			echo "mana:2">>stats.txt
			echo "hp:15">>stats.txt
            ;;
        4)
            #Ranger------------------
            echo "str:5">>stats.txt
			echo "mana:2">>stats.txt
			echo "hp:15">>stats.txt
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
			   echo "Generating stats..."
			   x=$(generate_monsters)
			   echo "current monster : $x"
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
hp_monster=$((RANDOM%hp + 15 ))
return $hp_monster
}

#*************************************************
# STR MONSTER GENERATION
#*************************************************
generate_str_monster(){
get_current_max_str_player 
str=$?
str_monster=$((RANDOM%str + 15 ))
return $str_monster
}

#*************************************************
# XP MONSTER GENERATION
#*************************************************
generate_xp_monster(){
xp_monster=$((RANDOM%15 + 1))
echo "xp -> $xp_monster"
return $xp_monster
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

