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
	case ${options[$index]} in
		NoPlay) 
			;;
		Ladder)
				position=$(($position+$dieValue))
			;;
		Snake)
				position=$(($position-$dieValue))
			;;
	esac
	return $position
}


dieValue=$(rollDie)
checkForOptions $startPosition $dieValue
dest=$?

echo $dest

