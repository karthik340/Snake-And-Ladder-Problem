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

countNoOfDies=0
currentPosition=$startPosition
while [	$currentPosition -ne 100 ] 
do
	dieValue=$(rollDie)
	countNoOfDies=$(($countNoOfDies+1))
	echo 'dieValue = '$dieValue
	checkForOptions $currentPosition $dieValue
	dest=$?
	currentPosition=$dest
	echo 'Position after die role = '$currentPosition
done

echo "Number of times dies played to win game ="$countNoOfDies 

