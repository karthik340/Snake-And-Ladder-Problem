#!/bin/bash -x
startPosition=0

function rollDie {

	echo $((RANDOM%6+1))

}

function checkForOptions {
	local position=$1
	local dieValue=$2
	local options=("NoPlay" "Ladder" "Snake")
	local index=$((RANDOM%3))
	echo ${options[$index]}
	case ${options[$index]} in
		NoPlay) 
			;;
		Ladder)
			if [ $(($position+$dieValue)) -le 100 ]
			then
				position=$(($position+$dieValue))
			fi
			;;
		Snake)
			if [ $(($position-$dieValue)) -ge 0 ]
			then
				position=$(($position-$dieValue))
			else
				position=0
			fi
			;;
	esac
	return $position
}


function getNextMove {
	local dieValue=$(rollDie)
	echo 'dieValue = '$dieValue
	local currentPosition=$1
	echo "currentPosition = "$currentPosition
	checkForOptions $currentPosition $dieValue
	local nextPosition=$?
	echo "nextPosition = "$nextPosition
	return $nextPosition
}


player1Position=$startPosition
player2Position=$startPosition
chance=1
countNoOfDies1=0
countNoOfDies2=0
while [ $player1Position -ne 100 -a $player2Position -ne 100 ]
do
	if [ $chance -eq 1 ]
	then
		echo 
		echo "player-1"
		getNextMove $player1Position
		player1Position=$?
		chance=2
		countNoOfDies1=$(($countNoOfDies1+1))
	else	
		echo
		echo "player-2"
		getNextMove $player2Position
		player2Position=$?
		chance=1
		countNoOfDies2=$(($countNoOfDies2+1))
	fi
done

echo
echo "player1 = "$player1Position  
echo "player2 = "$player2Position  

echo 
if [ $player1Position -eq 100 ]
then
	echo "player-1 won match"
	echo "number of dies played by player-1 to win match = "$countNoOfDies1
else
	echo "player-2 won match"
	echo "number of dies played by player-2 to win match = "$countNoOfDies2	
fi






