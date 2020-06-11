#!/bin/bash -x
startPosition=0

function rollDie {

	echo $((RANDOM%6+1))

}

result=$(rollDie)
echo $result
