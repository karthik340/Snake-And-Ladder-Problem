#!/bin/bash -x
START_POSITION=0

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


function simulateSnakeGame {

local diesCount=0
local flag=1
local count=$1
for (( index=1;index<=count;index++))
do
	player[((index))]=$START_POSITION
done

while [ $flag -eq 1 ]
do
	for (( index=1;index<=count;index++ ))
	do	
		echo
		echo "player-$index"
		getNextMove ${player[$index]}
		player[((index))]=$?
		if [ ${player[$index]} -eq 100 ]
		then
			echo "player- $index won"
			flag=0
			break;
		fi
	done
	diesCount=$(($diesCount+1))
done

echo "number of dies taken to reach 100 = "$diesCount
}

read -p "enter no of players" count
simulateSnakeGame $count


