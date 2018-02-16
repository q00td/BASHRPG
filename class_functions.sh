init_class(){
	echo $1
	if [ $1 -eq "0" ]
		then
		echo "You chose Warrior"

	elif [ $1 -eq "1" ]
		then
		echo "You chose Thief"

	elif [ $1 -eq "2" ]
		then
		echo "You chose Mage"

	elif [ $1 -eq "3" ]
		then
		echo "You chose Ranger"
	fi
}