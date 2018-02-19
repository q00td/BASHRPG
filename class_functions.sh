init_class(){
    touch stats.txt	
	> stats.txt
	if [ $1 -eq "1" ]
		then
		echo "You chose Warrior"
		echo "str:5">>stats.txt
		echo "mana:2">>stats.txt
		echo "hp:15">>stats.txt

	elif [ $1 -eq "2" ]
		then
		echo "You chose Thief"
		echo "str:5">>stats.txt
		echo "mana:2">>stats.txt
		echo "hp:15">>stats.txt

	elif [ $1 -eq "3" ]
		then
		echo "You chose Mage"
		echo "str:5">>stats.txt
		echo "mana:2">>stats.txt
		echo "hp:15">>stats.txt

	elif [ $1 -eq "4" ]
		then
		echo "You chose Ranger"
		echo "str:5">>stats.txt
		echo "mana:2">>stats.txt
		echo "hp:15">>stats.txt
	fi
}
