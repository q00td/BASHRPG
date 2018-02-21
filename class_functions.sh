init_class(){
    touch stats.txt	
	> stats.txt
	
	case ${1} in
        1)
            #warrior-----------------
            echo "str:5">>stats.txt
			echo "mana:2">>stats.txt
			echo "hp:15">>stats.txt
            break
            ;;
        2)
            #thief-------------------
            echo "str:5">>stats.txt
			echo "mana:2">>stats.txt
			echo "hp:15">>stats.txt
            break
            ;;
        3)
            #Mage--------------------
            echo "str:5">>stats.txt
			echo "mana:2">>stats.txt
			echo "hp:15">>stats.txt
            break
            ;;
        4)
            #Ranger------------------
            echo "str:5">>stats.txt
			echo "mana:2">>stats.txt
			echo "hp:15">>stats.txt
            break
            ;;
        *)  #------------------------
            echo "Error : Wrong choice , but i don't know how you managed to do such a mistake .."
            ;;
    esac
}

choose_map(){
rnd=$((RANDOM%3))
case ${rnd} in
        0)
            #MONSTER-----------------
			echo "Oh crap, you encounter some monsters"
            result=1
			return $result
            break
            ;;
        1)
            #CHEST-------------------
			echo "Look a chest !"
			result=2
			return $result
            break
            ;;
        2)
            #TOWN--------------------
			echo "Welcome to Salhem ! "
			result=3
			return $result
            break
            ;;
        *)  #------------------------
            echo "Error : how is it even possible ?"
            ;;
    esac
}