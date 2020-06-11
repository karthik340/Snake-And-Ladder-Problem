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
	echo "index = "$index
	case ${options[$index]} in
		NoPlay) 
			;;
		Ladder)
				position=$(($position+$dieValue))
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

while [	$startPosition -le 100 ] 
do
	dieValue=$(rollDie)
	echo 'dieValue = '$dieValue
	checkForOptions $startPosition $dieValue
	dest=$?
	startPosition=$dest
	echo 'startPosition = '$startPosition
done

